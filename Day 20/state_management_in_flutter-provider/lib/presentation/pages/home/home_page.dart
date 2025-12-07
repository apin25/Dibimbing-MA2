import 'package:day_21_state_management/data/repository/data_repository.dart';
import 'package:day_21_state_management/presentation/pages/province/province_page.dart';
import 'package:day_21_state_management/presentation/provider/counter_provider.dart';
import 'package:day_21_state_management/presentation/provider/province_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '${context.watch<CounterProvider>().counter}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 48),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => ProvinceProvider(
                      repository: context.read<DataRepository>(),
                    ),
                    lazy: true,
                    child: ProvincePage(),
                  ),
                ),
              ),
              child: const Text('Redirect to province page'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: context.read<CounterProvider>().increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
