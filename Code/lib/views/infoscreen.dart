import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantix/Api/api.dart';
import 'package:plantix/Controller/image_controller.dart';
import 'package:plantix/Widgets/bezier.dart';
import 'package:plantix/constant.dart';
import 'package:plantix/models/leaf_model.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  var futuredata;
  @override
  void initState() {
    futuredata = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.2;
    var imageController = Get.put(ImageController());
    return Column(
      children: [
        CustomContainer(
          height: height,
          color: primaryswatch,
        ),
        Container(
          child: Center(
            child: FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return CircularProgressIndicator(
                    semanticsLabel: "Loading Please Wait",
                  );
                }
                if (snapshot.hasData &&
                    imageController.imagepath.value.isNotEmpty &&
                    snapshot.data != "Don't") {
                  final LeafData leafData = leafDataFromJson(snapshot.data);
                  final decodedBytes = base64Decode(leafData.imagePath);
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 5,
                                spreadRadius: 1)
                          ]),
                      child: Column(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: RichText(
                                          overflow: TextOverflow.clip,
                                          text: TextSpan(
                                            text: leafData.name + "\n",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Oswald",
                                              fontSize: 30,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text: leafData.disname
                                                      .replaceAll("_", " "),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w100))
                                            ],
                                          )),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade300,
                                            blurRadius: 5,
                                            spreadRadius: 1)
                                      ]),
                                      constraints: BoxConstraints(
                                          maxHeight: 150, maxWidth: 150),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.memory(
                                          decodedBytes,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              leafData.uses.isEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                                textAlign: TextAlign.justify,
                                                text: TextSpan(
                                                    text: "Symptoms:\n",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    children: [
                                                      TextSpan(
                                                          text: "\t\t\t\t" +
                                                              leafData.desc +
                                                              "\n",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w100))
                                                    ])),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    text: "Treatment:\n",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    children: [
                                                  for (int i = 0;
                                                      i <
                                                          leafData
                                                              .treatment.length;
                                                      i++)
                                                    TextSpan(
                                                        text: "\t\t\t\t • " +
                                                            leafData
                                                                .treatment[i] +
                                                            "\n",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w100))
                                                ])),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    text: "About:\n",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    children: [
                                                  TextSpan(
                                                      text: "\t\t\t\t" +
                                                          leafData.desc +
                                                          "\n",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w100))
                                                ])),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: RichText(
                                                text: TextSpan(
                                                    text: "Uses:\n",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    children: [
                                                  for (int i = 0;
                                                      i < leafData.uses.length;
                                                      i++)
                                                    TextSpan(
                                                        text: "\t\t\t\t • " +
                                                            leafData.uses[i] +
                                                            "\n",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w100))
                                                ])),
                                          ),
                                        ],
                                      ),
                                    )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                            "Something went wrong please\n try again ! by clicking snap in camera tab"),
                      ],
                    ),
                  );
                }
              },
              future: futuredata,
            ),
          ),
        )
      ],
    );
  }
}
