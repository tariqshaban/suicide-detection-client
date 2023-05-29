import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/home/home.dart';
import 'providers.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Suicide Detection',
        theme: ThemeData.dark(),
        home: const Home(),
      ),
    );
  }
}
