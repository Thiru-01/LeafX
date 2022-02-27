import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantix/Widgets/bezier.dart';
import 'package:plantix/models/pricescrapper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import '../constant.dart';
import 'set_ip.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherFactory weather = WeatherFactory(apiKey);

  @override
  void initState() {
    super.initState();
  }

  Future getweathear() async {
    print("1");
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    Weather w = await weather.currentWeatherByLocation(
        position.latitude, position.longitude);
    return w.temperature!.celsius;
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.2;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          GestureDetector(
            child: CustomContainer(
              color: primaryswatch,
              height: height,
            ),
            onDoubleTap: () {
              Get.to(() => IpScreen());
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, right: 25, left: 25),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 5,
                        spreadRadius: 1)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "TODAY'S RATE",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Names",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w900),
                          ),
                          Text(
                            "Quantity",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w900),
                          ),
                          Text(
                            "₹Price",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder<dynamic>(
                        stream: getprice(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.1,
                                  right:
                                      MediaQuery.of(context).size.width * 0.1),
                              height: MediaQuery.of(context).size.height * 0.14,
                              child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  padding: EdgeInsets.only(left: 0, right: 0),
                                  itemBuilder: (BuildContext context, int i) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              "${snapshot.data[i][0].toString()}",
                                              style: TextStyle(
                                                  fontFamily: 'Arial'),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 40),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "${snapshot.data[i][1].toString()}",
                                            style:
                                                TextStyle(fontFamily: 'arial'),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 35,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                              "${snapshot.data[i][2].toString()}",
                                              style: TextStyle(
                                                  fontFamily: 'arial'),
                                              textAlign: TextAlign.left),
                                        ),
                                      ],
                                    );
                                  }),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Padding(
                                padding: const EdgeInsets.all(40),
                                child: CircularProgressIndicator());
                          }

                          return Padding(
                              padding: const EdgeInsets.all(40),
                              child: Text("Something went wrong !!"));
                        })
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, left: 25, right: 25),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 5,
                        spreadRadius: 1)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          "asset/icons/weather.png",
                          fit: BoxFit.fill,
                          isAntiAlias: true,
                          height: 120,
                        ),
                        FutureBuilder(
                            future: getweathear(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }

                              if (snapshot.hasData) {
                                return RichText(
                                    textAlign: TextAlign.right,
                                    text: TextSpan(
                                        text: "Weather\n",
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            color: Colors.black,
                                            fontSize: 45,
                                            fontWeight: FontWeight.w400),
                                        children: [
                                          TextSpan(
                                              text:
                                                  "${double.parse(snapshot.data.toString()).toStringAsFixed(2)}\u2103",
                                              style: TextStyle(
                                                  fontSize: 38,
                                                  fontWeight: FontWeight.w900))
                                        ]));
                              }
                              return Center(
                                child: Text("Somethingwent wrong !!!"),
                              );
                            })
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
