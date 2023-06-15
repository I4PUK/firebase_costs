import 'package:firebase_costs/core/auth_validator.dart';
import 'package:firebase_costs/main.dart';
import 'package:firebase_costs/models/user_model.dart';
import 'package:firebase_costs/navigation/app_router.dart';
import 'package:firebase_costs/repositories/auth/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthRepository _authenticationRepository;

  Map<String, String> _validationErrors = <String, String>{};

  RegistrationBloc(this._authenticationRepository)
      : super(const RegistrationContentState(validationErrors: {})) {
    on<Register>(_onRegister);
    on<RouteToAuth>(_onRouteToAuth);
  }

  Future<void> _onRegister(Register event, Emitter emit) async {
    _validationErrors = AuthValidator.validateAuthScreen(
      email: event.email,
      password: event.password,
    );

    if (_validationErrors.isNotEmpty) {
      emit(RegistrationContentState(validationErrors: _validationErrors));
    } else {
      final user = UserModel(
        displayName: event.name,
        email: event.email,
        password: event.password,
      );

      try {
        final userCred = await _authenticationRepository.signUp(user);

        print(userCred?.additionalUserInfo!.providerId);
        print(userCred?.additionalUserInfo!.username);
        print(userCred?.additionalUserInfo!.profile);

        router.push(const DashboardRoute());
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<void> _onRouteToAuth(RouteToAuth event, Emitter emit) async {
    try {
      await _authenticationRepository.signOut();
      router.pop();
    } catch (e) {
      print(e.toString());
    }
  }
}
