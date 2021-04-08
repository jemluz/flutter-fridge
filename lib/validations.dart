import 'package:flutter/cupertino.dart';

class Validation {
  static bool isValidImageUrl(String url) {
    bool startsWithHttp = url.toLowerCase().startsWith('http://');
    bool startsWithHttps = url.toLowerCase().startsWith('https://');

    bool endsWithPng = url.toLowerCase().endsWith('.png');
    bool endsWithJpg = url.toLowerCase().endsWith('.jpg');
    bool endsWithJpeg = url.toLowerCase().endsWith('.jpeg');

    return (startsWithHttp || startsWithHttps) &&
        (endsWithPng || endsWithJpg || endsWithJpeg);
  }

  static String nameValidation(String string) {
    bool isEmpty = string.trim().isEmpty;
    bool isLessThanThree = string.trim().length < 3;

    if (isEmpty) return 'Preencha este campo.';
    if (isLessThanThree) return 'O nome de ter no mínimo 3 letras.';

    return null;
  }

  static String amountValidation(String string) {
    bool isEmpty = string.trim().isEmpty;

    if (isEmpty) return 'Preencha este campo.';

    return null;
  }

  static String imgSrcValidation(String string) {
    bool isEmpty = string.trim().isEmpty;
    bool isInvalid = !isValidImageUrl(string);

    if (isEmpty) return 'Preencha este campo.';
    if (isInvalid) return 'Informa uma ULR válida.';

    return null;
  }

  static validateForm(GlobalKey<FormState> key) {
    bool isValid = key.currentState.validate();

    if (!isValid) {
      return;
    }
  }
}
