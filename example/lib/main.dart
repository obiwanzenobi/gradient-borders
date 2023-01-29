import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gradient borders"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  border: const GradientBoxBorder(
                    gradient: LinearGradient(colors: [Colors.blue, Colors.red]),
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(16)),
            ),
            const SizedBox(height: 16),
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                border: GradientBoxBorder(
                  gradient:
                      LinearGradient(colors: [Colors.green, Colors.yellow]),
                  width: 4,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                border: GradientBoxBorder(
                  gradient:
                      LinearGradient(colors: [Colors.pink, Colors.orange]),
                  width: 4,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                border: GradientOutlineInputBorder(
                  gradient: LinearGradient(colors: [Colors.red, Colors.blue]),
                  width: 2,
                ),
                focusedBorder: GradientOutlineInputBorder(
                    gradient:
                        LinearGradient(colors: [Colors.yellow, Colors.green]),
                    width: 2),
                label: Text("Example"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
