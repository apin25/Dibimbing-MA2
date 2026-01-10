import 'package:flutter/material.dart';
import 'package:flutter_ai_integration/data/models/fitness_model.dart';
import 'package:flutter_ai_integration/data/repositories/fitness_repository.dart';

class FitnessNotifier extends ChangeNotifier {
  final FitnessRepository fitnessRepository;

  FitnessNotifier(this.fitnessRepository);

  Future<FitnessModel?> getFitnessProgramByGoal({
    required int weightGoals,
    required int currentWeight,
    required String gender,
    required String fitnessLevel,
  }) async {
    final result = await fitnessRepository.getFitnessProgramByGoal(
      weightGoals: weightGoals,
      currentWeight: currentWeight,
      gender: gender,
      fitnessLevel: fitnessLevel,
    );
    return result;
  }
}
