import 'package:flutter/material.dart';
import 'package:weather_app_alvin/card.dart';
import 'package:weather_app_alvin/model/weather.dart';
import 'package:weather_icons/weather_icons.dart';
import 'theme_data/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: customTheme,
      home: const MyHomePage(title: 'Weather App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Weather>> futureWeathers;
  int currentIndex = 0;
  PageController pageController = PageController(viewportFraction: 0.85);
  List<Weather> weatherList = [];

  @override
  void initState() {
    super.initState();
    futureWeathers = loadWeathers();
    futureWeathers.then((value) {
      setState(() {
        weatherList = value;
      });
    });
  }

  Color _getTextColor(String kondisi) {
    switch (kondisi.toLowerCase()) {
      case 'panas':
        return customTheme.colorScheme.secondary;
      case 'berawan':
        return customTheme.colorScheme.primary;
      case 'hujan':
        return customTheme.colorScheme.tertiary;
      case 'berangin':
        return Color(0xFF6BC1D6);
      default:
        return Colors.white;
    }
  }

  LinearGradient _getColorByCondition(String kondisi) {
    switch (kondisi.toLowerCase()) {
      case 'berawan':
        return berawanGradient;
      case 'panas':
        return panasGradient;
      case 'hujan':
        return hujanGradient;
      case 'berangin':
        return beranginGradient;
      default:
        return berawanGradient;
    }
  }
  Widget _getSmallIcon(String kondisi) {
  switch (kondisi.toLowerCase()) {
    case 'berawan':
      return Icon(WeatherIcons.cloud, color: Colors.white, size: 26);
    case 'panas':
      return Icon(WeatherIcons.day_sunny, color: Colors.white, size: 26);
    case 'hujan':
      return Icon(WeatherIcons.rain, color: Colors.white, size: 26);
    case 'berangin':
      return Icon(WeatherIcons.cloudy_windy, color: Colors.white, size: 26);
    default:
      return Icon(Icons.cloud, color: Colors.white, size: 26);
  }
}

  BoxedIcon _getIconByCondition(BuildContext context, String kondisi) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (kondisi.toLowerCase()) {
      case 'berawan':
        return BoxedIcon(WeatherIcons.cloud, color: colorScheme.primary, size: 160);
      case 'panas':
        return BoxedIcon(WeatherIcons.day_sunny, color: colorScheme.secondary, size: 160);
      case 'hujan':
        return BoxedIcon(WeatherIcons.rain, color: colorScheme.tertiary, size: 160);
      case 'berangin':
        return BoxedIcon(WeatherIcons.cloudy_windy, color: Color(0xFF6BC1D6), size: 160);
      default:
        return BoxedIcon(Icons.cloud, color: Colors.grey, size: 160);
    }
  }
Widget _forecastItem(String day, Widget icon, String temp) {
  return Column(
    children: [
      Text(day, style: TextStyle(color: Colors.white, fontSize: 14)),
      SizedBox(height: 8),
      icon,
      SizedBox(height: 8),
      Text(temp, style: TextStyle(color: Colors.white, fontSize: 14)),
    ],
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: weatherList.isNotEmpty
              ? _getColorByCondition(weatherList[currentIndex].kondisi)
              : panasGradient,
        ),
        child: SingleChildScrollView(
          child: Column(
          children: [
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.menu_outlined,
                    color: weatherList.isNotEmpty
                        ? _getTextColor(weatherList[currentIndex].kondisi)
                        : Colors.white,
                  ),
                  Icon(
                    Icons.search,
                    color: weatherList.isNotEmpty
                        ? _getTextColor(weatherList[currentIndex].kondisi)
                        : Colors.white,
                  ),
                ],
              ),
            ),
          Transform.translate(
            offset: Offset(0, -60), 
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (weatherList.isNotEmpty) ...[
                  _getIconByCondition(context, weatherList[currentIndex].kondisi),
                  Text(weatherList[currentIndex].kondisi, style: customTheme.textTheme.titleMedium),
                  Text("${weatherList[currentIndex].suhu}°", style: customTheme.textTheme.headlineLarge),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on_outlined, color: customTheme.colorScheme.surface, size: 28),
                    Text(
                      weatherList.isNotEmpty
                          ? " ${weatherList[currentIndex].kota}, Indonesia"
                          : "Indonesia",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )
                  ],
                ),
                FutureBuilder<List<Weather>>(
                  future: futureWeathers,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator(color: Colors.white);
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        height: 200,
                        child: PageView.builder(
                          controller: pageController,
                          onPageChanged: (index) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          itemCount: weatherList.length,
                          itemBuilder: (context, index) {
                            final data = weatherList[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: weatherInfoBox(
                                context: context,
                                uvIndex: data.uvIndex.toString(),
                                humidity: "${data.kelembapan}%",
                                wind: "${data.angin} mph",
                                textColor: _getTextColor(data.kondisi),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(0, -100), // naikin forecast biar lebih dekat
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _forecastItem("Now", _getSmallIcon(weatherList[currentIndex].kondisi), "${weatherList[currentIndex].suhu}°"),
                  _forecastItem("Jan 7", Icon(WeatherIcons.day_fog, color: Colors.white, size: 26), "14°"),
                  _forecastItem("Jan 8", Icon(WeatherIcons.storm_showers, color: Colors.white, size: 26), "18°"),
                  _forecastItem("Jan 9", Icon(WeatherIcons.cloud, color: Colors.white, size: 26), "17°"),
                  _forecastItem("Jan 10", Icon(WeatherIcons.day_sunny, color: Colors.white, size: 26), "15°"),
                ],
              ),
            ),
          ),
          ],
        ),
      ),
      ),
    );
  }
}