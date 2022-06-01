import 'package:adis/cubits/cubits.dart';
import 'package:adis/screen.dart';
import 'package:adis/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdisApp extends StatelessWidget {
  const AdisApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => ItemsCubit(const Service())..fetchItems()),
          BlocProvider(create: (context) => SentenceCubit()),
        ],
        child: const MainScreen(),
      ),
    );
  }
}
