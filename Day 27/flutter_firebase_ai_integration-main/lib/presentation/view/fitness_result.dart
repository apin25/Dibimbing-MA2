import 'package:flutter/material.dart';
import 'package:flutter_ai_integration/data/models/fitness_model.dart';

class FitnessResult extends StatelessWidget {
  final FitnessModel fitnessModel;

  const FitnessResult({super.key, required this.fitnessModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Fitness')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            fitnessModel.title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            fitnessModel.description,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 16),
          Text(
            'Jadwal',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.justify,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Text(
              fitnessModel.jadwal[index],
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
            separatorBuilder: (context, index) => SizedBox(height: 8),
            itemCount: fitnessModel.jadwal.length,
          ),
        ],
      ),
    );
  }
}
