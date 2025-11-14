cat > lib/main.dart << 'EOF'
import 'package:flutter/material.dart';
import 'record_screen.dart';

void main() {
  runApp(const PhoneUSGApp());
}

class PhoneUSGApp extends StatelessWidget {
  const PhoneUSGApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhoneUSG™',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const RecordScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
EOF
