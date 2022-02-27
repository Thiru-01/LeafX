import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:plantix/Controller/image_controller.dart';
import 'package:plantix/Widgets/bezier.dart';
import '../constant.dart';

class CameraPage extends StatelessWidget {
  final void Function(int) function;
  const CameraPage({Key? key, required this.function}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var imageController = Get.put(ImageController());
    final double height = MediaQuery.of(context).size.height * 0.2;
    return Column(
      children: [
        CustomContainer(
          height: height,
          color: primaryswatch,
        ),
        SvgPicture.asset(
          "asset/icons/1.svg",
          height: MediaQuery.of(context).size.height * 0.4,
          fit: BoxFit.contain,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () => imageController.selectgallery(context),
                child: Text(
                  "Select image",
                  style: TextStyle(color: Colors.white),
                )),
            ElevatedButton(
                onPressed: () => imageController.selectcamera(context),
                child:
                    Text("Take Snap", style: TextStyle(color: Colors.white))),
          ],
        )
      ],
    );
  }
}
