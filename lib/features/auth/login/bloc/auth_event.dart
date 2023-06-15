part of 'auth_bloc.dart';

abstract class AuthEvent {}

class Authorize implements AuthEvent {
  final String email;
  final String password;

  const Authorize({
    required this.email,
    required this.password,
  });
}

class RouteToRegistration implements AuthEvent {}
