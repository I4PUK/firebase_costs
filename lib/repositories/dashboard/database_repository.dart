import 'package:firebase_costs/models/transaction_model.dart';
import 'package:firebase_costs/services/database_service.dart';

abstract class DatabaseRepository {
  Future<void> addTransaction(TransactionModel transaction);
  Future<List<TransactionModel>> loadTransactionList();
}

class DatabaseRepositoryImpl implements DatabaseRepository {
  DatabaseService databaseService;

  DatabaseRepositoryImpl(this.databaseService);

  @override
  Future<void> addTransaction(TransactionModel transaction) {
    return databaseService.postTransaction(transaction);
  }

  @override
  Future<List<TransactionModel>> loadTransactionList() async {
    return databaseService.getTransactions();
  }
}
