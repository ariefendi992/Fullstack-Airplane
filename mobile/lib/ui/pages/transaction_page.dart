import 'package:airplane/cubit/transaction_cubit.dart';
import 'package:airplane/shared/theme.dart';
import 'package:airplane/ui/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    context.read<TransactionCubit>().fetchTransaction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoading) {
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        } else if (state is TransactionSuccess) {
          if (state.transactions.length == 0) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                'Kamu belum memiliki transaksi!',
                style:
                    blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              ),
            );
          } else {
            return Scaffold(
                body: ListView.builder(
                    padding: EdgeInsets.only(
                        left: 24, right: 24, top: 30, bottom: 100),
                    itemCount: state.transactions.length,
                    itemBuilder: (context, index) {
                      return TransactionCard(state.transactions[index]);
                    }));
          }
        }
        return Center(
          child: Text(
            'Setting Page',
            style: blackTextStyle.copyWith(
              fontSize: 24,
              fontWeight: medium,
            ),
          ),
        );
      },
    );
  }
}
