import 'dart:core';

class FormFieldValidators {
  static String? validateSqlFormField(String? value) =>
      value!.isEmpty ? 'Text field must not be empty' : null;
}
