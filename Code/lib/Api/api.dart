import 'dart:io';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:plantix/Controller/image_controller.dart';

Future<String> getData() async {
  var path = Get.put(ImageController());
  Uri url = Uri.parse("http://${path.ip.value}:444/home");
  if (path.imagepath.isNotEmpty) {
    http.MultipartRequest request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath(
        'asset', File(path.imagepath.value).path,
        contentType: MediaType('image', 'jpg')));
    http.Response response =
        await http.Response.fromStream(await request.send());
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "Don't";
    }
  }
  return "";
}
