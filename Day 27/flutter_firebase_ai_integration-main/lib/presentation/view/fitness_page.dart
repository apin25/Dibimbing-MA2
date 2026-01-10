import 'package:flutter/material.dart';
import 'package:flutter_ai_integration/presentation/provider/fitness_provider.dart';
import 'package:flutter_ai_integration/presentation/view/fitness_result.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class FitnessPage extends StatefulWidget {
  const FitnessPage({super.key});

  @override
  State<FitnessPage> createState() => _FitnessPageState();
}

class _FitnessPageState extends State<FitnessPage> {
  late TextEditingController weightGoalsController;
  late TextEditingController currentWeightController;
  late TextEditingController genderController;
  late TextEditingController fitnessLevelController;

  @override
  void initState() {
    super.initState();
    weightGoalsController = TextEditingController();
    currentWeightController = TextEditingController();
    genderController = TextEditingController();
    fitnessLevelController = TextEditingController();
  }

  @override
  void dispose() {
    weightGoalsController.dispose();
    currentWeightController.dispose();
    genderController.dispose();
    fitnessLevelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fitness Program')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextField(
            controller: weightGoalsController,
            decoration: const InputDecoration(labelText: 'Weight Goals (kg)'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: currentWeightController,
            decoration: const InputDecoration(labelText: 'Current Weight (kg)'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),

          DropdownButton(
            value: genderController.text.isNotEmpty
                ? genderController.text
                : null,
            items: [
              DropdownMenuItem(value: 'male', child: Text('Male')),
              DropdownMenuItem(value: 'female', child: Text('Female')),
            ],
            onChanged: (value) {
              setState(() {
                genderController.text = value!;
              });
            },
            hint: Text('Gender'),
          ),
          const SizedBox(height: 16),

          DropdownButton(
            value: fitnessLevelController.text.isNotEmpty
                ? fitnessLevelController.text
                : null,
            items: [
              DropdownMenuItem(value: 'beginner', child: Text('Beginner')),
              DropdownMenuItem(
                value: 'intermediate',
                child: Text('Intermediate'),
              ),
              DropdownMenuItem(value: 'advanced', child: Text('Advanced')),
            ],
            onChanged: (value) {
              setState(() {
                fitnessLevelController.text = value!;
              });
            },
            hint: Text('Fitness Level'),
          ),
          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: () async {
              context.loaderOverlay.show();
              final fitnessModel = await context
                  .read<FitnessNotifier>()
                  .getFitnessProgramByGoal(
                    weightGoals: int.parse(weightGoalsController.text),
                    currentWeight: int.parse(currentWeightController.text),
                    gender: genderController.text,
                    fitnessLevel: fitnessLevelController.text,
                  );
              context.loaderOverlay.hide();

              if (fitnessModel != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        FitnessResult(fitnessModel: fitnessModel),
                  ),
                );
              }
            },
            child: const Text('Generate Program'),
          ),
        ],
      ),
    );
  }
}
