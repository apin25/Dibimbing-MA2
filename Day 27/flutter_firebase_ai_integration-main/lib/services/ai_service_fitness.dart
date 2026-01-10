import 'package:firebase_ai/firebase_ai.dart';

class AiServiceFitness {
  final model = FirebaseAI.googleAI().generativeModel(
    model: 'gemini-2.5-flash',
    systemInstruction: Content.text(
      'Anda adalah asisten yang membantu membuat program fitness yang cocok untuk dilakukan dirumah. '
      'Program yang kamu berikan haruslah mudah dan sederhana. Jangan sampai terlalu kompleks.'
      'Program yang kamu berikan haruslah berbasis tujuan dan ketersediaan sumber daya yang ada di tangan pengguna.'
      'Kamu tidak hanya memberikan program fitness tapi juga memberikan penjelasan singkat dan cara mengikuti program tersebut.'
      'Response yang kamu berikan harus berbahasa Indonesia yang baik dan benar'
      'Response yang kamu berikan berformat JSON',
    ),
    generationConfig: GenerationConfig(responseMimeType: 'application/json'),
  );

  Future<String?> generateFitnessProgram({
    required int weightGoals,
    required int currentWeight,
    required String gender,
    required String fitnessLevel,
  }) async {
    try {
      final response = await model.generateContent([
        Content.text(
          'Buat program fitness untuk tujuan menurunkan berat badan menjadi $weightGoals kg dengan berat badan saat ini $currentWeight kg, gender $gender, tingkat kebugaran $fitnessLevel',
        ),
        Content.text(
          'format response harus berbentuk JSON: {"title": "Nama Program", "description": "Penjelasan singkat program", "jadwal": ["Jadwal 1", "Jadwal 2", ...]}',
        ),
      ]);

      return response.text;
    } catch (e) {
      throw Exception('Failed to generate fitness program: $e');
    }
  }
}
