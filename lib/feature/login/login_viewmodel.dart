import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telluslite/common/base_viewmodel.dart';
import 'package:telluslite/common/validators/fields_validator.dart';
import 'package:telluslite/common/widgets/Dialogs.dart';
import 'package:telluslite/navigation/Routes.dart';
import 'package:telluslite/network/repositories/firebase_auth_repository.dart';
import 'package:telluslite/persistent/repositories/secure_store_repository.dart';

class LoginViewModel extends BaseViewModel {
  String _email;
  String _password;
  bool _obscurePassword = true;

  init(BuildContext context) async{
    var authRepo = FireBaseAuthRepository();

    showLoader();

    bool isUserLogged = await authRepo.isUserLogged();
    bool isDarkMode = await SecureStoreRepository().hasDarkModeSaved();

    hideLoader();

    if(isDarkMode){

    }

    if(isUserLogged){
      goToHome(context);
    }

  }

  onEmailChanged(String email) {
    this._email = email;
  }

  onPasswordChanged(String password) {
    this._password = password;
  }

  onLoginButtonTapped(BuildContext context, GlobalKey<FormState> key) async {
    if (key.currentState.validate()) {
      showLoader();
      var authRepo = FireBaseAuthRepository();
      FirebaseUser user;
      try {
        user = await authRepo.handleSignInEmail(this._email, this._password);
        hideLoader();
      } catch (error) {
        var errorMessage;
        switch (error.code) {
          case "ERROR_OPERATION_NOT_ALLOWED":
            errorMessage = "Anonymous accounts are not enabled";
            break;
          case "ERROR_WEAK_PASSWORD":
            errorMessage = "Your password is too weak";
            break;
          case "ERROR_INVALID_EMAIL":
            errorMessage = "Your email is invalid";
            break;
          case "ERROR_EMAIL_ALREADY_IN_USE":
            errorMessage = "Email is already in use on different account";
            break;
          case "ERROR_INVALID_CREDENTIAL":
            errorMessage = "Your email is invalid";
            break;

          default:
            errorMessage = "An undefined Error happened.";
        }
        hideLoader();
        Dialogs.showDCustomDialog(context, "login error", errorMessage, [
          FlatButton(
            child: Text(
              'Retry',
              style: TextStyle(color: Colors.blueAccent),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ]);
      }

      if (user != null) {
          goToHome(context);
      }
    }
  }

  goToHome(BuildContext context){
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.home, (Route<dynamic> route) => false);
  }

  validateEmail(String email) {
    if (email.isEmpty) {
      return;
    }
    return !FieldValidator.isValidMail(email) ? "email is not valid" : null;
  }

  onObscurePasswordTapped() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  bool get isPasswordObscured => _obscurePassword;
}
