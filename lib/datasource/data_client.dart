import 'dart:convert';

import 'package:flutter/services.dart';

class DataClient {
  static Future<dynamic> getDataSrc(String dataFileName) async {
    String data = await rootBundle.loadString("assets/$dataFileName");
    return jsonDecode(data);
  }
}
