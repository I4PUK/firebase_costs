import 'package:auto_route/auto_route.dart';
import 'package:firebase_costs/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:firebase_costs/features/dashboard/widgets/add_transaction_dialog.dart';
import 'package:firebase_costs/main.dart';
import 'package:firebase_costs/models/transaction_model.dart';
import 'package:firebase_costs/repositories/auth/auth_repository.dart';
import 'package:firebase_costs/repositories/dashboard/database_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget implements AutoRouteWrapper {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text('Список трат'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () => context.read<DashboardBloc>().add(Logout()),
              child: const Icon(Icons.exit_to_app_rounded),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const AddTransactionDialog(),
          ).then((value) {
            if (value != null && value is TransactionModel) {
              context.read<DashboardBloc>().add(AddTransaction(value));
              context.read<DashboardBloc>().add(FetchContent());
            }
            return;
          });
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (BuildContext context, DashboardState state) {
          final bloc = context.read<DashboardBloc>();

          if (state is DashboardContentState) {
            final transactionsList = state.transactions;
            if (transactionsList.isNotEmpty) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth,
                      maxHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0).add(
                        const EdgeInsets.only(bottom: 60.0),
                      ),
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) => ListTile(
                          title: Text(
                              transactionsList[index].formattedDateAndTime),
                          trailing:
                              Text(transactionsList[index].sum.toString()),
                        ),
                        itemCount: transactionsList.length,
                      ),
                    ),
                  );
                },
              );
            } else {
              return buildUpdateState(
                'Список транзакций пустой',
                () => bloc.add(FetchContent()),
              );
            }
          }
          if (state is LoadingContentState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ErrorState) {
            return buildUpdateState(
              state.errorText,
              () => bloc.add(FetchContent()),
            );
          }

          return buildUpdateState(
            'Незвестная ошибка',
            () => bloc.add(FetchContent()),
          );
        },
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
        Text(text),
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

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(
        authRepository: AuthRepositoryImpl(authService),
        databaseRepository: DatabaseRepositoryImpl(databaseService),
      )..add(FetchContent()),
      child: this,
    );
  }
}
