import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_costs/models/transaction_model.dart';
import 'package:flutter/material.dart';

class AddTransactionDialog extends StatefulWidget {
  const AddTransactionDialog({super.key});

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  late TextEditingController sumTextFieldController;

  @override
  void initState() {
    super.initState();
    sumTextFieldController = TextEditingController();
  }

  @override
  void dispose() {
    sumTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить транзакцию'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: sumTextFieldController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Сумма',
            ),
          ),
          const SizedBox(height: 32.0),
          SizedBox(
            width: 250.0,
            child: ElevatedButton(
              onPressed: () => context.router.pop(
                TransactionModel(
                  dateAndTime: Timestamp.now(),
                  sum: int.tryParse(
                    sumTextFieldController.text,
                  ),
                ),
              ),
              child: const Text('Добавить'),
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: 250.0,
            child: GestureDetector(
              onTap: () => context.router.pop(),
              child: const Text(
                'Назад',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildUpdateState(
    String text,
    Function() onPressed,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Неизвестная ошибка'),
        const SizedBox(height: 16.0),
        Center(
          child: ElevatedButton(
            onPressed: () => onPressed,
            child: const Text('Загрузить данные'),
          ),
        )
      ],
    );
  }
}
