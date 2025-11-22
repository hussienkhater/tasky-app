const String emailRegex =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

const String passwordRegex = r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d@]{6,}$';

const String usernameRegex = r'^[a-zA-Z0-9,.-]+$';

abstract class Validator {
  static String? validateEmail(String? val) {
    final RegExp regExp = RegExp(emailRegex);
    if (val == null || val.trim().isEmpty) {
      return 'Email cannot be empty';
    } else if (!regExp.hasMatch(val)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? val) {
    final RegExp regExp = RegExp(passwordRegex);
    if (val == null || val.isEmpty) {
      return 'Password cannot be empty';
    } else if (!regExp.hasMatch(val)) {
      return 'Password must be at least 6 characters,\ninclude a number and an uppercase letter';
    }
    return null;
  }

  static String? validateConfirmPassword(String? val, String? password) {
    if (val == null || val.isEmpty) {
      return 'Confirm password cannot be empty';
    } else if (val != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateName(String? val) {
    if (val == null || val.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

  static String? validatePhoneNumber(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Phone number cannot be empty';
    }
    final phone = val.trim();
    final isValid = RegExp(r'^\+?\d+$').hasMatch(phone);
    if (!isValid || phone.length != 13) {
      return 'Enter a valid phone number (e.g. +201234567890)';
    }
    return null;
  }

  static String? validateCode(String? val) {
    if (val == null || val.isEmpty) {
      return 'Code cannot be empty';
    } else if (val.length < 6) {
      return 'Code should be at least 6 digits';
    }
    return null;
  }
}