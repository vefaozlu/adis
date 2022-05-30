import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Future<void> getItem() async {
    final String response = await rootBundle.loadString('assets/icon.json');
    final Map<String, dynamic> data = await json.decode(response);
    final Item item = Item.fromJson(data["items"][32]);
    print(item.text);
  }

  @override
  Widget build(BuildContext context) {
    AudioPlayer player = AudioPlayer();
    return Scaffold(
      body: Center(
        child: GridView.count(
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          crossAxisCount: 3,
          children: [
            InkWell(
              onTap: () => player.play('assets/voices/ama.mp3', isLocal: true),
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/age.png'),
                    const Text('Item')
                  ],
                ),
              ),
            ),
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/age.png'),
                  const Text('Item')
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/age.png'),
                  const Text('Item')
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/age.png'),
                  const Text('Item')
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/age.png'),
                  const Text('Item')
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/age.png'),
                  const Text('Item')
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.ac_unit_outlined),
        onPressed: () => getItem(),
      ),
    );
  }
}

class Item {
  const Item({
    required this.voicePath,
    required this.iconPath,
    required this.text,
  });

  final String voicePath;
  final String iconPath;
  final String text;

  Item.fromJson(Map<String, dynamic> json)
      : voicePath = json['voice'],
        iconPath = json['icon'],
        text = json['text'];
}
