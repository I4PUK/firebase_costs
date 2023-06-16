import 'package:firebase_costs/core_ui/widgets/app_password_field.dart';
import 'package:firebase_costs/features/auth/login/bloc/auth_bloc.dart';
import 'package:firebase_costs/main.dart';
import 'package:firebase_costs/repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late TextEditingController emailTextFieldController;
  late TextEditingController passwordTextFieldController;

  @override
  void initState() {
    super.initState();
    emailTextFieldController = TextEditingController();
    passwordTextFieldController = TextEditingController();
  }

  @override
  void dispose() {
    emailTextFieldController.dispose();
    passwordTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(AuthRepositoryImpl(authService)),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (BuildContext context, AuthState state) {
            if (state is AuthContentState) {
              final bloc = context.read<AuthBloc>();

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Войдите или зарегистрируйтесь'),
                    const SizedBox(height: 60.0),
                    TextField(
                      controller: emailTextFieldController,
                      decoration: InputDecoration(
                        hintText: 'Электронная почта',
                        errorText: state.validationErrors['email'],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    AppPasswordField(
                      controller: passwordTextFieldController,
                      hintText: 'Пароль',
                      errorText: state.validationErrors['password'],
                    ),
                    const SizedBox(height: 32.0),
                    SizedBox(
                      width: 250.0,
                      child: ElevatedButton(
                        onPressed: () {
                          bloc.add(
                            Authorize(
                              email: emailTextFieldController.text,
                              password: passwordTextFieldController.text,
                            ),
                          );
                        },
                        child: const Text('Войти'),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    InkWell(
                      onTap: () {
                        bloc.add(RouteToRegistration());
                      },
                      child: const Text('Зарегистрироваться'),
                    )
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
