import 'package:engage_flutter/engage_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => Engage.instance.showDialog(isCarousel: false),
              child: const Text('Show modal'),
            ),
            ElevatedButton(
              onPressed: () => Engage.instance.showDialog(isCarousel: true),
              child: const Text('Show carousel'),
            ),
          ],
        ),
      ),
    );
  }
}
