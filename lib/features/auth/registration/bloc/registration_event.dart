part of 'registration_bloc.dart';

abstract class RegistrationEvent {}

class Register implements RegistrationEvent {
  final String name;
  final String email;
  final String password;

  const Register({
    required this.name,
    required this.email,
    required this.password,
  });
}

class RouteToAuth implements RegistrationEvent {}
