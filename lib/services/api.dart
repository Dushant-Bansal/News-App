import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app/models/news.dart';

class Api {
  final String _apiKey = dotenv.env['API_KEY']!;
  final Dio _dio = Dio();

  Future<List<News>> getTopHeadlines() async {
    try {
      Response response = await _dio.get(
          'https://newsapi.org/v2/top-headlines?country=in&apiKey=$_apiKey');

      return (response.data['articles'] as List)
          .map((e) => News.fromJson(e))
          .toList();
    } on DioException catch (e) {
      return Future.error(e);
    }
  }

  Future<List<News>> search(String q) async {
    try {
      Response response = await _dio.get(
          'https://newsapi.org/v2/everything?q=$q&from=2023-07-1&sortBy=popularity&apiKey=$_apiKey');

      return (response.data['articles'] as List)
          .map((e) => News.fromJson(e))
          .toList();
    } on DioException catch (e) {
      return Future.error(e);
    }
  }
}
