import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_costs/core/extensions/string_extension.dart';
import 'package:intl/intl.dart';

class TransactionModel {
  String? uid;
  Timestamp? dateAndTime;
  int? sum;

  TransactionModel({
    this.uid,
    this.dateAndTime,
    this.sum,
  });

  Map<String, dynamic> toMap() {
    return {
      'dateAndTime': dateAndTime,
      'sum': sum,
    };
  }

  String get formattedDateAndTime {
    if (dateAndTime != null) {
      return DateFormat('EEEE, HH:mm, dd MMMM yyyy', 'ru_RU')
          .format(
            dateAndTime!.toDate(),
          )
          .capitalize();
    } else {
      return 'Отсутствует дата';
    }
  }

  TransactionModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : uid = doc.id,
        dateAndTime = doc.data()!["dateAndTime"],
        sum = doc.data()!["sum"];

  TransactionModel copyWith({
    String? uid,
    Timestamp? dateAndTime,
    int? sum,
  }) {
    return TransactionModel(
      uid: uid ?? this.uid,
      dateAndTime: dateAndTime ?? this.dateAndTime,
      sum: sum ?? this.sum,
    );
  }
}
