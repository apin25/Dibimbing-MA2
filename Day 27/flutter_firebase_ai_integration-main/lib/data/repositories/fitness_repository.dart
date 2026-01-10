import 'dart:convert';

import 'package:flutter_ai_integration/data/models/fitness_model.dart';
import 'package:flutter_ai_integration/services/ai_service.dart';
import 'package:flutter_ai_integration/services/ai_service_fitness.dart';

class FitnessRepository {
  final AiServiceFitness aiService;

  const FitnessRepository(this.aiService);

  Future<FitnessModel?> getFitnessProgramByGoal({
    required int weightGoals,
    required int currentWeight,
    required String gender,
    required String fitnessLevel,
  }) async {
    final result = await aiService.generateFitnessProgram(
      weightGoals: weightGoals,
      currentWeight: currentWeight,
      gender: gender,
      fitnessLevel: fitnessLevel,
    );

    if (result == null) {
      return null;
    }
    return FitnessModel.fromJson(json.decode(result));
  }
}
