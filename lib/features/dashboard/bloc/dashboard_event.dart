part of 'dashboard_bloc.dart';

abstract class DashboardEvent {}

class AddTransaction implements DashboardEvent {
  final TransactionModel transaction;

  AddTransaction(this.transaction);
}

class FetchContent implements DashboardEvent {}

class RouteToAddTransaction implements DashboardEvent {}

class Logout implements DashboardEvent {}
