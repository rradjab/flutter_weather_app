import 'package:dio/dio.dart';
import '../models/weather_model.dart';

Future<CityWeather> getWeather(String city) async {
  String url =
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=10530cd042fdda8d65051ca864fc86bf';
  var response = await Dio().get(url);

  if (response.statusCode == 200) {
    return CityWeather.fromJson(response.data);
  }
  return CityWeather();
}

Future<Iterable<String>> getCountries(String name) async {
  String url =
      'https://www.yahoo.com/news/_tdnews/api/resource/WeatherSearch;text=$name';
  Dio dio = Dio();
  var headers = {
    'Host': 'www.yahoo.com',
    'User-Agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101 Firefox/71.0',
    'Accept': '*/*',
    'Accept-Language': 'en-US,en;q=0.5',
    'Accept-Encoding': 'gzip, deflate, br',
    'Referer': 'https://www.yahoo.com/',
    'Origin': 'https://www.yahoo.com',
    'Connection': 'keep-alive',
    'Content-Length': '0',
    'TE': 'Trailers'
  };
  var response = await dio.get(url, options: Options(headers: headers));
  var cities = (response.data as List);

  if (response.statusCode == 200) {
    return cities.map((user) => user['city'] as String);
  }
  return [];
}
