import 'package:web_scraper/web_scraper.dart';

Stream getprice() async* {
  List finalData = [];
  List fianlData2 = [];

  final rawurl = "https://prices.org.in/vegetable/pondicherry/";
  final endpoint = rawurl.replaceFirst(r"https://prices.org.in", "");
  final endpointFruit = "/fruit/pondicherry/";
  final webscrapper = WebScraper("https://prices.org.in");
  final webscrapperFruit = WebScraper("https://prices.org.in");
  if (await webscrapper.loadWebPage(endpoint) &&
      await webscrapperFruit.loadWebPage(endpointFruit)) {
    final data = webscrapper.getElement('div.xs12 > table > tbody', []);
    final dataFruit =
        webscrapperFruit.getElement('div.xs12 > table > tbody', []);
    data.forEach((element) {
      final data = element['title'];
      for (var i in data.split(".00")) {
        var j = i.toString().split('\n');
        j.removeWhere((element) => element == "");
        finalData.add(j);
      }
    });
    finalData.removeAt(finalData.length - 1);
    dataFruit.forEach((element) {
      final data = element['title'];
      for (var i in data.split(".00")) {
        var j = i.toString().split('\n');
        j.removeWhere((element) => element == "");
        fianlData2.add(j);
      }
    });
    fianlData2.removeAt(fianlData2.length - 1);
  }
  finalData = finalData + fianlData2;
  yield finalData;
}
