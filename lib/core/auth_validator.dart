import 'package:firebase_costs/core/reg_exp_constants.dart';
import 'package:firebase_costs/core/reg_exp_validator.dart';

class AuthValidator {
  static Map<String, String> validateAuthScreen({
    required String email,
    required String password,
  }) {
    const requiredFieldText = 'Поле обязательно для заполнения';
    const incorrectEmailText = 'Некорректный email';
    const incorrectPasswordLengthText = 'Пароль должен быть более 6 символов';

    final Map<String, String> errors = <String, String>{};
    if (email.isEmpty) {
      errors['email'] = requiredFieldText;
    } else if (!isEmailValid(email)) {
      errors['email'] = incorrectEmailText;
    }

    if (password.isEmpty) {
      errors['password'] = requiredFieldText;
    } else if (password.length < 6) {
      errors['password'] = incorrectPasswordLengthText;
    }
    return errors..removeWhere((_, String? value) => value == null);
  }

  static bool isEmailValid(String email) {
    return RegExpValidator.regexValidator(
      regexPattern: RegExpConstants.emailRegExp,
      value: email,
    );
  }
}
