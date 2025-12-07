import 'package:day_21_state_management/data/repository/data_repository.dart';
import 'package:day_21_state_management/presentation/my_app.dart';
import 'package:day_21_state_management/presentation/provider/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => DataRepository()),
        ChangeNotifierProvider(create: (_) => CounterProvider()),
        // ChangeNotifierProvider(create: (_) => ProvinceProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
