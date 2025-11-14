import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String result;
  const ResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final isNormal = result == 'Normal';
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Diagnosis'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(
              isNormal ? Icons.check_circle : Icons.warning,
              size: 100,
              color: isNormal ? Colors.green : Colors.orange,
            ),
            const SizedBox(height: 20),
            Text(
              'AI Result: $result',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              isNormal
                  ? 'Heart sounds appear normal. Continue monitoring.'
                  : '$result detected. Consult a cardiologist if symptoms persist.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text('Scan Again', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}