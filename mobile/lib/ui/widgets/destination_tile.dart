import 'package:airplane/models/destination_model.dart';
import 'package:airplane/shared/base_url.dart';
import 'package:airplane/shared/theme.dart';
import 'package:airplane/ui/pages/detail_page.dart';
import 'package:flutter/material.dart';

class DestinationTile extends StatelessWidget {
  final DestinationModel destination;

  const DestinationTile(
    this.destination, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (destination.isNew!) {
      return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DetailPage(destination);
          }));
        },
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(baseUrl + destination.imgUrl),
                  ),
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination.name,
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      destination.city,
                      style: blackTextStyle.copyWith(
                        color: kSecondaryColor,
                        fontWeight: light,
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
                    '${destination.rating}',
                    style: blackTextStyle.copyWith(fontWeight: medium),
                  )
                ],
              )
            ],
          ),
        ),
      );
    }
    return SizedBox();
  }
}
