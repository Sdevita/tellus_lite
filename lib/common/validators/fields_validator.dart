class FieldValidator{

  static final _isDigit = RegExp(r'^[0-9]+$');

  static final RegExp _emailRegExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static final RegExp _passwordRegExp = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?+&:_;-])[A-Za-z\d$@$!%*#?+&:_;-]{8,}$');

  static isValidMail(String email) {
    return _emailRegExp.hasMatch(email);
  }
}