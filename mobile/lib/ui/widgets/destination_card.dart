import 'package:airplane/models/destination_model.dart';
import 'package:airplane/shared/base_url.dart';
import 'package:airplane/shared/theme.dart';
import 'package:airplane/ui/pages/detail_page.dart';
import 'package:flutter/material.dart';

class DestinationCard extends StatelessWidget {
  final DestinationModel destination;

  final headers = {'Content-Type': 'image/png', 'Connection': 'keep-alive'};

  DestinationCard(
    this.destination, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (destination.isPopular!) {
      return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DetailPage(destination);
          }));
        },
        child: Container(
          width: 200,
          margin: EdgeInsets.only(left: defaultMargin),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 180,
                height: 220,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        // 'http://192.168.1.6:5000/static/images/image_destination3.png',
                        '$baseUrl${destination.imgUrl}',
                        headers: headers,
                      ),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high
                      // onError: (exception, stackTrace) {
                      //   print('Image Exception ${exception.toString()}');
                      //   print('Image StackTrace ${stackTrace.toString()}');
                      // },
                      ),
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 30,
                    width: 55,
                    // padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(defaultRadius),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 2),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/icon_star.png',
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '${destination.rating.toString()}',
                          style: blackTextStyle.copyWith(
                            fontWeight: medium,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
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
                    Text(
                      destination.city,
                      style: blackTextStyle.copyWith(
                        color: kSecondaryColor,
                        fontWeight: light,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
    return SizedBox();
  }
}
