import 'package:adis/model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  List<Item> items = [];
  Future<void> getItem() async {
    final String response = await rootBundle.loadString('assets/icon.json');
    final Map<String, dynamic> data = await json.decode(response);
    final Item item = Item.fromJson(data["items"][109]);
    for (int i = 0; i < 17; i++) {
      items.add(Item.fromJson(data["items"][i + 1]));
    }
    setState(() => null);
  }

  AudioCache player = AudioCache();
  PanelController _panelControler = PanelController();
  String sentence = '';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.greenAccent,
        body: SlidingUpPanel(
          minHeight: 0,
          maxHeight: size.width / 2.25,
          controller: _panelControler,
          onPanelClosed: () => setState(() => sentence = ''),
          panel: Center(child: Text(sentence)),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      alignment: WrapAlignment.center,
                      children: List.generate(
                        items.length,
                        (index) => InkWell(
                          onTap: () {
                            player.play('voices/${items[index].voicePath}');
                            setState(() => sentence += ' ${items[index].text}');
                            _panelControler.open();
                          },
                          child: Container(
                            width: size.width / 2.25,
                            height: size.width / 2.25,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: Image.asset(
                                    'assets/icons/${items[index].iconPath}',
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    items[index].text,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(
                      bottom: size.width / 2.25 + 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.ac_unit_outlined),
          onPressed: () => getItem(),
        ),
      ),
    );
  }
}
