part of 'registration_bloc.dart';

abstract class RegistrationState {}

class RegistrationContentState implements RegistrationState {
  final Map<String, String> validationErrors;

  const RegistrationContentState({required this.validationErrors});
}
