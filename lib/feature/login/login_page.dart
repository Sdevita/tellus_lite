import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telluslite/common/base_widget.dart';
import 'package:telluslite/common/mixin/focus_form.dart';
import 'package:telluslite/feature/login/login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with WidgetsBindingObserver, FocusForm {
  LoginViewModel viewModel;
  var _loginFormKey = GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => viewModel.init(context));
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of(context);
    var mq = MediaQuery.of(context);
    return BaseWidget(
      safeAreaTop: false,
      safeAreaBottom: false,
      loader: viewModel.loader,
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: mq.padding.top + 20),
            child: Container(
              width: 100,
              height: 100,
              child: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(
                    "assets/image/tellusIcon.png",
                  )),
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Hello",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              )),
          Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Sign in to your account",
                style: TextStyle(
                    fontSize: 20, color: Theme.of(context).primaryColor),
              )),
          Container(
            width: mq.size.width,
            height: mq.size.height / 2,
            padding: const EdgeInsets.all(15),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _loginFormKey,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      padding: const EdgeInsets.only(top: 30),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintText: 'Email'),
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        focusNode: _emailFocus,
                        onChanged: (newValue) {
                          viewModel.onEmailChanged(newValue);
                        },
                        validator: (value) {
                          return viewModel.validateEmail(value);
                        },
                        keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (term) {
                          fieldFocusChange(
                              context, _emailFocus, _passwordFocus);
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                hintText: 'Password'),
                            focusNode: _passwordFocus,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                            obscureText: viewModel.isPasswordObscured,
                            onChanged: (newValue) {
                              viewModel.onPasswordChanged(newValue);
                            },
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: () {
                              viewModel.onObscurePasswordTapped();
                            },
                          ),
                        ],
                      ),
                    ),
                    _buildLoginButton(context)
                  ]),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          width: MediaQuery.of(context).size.width / 2,
          child: RaisedButton(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Theme.of(context).buttonColor,
            child: Text(
              'Sign in'.toUpperCase(),
              style:
                  TextStyle(color: Theme.of(context).accentColor, fontSize: 15),
            ),
            onPressed: () {
              viewModel.onLoginButtonTapped(context, _loginFormKey);
            },
          ),
        ));
  }
}
