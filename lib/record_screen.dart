import 'dart:io';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'ai_engine.dart';
import 'result_screen.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});
  @override State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  late Record audioRecord;
  bool isRecording = false;
  String? audioPath;
  final AIEngine aiEngine = AIEngine();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    audioRecord = Record();
    _initAI();
  }

  Future<void> _initAI() async {
    await aiEngine.loadModel();
    setState(() => isLoading = false);
  }

  Future<void> startRecording() async {
    if (await Permission.microphone.request().isGranted) {
      final dir = await getTemporaryDirectory();
      audioPath = '${dir.path}/heart_${DateTime.now().millisecondsSinceEpoch}.wav';
      await audioRecord.start(
        path: audioPath!,
        encoder: AudioEncoder.wav,
        samplingRate: 44100,
      );
      setState(() => isRecording = true);
    }
  }

  Future<void> stopAndAnalyze() async {
    final path = await audioRecord.stop();
    setState(() => isRecording = false);
    if (path != null) {
      final result = await aiEngine.predict(path);
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ResultScreen(result: result)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('PhoneUSG™', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              child: Icon(
                isRecording ? Icons.favorite : Icons.favorite_border,
                size: 120,
                color: isRecording ? Colors.red : Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              isRecording ? 'Recording... Hold to chest' : 'Tap & Hold to Record',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTapDown: (_) => startRecording(),
              onTapUp: (_) => stopAndAnalyze(),
              onTapCancel: () => stopAndAnalyze(),
              child: Container(
                width: 200, height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isRecording ? Colors.red : Colors.red[300],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.5),
                      blurRadius: 30,
                      spreadRadius: isRecording ? 15 : 5,
                    ),
                  ],
                ),
                child: const Icon(Icons.mic, size: 80, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Hold 15–30 sec', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 40),
            const Text('Use ₹40 piezo probe for best results', style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}