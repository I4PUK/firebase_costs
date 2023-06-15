import 'package:firebase_costs/features/auth/registration/bloc/registration_bloc.dart';
import 'package:firebase_costs/main.dart';
import 'package:firebase_costs/repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late TextEditingController nameTextFieldController;
  late TextEditingController emailTextFieldController;
  late TextEditingController passwordTextFieldController;

  @override
  void initState() {
    super.initState();
    nameTextFieldController = TextEditingController();
    emailTextFieldController = TextEditingController();
    passwordTextFieldController = TextEditingController();
  }

  @override
  void dispose() {
    nameTextFieldController.dispose();
    emailTextFieldController.dispose();
    passwordTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(AuthRepositoryImpl(authService)),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<RegistrationBloc, RegistrationState>(
          builder: (BuildContext context, RegistrationState state) {
            if (state is RegistrationContentState) {
              final bloc = context.read<RegistrationBloc>();

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Регистрация'),
                    const SizedBox(height: 60.0),
                    TextField(
                      controller: nameTextFieldController,
                      decoration: InputDecoration(
                        hintText: 'Имя',
                        errorText: state.validationErrors['name'],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: emailTextFieldController,
                      decoration: InputDecoration(
                        hintText: 'Электронная почта',
                        errorText: state.validationErrors['email'],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: passwordTextFieldController,
                      decoration: InputDecoration(
                        hintText: 'Пароль',
                        errorText: state.validationErrors['password'],
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    SizedBox(
                      width: 250.0,
                      child: ElevatedButton(
                        onPressed: () {
                          bloc.add(
                            Register(
                              name: nameTextFieldController.text,
                              email: emailTextFieldController.text,
                              password: passwordTextFieldController.text,
                            ),
                          );
                        },
                        child: const Text('Зарегистрироваться'),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    InkWell(
                      onTap: () {
                        bloc.add(
                          RouteToAuth(),
                        );
                      },
                      child: const Text('Назад'),
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
