import 'package:airplane/cubit/seat_cubit.dart';
import 'package:airplane/models/destination_model.dart';
import 'package:airplane/models/transaction_model.dart';
import 'package:airplane/shared/theme.dart';
import 'package:airplane/ui/pages/checkout_page.dart';
import 'package:airplane/ui/widgets/custom_button.dart';
import 'package:airplane/ui/widgets/seat_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChooseSeatPage extends StatelessWidget {
  final DestinationModel destination;
  const ChooseSeatPage(this.destination, {super.key});

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Text(
          'Select Your\nFavorite Seat',
          style: blackTextStyle.copyWith(fontSize: 24, fontWeight: semiBold),
        ),
      );
    }

    Widget status() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Row(
          children: [
            Container(
              width: 16,
              height: 16,
              margin: const EdgeInsets.only(right: 6),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/icon_available.png'),
                ),
              ),
            ),
            Text(
              'Available',
              style: blackTextStyle,
            ),
            Container(
              width: 16,
              height: 16,
              margin: const EdgeInsets.only(right: 6, left: 16),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/icon_selected.png'),
                ),
              ),
            ),
            Text(
              'Selected',
              style: blackTextStyle,
            ),
            Container(
              width: 16,
              height: 16,
              margin: const EdgeInsets.only(right: 6, left: 16),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/icon_unavailable.png'),
                ),
              ),
            ),
            Text(
              'Unavailable',
              style: blackTextStyle,
            ),
          ],
        ),
      );
    }

    Widget selectSeat() {
      return BlocBuilder<SeatCubit, List<String>>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 22),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      child: Center(
                        child: Text(
                          'A',
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            color: kSecondaryColor,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 48,
                      height: 48,
                      child: Center(
                        child: Text(
                          'B',
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            color: kSecondaryColor,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 48,
                      height: 48,
                      child: Center(
                        child: Text(
                          '',
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            color: kSecondaryColor,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 48,
                      height: 48,
                      child: Center(
                        child: Text(
                          'C',
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            color: kSecondaryColor,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 48,
                      height: 48,
                      child: Center(
                        child: Text(
                          'D',
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            color: kSecondaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // NOTE: SEAT 1
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SeatItem(id: 'A1', isAvailable: false),
                      SeatItem(id: 'B1', isAvailable: false),
                      Container(
                        height: 48,
                        width: 48,
                        child: Center(
                          child: Text(
                            '1',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: light,
                            ),
                          ),
                        ),
                      ),
                      SeatItem(id: 'C1'),
                      SeatItem(id: 'D1', isAvailable: false),
                    ],
                  ),
                ),

                // NOTE: SEAT 2
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SeatItem(id: 'A2'),
                      SeatItem(id: 'B2'),
                      Container(
                        height: 48,
                        width: 48,
                        child: Center(
                          child: Text(
                            '2',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: light,
                            ),
                          ),
                        ),
                      ),
                      SeatItem(id: 'C2'),
                      SeatItem(id: 'D2', isAvailable: false),
                    ],
                  ),
                ),

                // NOTE: SEAT 3
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SeatItem(id: 'A3'),
                      SeatItem(id: 'B3'),
                      Container(
                        height: 48,
                        width: 48,
                        child: Center(
                          child: Text(
                            '3',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: light,
                            ),
                          ),
                        ),
                      ),
                      SeatItem(id: 'C3'),
                      SeatItem(id: 'D3'),
                    ],
                  ),
                ),

                // NOTE: SEAT 4
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SeatItem(id: 'A4'),
                      SeatItem(id: 'B4', isAvailable: false),
                      Container(
                        height: 48,
                        width: 48,
                        child: Center(
                          child: Text(
                            '4',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: light,
                            ),
                          ),
                        ),
                      ),
                      SeatItem(id: 'C4'),
                      SeatItem(id: 'D4'),
                    ],
                  ),
                ),

                // NOTE: SEAT 5
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SeatItem(id: 'A5'),
                      SeatItem(id: 'B5'),
                      Container(
                        height: 58,
                        width: 58,
                        child: Center(
                          child: Text(
                            '5',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: light,
                            ),
                          ),
                        ),
                      ),
                      SeatItem(id: 'C5', isAvailable: false),
                      SeatItem(id: 'D5'),
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your seat',
                        style: blackTextStyle.copyWith(
                            color: kSecondaryColor, fontWeight: light),
                      ),
                      Text(
                        state.join(', '),
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: blackTextStyle.copyWith(
                            color: kSecondaryColor, fontWeight: light),
                      ),
                      Text(
                        NumberFormat.currency(locale: 'id', symbol: 'IDR ')
                            .format(state.length * destination.price!),
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          color: kPrimaryColor,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
    }

    Widget checkout() {
      return BlocBuilder<SeatCubit, List<String>>(
        builder: (context, state) {
          return CustomButton(
              title: 'Continiue to Checkout',
              margin: const EdgeInsets.only(top: 30, bottom: 46),
              onPressed: () {
                int price = state.length * destination.price!;
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CheckoutPage(TransactionModel(
                    destination: destination,
                    destinationID: destination.id,
                    amountOfTraveler: state.length,
                    selectedSeats: state.join(', '),
                    insurance: true,
                    refundable: false,
                    vat: 0.45,
                    price: price,
                    grandTotal: price + (price * 0.45).toInt(),
                  ));
                }));
              });
        },
      );
    }

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          title(),
          status(),
          selectSeat(),
          checkout(),
        ],
      ),
    );
  }
}
