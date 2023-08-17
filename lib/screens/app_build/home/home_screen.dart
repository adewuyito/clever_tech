import 'dart:developer';

import 'package:clever_tech/data/colors.dart';
import 'package:clever_tech/services/location_service.dart';
import 'package:clever_tech/services/location_weather_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../../../services/device_date_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Radius radius_6 = const Radius.circular(4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorGrey,
      body: ListView(
        children: [
          Column(
            children: [
              /// Container
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: radius_6,
                    bottomRight: radius_6,
                  ),
                ),
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    LongWidget(color_1: colorBlue),
                    const SizedBox(
                      width: 10,
                    ),
                    ShortWidget(color_1: colorGreen),
                  ],
                ),
              ),

              ///Favourite Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(radius_6),
                ),
                margin: const EdgeInsets.only(bottom: 10),
                // padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10, left: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Favorite scenes',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 24),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'View all',
                              style: TextStyle(
                                  color: colorGrey,
                                  fontSize: 11,
                                  letterSpacing: 0.07),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const CustomList(),
                    const Divider(),
                    const CustomList(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LongWidget extends StatefulWidget {
  final Color color_1;

  const LongWidget({super.key, required this.color_1});

  @override
  State<LongWidget> createState() => _LongWidgetState();
}

class _LongWidgetState extends State<LongWidget> {
  final dateFormat = DateDay();
  String? _currentAddress = 'N/A';
  double? longitude;
  double? latitude;
  Position? position;
  Position? _currentPosition;
  final locationService = UserLocation();

  _getCurrentLocation() async {
    bool isAllowed = await locationService.handleLocationPermission();
    try{
      if(isAllowed){
        Position? getPosition =  await locationService.getPosition();
          setState(() {
            _currentPosition = getPosition;
            _getAddress(_currentPosition);
          });
      } else {
        throw LocationServiceDeniedException();
      }
    }catch (e){
      log(e.toString());
    }
  }

  _getAddress(Position? position) async {
    try {
      if (position != null){
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        Placemark place = placemarks[0];
        setState(() {
          _currentAddress = place.locality;
        });
      } else {
        throw LocationPositionCouldNotBeResolved();
      }

    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          color: widget.color_1,
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dateFormat.getDay(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      dateFormat.getDate(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 4),
                      child: const Icon(
                        Icons.cloud,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                    const Text(
                      'Cloudless',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 4),
                        child: const Icon(
                          Icons.location_on_rounded,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      Text(
                        _currentAddress!,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  '19°',
                  style: TextStyle(
                    height: 1,
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                    // fontFamily: 'SFTS',
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ShortWidget extends StatelessWidget {
  final Color color_1;

  const ShortWidget({super.key, required this.color_1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          color: color_1,
        ),
        padding: const EdgeInsets.all(12),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Usage',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  '2.24',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 34,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'kWh',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Icon(
                      Icons.ssid_chart_rounded,
                      color: Colors.white,
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TabWidget extends StatelessWidget {
  final VoidCallback? onPressed;

  const TabWidget({super.key, this.onPressed});

  action(VoidCallback? button) {
    return button = onPressed ?? () {};
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action(onPressed),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.9),
                borderRadius: const BorderRadius.all(Radius.circular(22))),
            width: 58,
            height: 55,
            child: const Icon(Icons.home),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Leave Home',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('28 Jun',
                      style: TextStyle(color: colorGrey, fontSize: 12)),
                  Container(
                    margin: const EdgeInsets.only(left: 5, right: 2),
                    child: Icon(Icons.access_time_filled_rounded,
                        color: colorGrey, size: 14),
                  ),
                  Text('2:30 pm',
                      style: TextStyle(color: colorGrey, fontSize: 12)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CustomList extends StatelessWidget {
  final VoidCallback? onPressed;

  const CustomList({super.key, this.onPressed});

  action(VoidCallback? button) {
    return button = onPressed ?? () {};
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // dense: false,
      leading: Container(
        // margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.9),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        width: 45,
        height: 43,
        child: const Icon(
          Icons.home,
          color: Colors.white,
        ),
      ),
      title: const Text(
        'Leave home',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('28 Jun', style: TextStyle(color: colorGrey, fontSize: 12)),
          Container(
            margin: const EdgeInsets.only(left: 5, right: 2),
            child: Icon(Icons.access_time_filled_rounded,
                color: colorGrey, size: 14),
          ),
          Text('2:30 pm', style: TextStyle(color: colorGrey, fontSize: 12)),
        ],
      ),
      onTap: () {},
    );
  }
}

class CardWidget extends StatefulWidget {
  const CardWidget({
    super.key,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final int devicePresent = 0;
  final int deviceActive = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                'assets/images/image_a.jpg',
                fit: BoxFit.fill,
                alignment: AlignmentDirectional.centerEnd,
                // height: 80,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Living Room',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'SFTS',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: devicePresent.toString(),
                                style: TextStyle(
                                    color: colorBlack2,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11),
                              ),
                              TextSpan(
                                text: " devices",
                                style: TextStyle(
                                  color: colorGrey2,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
