import 'package:flutter_test/flutter_test.dart';

import 'package:chat_realtime/cubits/auth/cubit_auth.dart';

import '../../mocks/fake_auth_repository.dart';


void main() {


  group('CubitAuth', () {


    test(
      'deve realizar login com sucesso',
          () async {

        final repository = FakeAuthRepository();

        final cubit = CubitAuth(repository);


        await cubit.login(
          email: 'teste@email.com',
          password: '123456',
        );


        expect(
          cubit.state.errorMessage,
          isNull,
        );


        cubit.close();

      },
    );



    test(
      'deve retornar erro quando login falhar',
          () async {

        final repository = FakeAuthRepository();

        repository.shouldFailLogin = true;


        final cubit = CubitAuth(repository);


        await cubit.login(
          email: 'teste@email.com',
          password: '123456',
        );


        expect(
          cubit.state.errorMessage,
          isNotNull,
        );


        cubit.close();

      },
    );


  });

}