import 'package:airplane/cubit/auth_cubit.dart';
import 'package:airplane/cubit/destination_cubit.dart';
import 'package:airplane/models/destination_model.dart';
import 'package:airplane/shared/theme.dart';
import 'package:airplane/ui/widgets/destination_card.dart';
import 'package:airplane/ui/widgets/destination_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<DestinationCubit>().fetchDestination();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return Container(
              margin: EdgeInsets.only(
                top: 30,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Howdy,\n${state.user.name}',
                        style: blackTextStyle.copyWith(
                            fontSize: 24, fontWeight: semiBold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Where to fly today?',
                        style: blackTextStyle.copyWith(
                          color: kSecondaryColor,
                          fontSize: 16,
                          fontWeight: light,
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/image_profile.png'),
                      ),
                      shape: BoxShape.circle,
                    ),
                  )
                ],
              ),
            );
          }
          return SizedBox();
        },
      );
    }

    Widget populartDestination(List<DestinationModel> destinations) {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: destinations.map((DestinationModel destination) {
              return DestinationCard(destination);
            }).toList(),
          ),
        ),
      );
    }

    Widget newDestination(List<DestinationModel> destinations) {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
          left: defaultMargin,
          right: defaultMargin,
          bottom: 100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New This Year',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: medium,
              ),
            ),
            Column(
                children: destinations.map((DestinationModel destination) {
              return DestinationTile(destination);
            }).toList()),
            // DestinationTile(
            //   imageUrl: 'assets/images/image_destination6.png',
            //   name: 'Danau Berantan',
            //   city: 'Singaraja',
            //   rating: 4.5,
            // ),
            // DestinationTile(
            //   imageUrl: 'assets/images/image_destination7.png',
            //   name: 'Sydney Opera',
            //   city: 'Australia',
            //   rating: 4.7,
            // ),
            // DestinationTile(
            //   imageUrl: 'assets/images/image_destination8.png',
            //   name: 'Roma',
            //   city: 'Italia',
            //   rating: 4.8,
            // ),
          ],
        ),
      );
    }

    return BlocConsumer<DestinationCubit, DestinationState>(
      listener: (context, state) {
        if (state is DestinationFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: kRedColor,
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is DestinationSuccess) {
          return Scaffold(
              body: ListView(
            children: [
              header(),
              populartDestination(state.destniations),
              newDestination(state.destniations),
            ],
          ));
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
