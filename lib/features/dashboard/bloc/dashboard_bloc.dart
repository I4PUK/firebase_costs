import 'package:firebase_costs/main.dart';
import 'package:firebase_costs/models/transaction_model.dart';
import 'package:firebase_costs/navigation/app_router.dart';
import 'package:firebase_costs/repositories/auth/auth_repository.dart';
import 'package:firebase_costs/repositories/dashboard/database_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  AuthRepository _authRepository;
  DatabaseRepository _databaseRepository;

  List<TransactionModel>? _transactions;

  DashboardBloc({
    required AuthRepository authRepository,
    required DatabaseRepository databaseRepository,
  })  : _authRepository = authRepository,
        _databaseRepository = databaseRepository,
        super(const DashboardContentState(transactions: [])) {
    on<AddTransaction>(_onAddTransaction);
    on<RouteToAddTransaction>(_onRouteTransaction);
    on<FetchContent>(_onFetchContent);
    on<Logout>(_onLogout);
  }

  Future<void> _onRouteTransaction(
      RouteToAddTransaction event, Emitter emit) async {
    emit(AddTransactionState());
  }

  Future<void> _onAddTransaction(AddTransaction event, Emitter emit) async {
    emit(LoadingContentState());
    try {
      await _databaseRepository.addTransaction(event.transaction);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _onFetchContent(_, Emitter emit) async {
    emit(LoadingContentState());
    try {
      final loadedData = await _databaseRepository.loadTransactionList();
      _transactions = loadedData;
      _transactions?.sort((previous, current) =>
          current.dateAndTime!.compareTo(previous.dateAndTime!));
    } catch (e) {
      emit(ErrorState(e.toString()));
    } finally {
      emit(DashboardContentState(transactions: _transactions ?? []));
    }
  }

  Future<void> _onLogout(Logout event, Emitter emit) async {
    _authRepository.signOut();
    router.replaceAll([const AuthRoute()]);
  }
}
