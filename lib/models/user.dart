class User {
  String? _email;
  String? _password;
  String? _secretKey;

  void setEmail(String? email) {
    _email = email;
  }

  void setPassword(String? password) {
    _password = password;
  }

  void setSecretKey(String? secretKey) {
    _secretKey = secretKey;
  }

  String? getEmail() {
    return _email;
  }

  String? getPassword() {
    return _password;
  }

  String? getSecretKey() {
    return _secretKey;
  }
}
