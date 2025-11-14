import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/services.dart';

class AIEngine {
  late Interpreter _interpreter;
  late List<String> _labels;

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('model/murmur_classifier.tflite');
      final labelsData = await rootBundle.loadString('assets/model/labels.txt');
      _labels = labelsData.split('\n').where((l) => l.isNotEmpty).toList();
    } catch (e) {
      print("Model load error: $e");
    }
  }

  // PLACEHOLDER: Real inference in v2
  Future<String> predict(String wavPath) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate AI
    final results = ['Normal', 'Murmur', 'S3', 'S4'];
    return results[DateTime.now().millisecond % 4]; // Demo mode
  }
}