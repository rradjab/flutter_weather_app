import 'package:flutter/material.dart';

import '../api/api.dart';
import '../models/weather_model.dart';
import '../widgets/weather_view.dart';

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Weather> {
  late Future<CityWeather> _cityWeather;

  @override
  void initState() {
    super.initState();
    _cityWeather = getWeather2('Baku');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Autocomplete(
            initialValue: const TextEditingValue(text: 'Baku'),
            optionsBuilder: (TextEditingValue textEditingValue) {
              return getCountries(textEditingValue.text);
            },
            onSelected: (String selection) {
              setState(() {
                _cityWeather = getWeather2(selection);
              });
            },
          ),
        ),
      ),
      body: FutureBuilder(
        future: _cityWeather,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            CityWeather cw = snapshot.data!;
            return WeatherView(
              cityWeather: cw,
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Yazılışda səhv"),
            );
          }
          return const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
