class Contact {
  String? _name;
  String? _phone;
  String? _email;

  void setName(String? name) {
    _name = name;
  }

  void setPhone(String? phone) {
    _phone = phone;
  }

  void setEmail(String? email) {
    _email = email;
  }

  String? getName() {
    return _name;
  }

  String? getPhone() {
    return _phone;
  }

  String? getEmail() {
    return _email;
  }
}
