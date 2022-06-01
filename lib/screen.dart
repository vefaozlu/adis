import 'package:adis/color_package.dart';
import 'package:adis/cubits/cubits.dart';
import 'package:adis/model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PanelController _panelController = PanelController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ItemsState state = context.watch<ItemsCubit>().state;
    String sentence = context.watch<SentenceCubit>().state.sentence;
    return SafeArea(
      child: BlocListener<SentenceCubit, SentenceState>(
        listener: (context, state) {
          if (_panelController.isPanelClosed && state.sentence != '') {
            _panelController.open();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('ADIS'),
            centerTitle: false,
            backgroundColor: ColorPackage.secondaryColor,
          ),
          drawer: Drawer(
            backgroundColor: ColorPackage.primaryColor,
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) => Card(
                color: state.categoryIndex == index
                    ? ColorPackage.secondaryColor
                    : null,
                child: ListTile(
                  // leading: CircleAvatar(backgroundImage: ),
                  title: Text(
                    categories[index],
                    style: TextStyle(
                      color: state.categoryIndex == index
                          ? ColorPackage.primaryTextColor
                          : ColorPackage.secondryTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () => context.read<ItemsCubit>().getCategory(index),
                ),
              ),
            ),
          ),
          body: SlidingUpPanel(
            minHeight: 0,
            maxHeight: size.width / 2.25,
            color: ColorPackage.secondaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            controller: _panelController,
            onPanelClosed: () => context.read<SentenceCubit>().clearSentence(),
            panel: Center(
              child: Text(
                sentence,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorPackage.primaryTextColor,
                  fontSize: 24,
                ),
              ),
            ),
            body: BlocBuilder<ItemsCubit, ItemsState>(
              builder: (context, state) {
                if (state.status == ItemsStatus.failure) {
                  return const Center(child: Text('Something went wrong.'));
                }
                if (state.status == ItemsStatus.success) {
                  return ItemsView(items: state.categoryItems);
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }

  List<String> categories = [
    'Yemek',
    'Gunluk Konusma',
    'Duygular',
    'Tamlamalar',
    'Ihtiyac ve Istekler',
    'Ana Menu',
  ];
}

class ItemsView extends StatelessWidget {
  ItemsView({Key? key, required this.items}) : super(key: key);
  final List<Item> items;
  final AudioCache _player = AudioCache();

  Future<void> play(String voicePath) async {
    await _player.play(voicePath);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Center(
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
                    onTap: () async {
                      context.read<SentenceCubit>().addAWord(items[index].text);
                      await play('voices/${items[index].voicePath}');
                      // _panelController.open();
                    },
                    child: Container(
                      width: size.width / 2.25,
                      height: size.width / 2.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Image.asset(
                              'assets/icons/${items[index].iconPath}',
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(
                                items[index].text,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                bottom: size.width / 2.25 + 30 + kToolbarHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
