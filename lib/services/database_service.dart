import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_costs/main.dart';
import 'package:firebase_costs/models/transaction_model.dart';

class DatabaseService {
  final String _databaseName = 'transactions';
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> postTransaction(TransactionModel transactionModel) async {
    await _db
        .collection(_databaseName)
        .doc(userUid)
        .collection('$_databaseName $userUid')
        .doc(transactionModel.uid)
        .set(transactionModel.toMap());
  }

  Future<List<TransactionModel>> getTransactions() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db
        .collection(_databaseName)
        .doc(userUid)
        .collection('$_databaseName $userUid')
        .get();

    return snapshot.docs
        .map(
            (docSnapshot) => TransactionModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}
