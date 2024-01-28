import 'package:airplane/shared/theme.dart';
import 'package:flutter/material.dart';

class BookingDetailItem extends StatelessWidget {
  final String title;
  final String value;
  final Color valueColor;
  const BookingDetailItem({
    super.key,
    required this.title,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            margin: const EdgeInsets.only(right: 6),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/icon_check.png'),
              ),
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: blackTextStyle,
            ),
          ),
          Text(
            value,
            style: blackTextStyle.copyWith(
              fontWeight: semiBold,
              color: valueColor,
            ),
          )
        ],
      ),
    );
  }
}
