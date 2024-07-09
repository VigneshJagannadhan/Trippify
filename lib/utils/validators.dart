String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email address.';
  }

  String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Please enter a valid email address.';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password.';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long.';
  }
  // bool hasUppercase = value.contains(RegExp(r'[A-Z]'));
  // bool hasDigits = value.contains(RegExp(r'[0-9]'));
  // bool hasSpecialCharacters = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  // if (!hasUppercase || !hasDigits || !hasSpecialCharacters) {
  //   return 'Password must contain at least one uppercase letter, one digit, and one special character.';
  // }

  return null;
}
