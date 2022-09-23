import 'package:dio/dio.dart';

class Fetch {
  Future<List<dynamic>> fetchList(String url) async {
    final Response response = await Dio().get(url);
    return response.data;
  }
}
