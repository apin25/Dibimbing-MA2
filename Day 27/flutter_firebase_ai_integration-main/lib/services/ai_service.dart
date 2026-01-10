import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/foundation.dart';

class AiService {
  AiService();
  final model = FirebaseAI.googleAI().generativeModel(
    model: 'gemini-2.5-flash',
    systemInstruction: Content.text(
      'Anda adalah asisten yang membantu membuat resep berdasarkan bahan atau gambar. '
      'Resep yang kamu berikan haruslah mudah dan sederhana. Jangan sampai terlalu kompleks.'
      'Resep yang kamu berikan haruslah berbasis bahan yang ada di tangan pengguna.'
      'Kamu tidak hanya memberikan resep tapi juga memberikan penjelasan singkat dan cara memasak resep tersebut.'
      'Response yang kamu berikan harus berbahasa Indonesia yang baik dan benar'
      'Response yang kamu berikan berformat JSON',
    ),
    generationConfig: GenerationConfig(
      responseMimeType: 'application/json',
    ),
  );

  Future<String?> generateText(String prompt) async {
    try {
      if (kDebugMode) {
        print(
          'Generating text with prompt: ${prompt.substring(0, prompt.length > 50 ? 50 : prompt.length)}...',
        );
      }

      final response = await model.generateContent(
        [Content.text(prompt)],
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
        ),
      );

      if (kDebugMode) {
        print('Response received successfully');
      }

      return response.text;
    } catch (e) {
      if (kDebugMode) {
        print('Error generating text: $e');
        print('Error type: ${e.runtimeType}');
      }

      // Re-throw with more context
      throw Exception('Failed to generate text: $e');
    }
  }

  Future<String?> generateTextByImage({
    required String prompt,
    required List<InlineDataPart> imageParts,
  }) async {
    try {
      if (kDebugMode) {
        print(
          'Generating text with image. Prompt: ${prompt.substring(0, prompt.length > 50 ? 50 : prompt.length)}...',
        );
        print('Number of image parts: ${imageParts.length}');
      }

      final response = await model.generateContent([
        Content.multi([TextPart(prompt), ...imageParts]),
      ]);

      if (kDebugMode) {
        print('Image-based response received successfully');
      }

      return response.text;
    } catch (e) {
      if (kDebugMode) {
        print('Error generating text with image: $e');
        print('Error type: ${e.runtimeType}');
      }

      // Re-throw with more context
      throw Exception('Failed to generate text with image: $e');
    }
  }
}
