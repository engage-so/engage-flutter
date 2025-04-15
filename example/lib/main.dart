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
  void _setup() async {
    await Engage.instance.init(
      publicKey: 'pk_bcbdcceecc80b6b83d7d8df664a98761',
    );
    await Engage.instance.identify('dwqdqw', properties: {
      'first_name': 'Daniel',
      'last_name': 'Obinna',
      'last_login': DateTime.now().toIso8601String(),
    });

    Engage.instance.onMessageOpened((message) {
      debugPrint('MESSAGE OPENED IN FLUTTER APP $message');
      Engage.instance.track('notification_opened');
    });
    Engage.instance.onMessageReceived((message) {
      debugPrint('MESSAGE OPENED IN FLUTTER APP $message');
      Engage.instance.track('notification_received');
    });
    debugPrint('SETUP COMPLETE');
  }

  @override
  void initState() {
    super.initState();
    _setup();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [],
        ),
      ),
    );
  }
}
