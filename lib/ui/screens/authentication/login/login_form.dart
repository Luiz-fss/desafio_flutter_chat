import 'package:chat_realtime/ui/components/share/custom_elevated_button.dart';
import 'package:chat_realtime/ui/components/share/custom_text_form_field.dart';
import 'package:chat_realtime/utils/validators/email_validator.dart';
import 'package:chat_realtime/utils/validators/password_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubits/auth/auth_cubit.dart';
import '../../../../cubits/auth/cubit_auth_state.dart';
import '../../../../routes/app_routes.dart';
import '../../../components/share/custom_text_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CubitAuth, CubitAuthState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              BlocBuilder<CubitAuth, CubitAuthState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const CircularProgressIndicator();
                  }
                  return CustomElevatedButton(
                    onPressed: _login,
                    text: 'Entrar',
                  );
                },
              ),
              CustomTextButton(
                text: 'Criar conta',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.register);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    context.read<CubitAuth>().login(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }
}
