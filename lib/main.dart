import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF6A7CFF),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6A7CFF)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Dual Calc'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double? _result1 = 0;
  double? _result2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6A7CFF),
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: _launchUrl,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: SimpleCalculator(
            value: _result1!,
            hideExpression: false,
            hideSurroundingBorder: true,
            autofocus: true,
            maximumDigits: 20,
            onChanged: (key, value, expression) {
              setState(() {
                _result1 = value ?? 0;
              });
            },
            theme: const CalculatorThemeData(),
          )),
          const Padding(
              padding: EdgeInsets.all(2.0),
              child: Divider(thickness: 5, height: 5, color: Colors.orange)),
          Expanded(
              child: SimpleCalculator(
            value: _result2!,
            hideExpression: false,
            hideSurroundingBorder: true,
            autofocus: false,
            maximumDigits: 20,
            onChanged: (key, value, expression) {
              setState(() {
                _result2 = value ?? 0;
              });
            },
            theme: const CalculatorThemeData(),
          )),
        ],
      ),
    );
  }

  _launchUrl() async {
    try {
      const url = 'https://github.com/phstudio2';
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint("Error: $e");
    }
  }
}
