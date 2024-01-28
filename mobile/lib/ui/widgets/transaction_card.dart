import 'package:airplane/models/transaction_model.dart';
import 'package:airplane/shared/base_url.dart';
import 'package:airplane/shared/theme.dart';
import 'package:airplane/ui/widgets/booking_detail_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionCard(this.transaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(defaultRadius),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
        ),
      ),
    );
  }
}
