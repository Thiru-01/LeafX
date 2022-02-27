import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantix/Controller/constant_controller.dart';
import 'package:plantix/constant.dart';
import 'package:plantix/views/camerscreen.dart';
import 'package:plantix/views/infoscreen.dart';
import 'homescreen.dart';

class BackgroundScreen extends StatefulWidget {
  const BackgroundScreen({Key? key}) : super(key: key);

  @override
  _BackgroundScreenState createState() => _BackgroundScreenState();
}

class _BackgroundScreenState extends State<BackgroundScreen> {
  final constControll = Get.put(ContstantController());
  final imagePicker = ImagePicker();
  void _ontapped(int index) async {
    constControll.changeState(index);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetCenter = [
      HomeScreen(),
      CameraPage(
        function: _ontapped,
      ),
      InfoScreen(),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.2,
            elevation: 0,
            backgroundColor: primaryswatch,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Obx(() => Text(
                  constControll.selected.value == 0
                      ? "HOME"
                      : constControll.selected.value == 2
                          ? "INFO"
                          : "Camera",
                  style: TextStyle(color: Colors.white, fontSize: 25))),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
                  [Obx(() => _widgetCenter[constControll.selected.value])])),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300, blurRadius: 5, spreadRadius: 1)
            ]),
        child: AnimatedSize(
          curve: Curves.easeInOut,
          duration: Duration(seconds: 1),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            child: Obx(() => BottomNavigationBar(
                  currentIndex: constControll.selected.value,
                  unselectedItemColor: Colors.grey,
                  selectedLabelStyle: TextStyle(letterSpacing: 5),
                  onTap: _ontapped,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(FontAwesomeIcons.leaf), label: "HOME"),
                    BottomNavigationBarItem(
                        icon: Icon(FontAwesomeIcons.camera), label: "CAMERA"),
                    BottomNavigationBarItem(
                        icon: Icon(FontAwesomeIcons.infoCircle), label: "INFO")
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
