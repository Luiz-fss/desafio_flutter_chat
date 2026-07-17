import 'package:flutter_test/flutter_test.dart';
import 'package:chat_realtime/utils/validators/email_validator.dart';

void main() {

  group('Email Validator', () {

    test(
      'deve retornar erro quando email estiver vazio',
          () {
        final result = validateEmail('');

        expect(result, isNotNull);
      },
    );


    test(
      'deve retornar erro quando email for inválido',
          () {
        final result = validateEmail(
          'usuario@email',
        );

        expect(result, isNotNull);
      },
    );


    test(
      'deve aceitar email válido',
          () {
        final result = validateEmail(
          'usuario@email.com',
        );

        expect(result, isNull);
      },
    );

  });

}