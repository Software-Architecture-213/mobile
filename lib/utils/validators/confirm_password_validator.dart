class ConfirmPasswordValidator {
  static String? validate(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please enter the password again';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}
