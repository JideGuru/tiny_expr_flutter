import 'package:flutter/material.dart';
import 'package:tiny_expr_flutter/tiny_expr_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TinyExpr tinyExpr = TinyExpr();
  final TextEditingController controller = TextEditingController();
  double result = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 25);
    const spacerSmall = SizedBox(height: 10);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Packages'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text(
                  'Math Expression',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                spacerSmall,
                TextField(
                  controller: controller,
                ),
                spacerSmall,
                TextButton(
                  onPressed: () {
                    result = tinyExpr.evaluateExpression(controller.text);
                    setState(() {});
                  },
                  child: Text('Evaluate expression'),
                ),
                spacerSmall,
                Text('Result: $result'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
