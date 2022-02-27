import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:plantix/constant.dart';
import 'constant_controller.dart';

class ImageController extends GetxController {
  var constcontroller = Get.put(ContstantController());
  late var imagepath = "".obs;
  late var ip = "".obs;

  selectgallery(context) async {
    if (ip.value != "") {
      var value = await ImagePicker().getImage(source: ImageSource.gallery);
      imagepath.value = value!.path;
      constcontroller.changeState(2);
    }
    if (ip.value == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Please Select the IP",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryswatch,
      ));
    }
  }

  selectcamera(context) async {
    if (ip.value != "") {
      var value = await ImagePicker().getImage(source: ImageSource.camera);
      imagepath.value = value!.path;
      constcontroller.changeState(2);
    }
    if (ip.value == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Please Select the IP",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryswatch,
      ));
    }
  }

  setip(String value) {
    ip.value = value;
  }
}
