part of 'dashboard_bloc.dart';

abstract class DashboardState {}

class DashboardContentState implements DashboardState {
  final List<TransactionModel> transactions;

  const DashboardContentState({required this.transactions});
}

class LoadingContentState implements DashboardState {}

class EditItemState implements DashboardState {}

class AddTransactionState implements DashboardState {}

class ErrorState implements DashboardState {
  final String errorText;

  ErrorState(this.errorText);
}
