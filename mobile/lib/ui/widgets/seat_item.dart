import 'package:airplane/cubit/seat_cubit.dart';
import 'package:airplane/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatItem extends StatelessWidget {
  final String id;
  final bool isAvailable;

  const SeatItem({super.key, required this.id, this.isAvailable = true});

  @override
  Widget build(BuildContext context) {
    bool isSelected = context.watch<SeatCubit>().isSelected(id);

    bgColor() {
      if (!isAvailable) {
        return kUnavailableColor;
      } else {
        if (isSelected) {
          return kPrimaryColor;
        } else {
          return kAvailableColor;
        }
      }
    }

    borderColor() {
      if (!isAvailable) {
        return kUnavailableColor;
      } else {
        return kPrimaryColor;
      }
    }

    child() {
      if (isSelected) {
        return Center(
          child: Text(
            'YOU',
            style: whiteTextStyle.copyWith(fontWeight: semiBold),
          ),
        );
      } else {
        return SizedBox();
      }
    }

    return GestureDetector(
      onTap: !isAvailable
          ? () {}
          : () {
              context.read<SeatCubit>().selectSeat(id);
            },
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: bgColor(),
          border: Border.all(
            color: borderColor(),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: child(),
      ),
    );
  }
}
