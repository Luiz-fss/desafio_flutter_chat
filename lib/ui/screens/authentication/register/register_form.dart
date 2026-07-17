import 'package:chat_realtime/ui/components/share/custom_elevated_button.dart';
import 'package:chat_realtime/ui/components/share/custom_text_form_field.dart';
import 'package:chat_realtime/utils/validators/email_validator.dart';
import 'package:chat_realtime/utils/validators/name_validator.dart';
import 'package:chat_realtime/utils/validators/password_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubits/auth/auth_cubit.dart';
import '../../../../cubits/auth/cubit_auth_state.dart';

import '../../../../cubits/register/cubit_register.dart';
import '../../../../cubits/register/cubit_register_state.dart';

import '../../../../routes/app_routes.dart';

import '../../../components/share/custom_text_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CubitRegister, CubitRegisterState>(
          listener: (context, state) {
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }
          },
        ),
        BlocListener<CubitAuth, CubitAuthState>(
          listener: (context, state) {
            if (state.user != null) {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            }
          },
        ),
      ],
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                label: "Informe seu nome",
                controller: _nameController,
                validator: validateName,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: "Informe seu email",
                controller: _emailController,
                validator: validateEmail,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: "Informe sua senha",
                obscureText: true,
                controller: _passwordController,
                validator: validatePassword,
              ),
              const SizedBox(height: 24),
              BlocBuilder<CubitRegister, CubitRegisterState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const CircularProgressIndicator();
                  }
                  return CustomElevatedButton(
                    text: "Criar conta",
                    onPressed: _register,
                  );
                },
              ),
              CustomTextButton(
                text: "Já tenho uma conta",
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _register() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    context.read<CubitRegister>().register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }
}
