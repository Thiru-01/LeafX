import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantix/Controller/image_controller.dart';

class IpScreen extends StatelessWidget {
  const IpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController txtcontroller = TextEditingController();
    var imgcontroller = Get.put(ImageController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        centerTitle: true,
        title: Text(
          "SET IP",
          style: TextStyle(color: Colors.white, letterSpacing: 5),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: txtcontroller,
                  maxLength: 16,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Enter the IP",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  imgcontroller.setip(txtcontroller.text);
                  Get.back();
                },
                child: Text(
                  "Set Ip",
                  style: TextStyle(color: Colors.white, letterSpacing: 5),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
