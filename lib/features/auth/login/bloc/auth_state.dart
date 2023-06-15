part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthContentState implements AuthState {
  final Map<String, String> validationErrors;

  const AuthContentState({required this.validationErrors});
}
