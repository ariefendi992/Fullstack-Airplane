import 'package:airplane/shared/theme.dart';
import 'package:flutter/material.dart';

class InterestItem extends StatelessWidget {
  final String name;
  const InterestItem({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Container(
            height: 16,
            width: 16,
            margin: const EdgeInsets.only(right: 6),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/icon_check.png'))),
          ),
          Text(
            name,
            style: blackTextStyle,
          )
        ],
      ),
    );
  }
}
