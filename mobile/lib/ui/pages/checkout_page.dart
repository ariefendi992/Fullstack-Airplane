import 'package:airplane/cubit/auth_cubit.dart';
import 'package:airplane/cubit/seat_cubit.dart';
import 'package:airplane/cubit/transaction_cubit.dart';
import 'package:airplane/models/transaction_model.dart';
import 'package:airplane/shared/base_url.dart';
import 'package:airplane/shared/theme.dart';
import 'package:airplane/ui/widgets/booking_detail_item.dart';
import 'package:airplane/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends StatelessWidget {
  final TransactionModel transaction;
  const CheckoutPage(this.transaction, {super.key});

  @override
  Widget build(BuildContext context) {
    Widget route() {
      return Container(
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Container(
              height: 65,
              width: 291,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/image_checkout.png'),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CGK',
                        style: blackTextStyle.copyWith(
                          fontSize: 24,
                          fontWeight: semiBold,
                        ),
                      ),
                      Text(
                        'Tanggerang',
                        style: blackTextStyle.copyWith(
                          fontWeight: light,
                          color: kSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'TLC',
                      style: blackTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: semiBold,
                      ),
                    ),
                    Text(
                      'Ciliwung',
                      style: blackTextStyle.copyWith(
                        fontWeight: light,
                        color: kSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget bookingDetails() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      // image: AssetImage('assets/images/image_destination1.png'),
                      image: NetworkImage(
                          '$baseUrl${transaction.destination!.imgUrl}'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${transaction.destination!.name}',
                        style: blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: medium,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${transaction.destination!.city}',
                        style: blackTextStyle.copyWith(
                          fontWeight: light,
                          color: kSecondaryColor,
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.only(right: 2),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/icon_star.png'),
                        ),
                      ),
                    ),
                    Text(
                      '${transaction.destination!.rating}',
                      style: blackTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    )
                  ],
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                'Booking Details',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ),
            BookingDetailItem(
              title: 'Traveler',
              value: '${transaction.amountOfTraveler} person',
              valueColor: kBlackColor,
            ),
            BookingDetailItem(
              title: 'Seat',
              value: '${transaction.selectedSeats}',
              valueColor: kBlackColor,
            ),
            BookingDetailItem(
              title: 'Insurance',
              value: transaction.insurance == true ? 'YES' : 'NO',
              valueColor:
                  transaction.insurance == true ? kGreenColor : kRedColor,
            ),
            BookingDetailItem(
              title: 'Refundable',
              value: transaction.refundable != true ? 'NO' : 'YES',
              valueColor:
                  transaction.refundable != true ? kRedColor : kGreenColor,
            ),
            BookingDetailItem(
              title: 'VAT',
              value: '${transaction.vat}',
              valueColor: kBlackColor,
            ),
            BookingDetailItem(
              title: 'Price',
              value: NumberFormat.currency(
                      locale: 'id', symbol: 'IDR ', decimalDigits: 0)
                  .format(transaction.price),
              valueColor: kBlackColor,
            ),
            BookingDetailItem(
              title: 'Grand Total',
              value: NumberFormat.currency(
                      locale: 'id', symbol: 'IDR ', decimalDigits: 0)
                  .format(transaction.grandTotal),
              valueColor: kPrimaryColor,
            ),
          ],
        ),
      );
    }

    Widget paymentDetails() {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return Container(
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Details',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 70,
                        margin: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/image_card.png'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(defaultRadius),
                          boxShadow: [
                            BoxShadow(
                                color: kPrimaryColor.withOpacity(0.5),
                                offset: Offset(0, 10),
                                blurRadius: 50)
                          ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 24,
                                width: 24,
                                margin: const EdgeInsets.only(right: 6),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/icon_plane.png'),
                                  ),
                                ),
                              ),
                              Text(
                                'Pay',
                                style: whiteTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: medium,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'IDR ',
                                      decimalDigits: 0)
                                  .format(state.user.balance),
                              style: blackTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: medium,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Current Balance',
                              style: blackTextStyle.copyWith(
                                fontWeight: light,
                                color: kSecondaryColor,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }
          return SizedBox();
        },
      );
    }

    Widget payButton() {
      return BlocConsumer<TransactionCubit, TransactionState>(
        listener: (context, state) {
          if (state is TransactionSuccess) {
            context.read<SeatCubit>().resetSeat();
            Navigator.pushNamedAndRemoveUntil(
                context, '/success', (route) => false);
          } else if (state is TransactionFailed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.error,
                style: whiteTextStyle.copyWith(
                  fontWeight: medium,
                ),
              ),
              backgroundColor: kRedColor,
            ));
          }
        },
        builder: (context, state) {
          if (state is TransactionLoading) {
            Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
          return CustomButton(
              title: 'Pay Now',
              margin: const EdgeInsets.symmetric(vertical: 30),
              width: double.infinity,
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return SuccessCheckoutPage();
                // }));

                context.read<TransactionCubit>().createTransaction(transaction);
              });
        },
      );
    }

    Widget tacButton() {
      return Container(
        margin: const EdgeInsets.only(bottom: 30),
        alignment: Alignment.center,
        child: Text(
          'Terms and Conditions',
          style: blackTextStyle.copyWith(
            color: kSecondaryColor,
            fontWeight: light,
            fontSize: 16,
            decoration: TextDecoration.underline,
          ),
        ),
      );
    }

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          route(),
          bookingDetails(),
          paymentDetails(),
          payButton(),
          tacButton(),
        ],
      ),
    );
  }
}
