class Validator {
  Validator._();

  static String? nameValidator(String? name) {
    name = name?.trim() ?? '';

    return name.isEmpty ? 'No name Provided' : null;
  }

  static const String _emailPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static String? emailValidator(String? email) {
    email = email?.trim() ?? '';

    return email.isEmpty
        ? 'No email Provided'
        : !RegExp(_emailPattern).hasMatch(email)
            ? 'Email is not in the valid format'
            : null;
  }

  static String? passwordValidator(String? password) {
    password = password ?? '';

    String errorMessage = '';
    if (password.isEmpty) {
      errorMessage = 'No password Provided';
    } else if (password.length < 6) {
      errorMessage = 'Password should be at least 6 characters';
    }

    if (!password.contains(RegExp(r'[a-z]'))) {
      errorMessage =
          '$errorMessage\nPassword should contain at least one lowercase letter';
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      errorMessage =
          '$errorMessage\nPassword should contain at least one uppercase letter';
    }

    if (!password.contains(RegExp(r'[0-9]'))) {
      errorMessage =
          '$errorMessage\nPassword should contain at least one number';
    }

    return errorMessage.isNotEmpty ? errorMessage.trim() : null;
  }
}
