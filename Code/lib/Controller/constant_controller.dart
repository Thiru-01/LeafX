import 'package:get/get.dart';

class ContstantController extends GetxController {
  var selected = 0.obs;
  changeState(int inde) {
    selected.value = inde;
  }
}
