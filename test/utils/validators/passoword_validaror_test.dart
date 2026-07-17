import 'package:flutter_test/flutter_test.dart';
import 'package:chat_realtime/utils/validators/password_validator.dart';

void main() {

  group('Password Validator', () {

    test(
      'deve retornar erro quando senha estiver vazia',
          () {
        final result = validatePassword('');

        expect(result, isNotNull);
      },
    );


    test(
      'deve retornar erro quando senha for menor que o permitido',
          () {
        final result = validatePassword(
          '123',
        );

        expect(result, isNotNull);
      },
    );


    test(
      'deve aceitar senha válida',
          () {
        final result = validatePassword(
          '123456',
        );

        expect(result, isNull);
      },
    );

  });

}