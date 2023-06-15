import 'package:firebase_costs/core/auth_validator.dart';
import 'package:firebase_costs/main.dart';
import 'package:firebase_costs/models/user_model.dart';
import 'package:firebase_costs/navigation/app_router.dart';
import 'package:firebase_costs/repositories/auth/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authenticationRepository;

  Map<String, String> _validationErrors = <String, String>{};

  AuthBloc(this._authenticationRepository)
      : super(const AuthContentState(validationErrors: {})) {
    on<Authorize>(_onAuthorize);
    on<RouteToRegistration>(_onRouteToRegistration);
  }

  Future<void> _onAuthorize(Authorize event, Emitter emit) async {
    _validationErrors = AuthValidator.validateAuthScreen(
      email: event.email,
      password: event.password,
    );

    if (_validationErrors.isNotEmpty) {
      emit(AuthContentState(validationErrors: _validationErrors));
    } else {
      final user = UserModel(
        email: event.email,
        password: event.password,
      );

      try {
        await _authenticationRepository.signIn(user);
        router.replaceAll([const DashboardRoute()]);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<void> _onRouteToRegistration(
    RouteToRegistration event,
    Emitter emit,
  ) async {
    router.push(const RegistrationRoute());
  }
}
