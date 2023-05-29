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
        theme: ThemeData.dark(),
        home: Title(
          title: 'Suicide Detection',
          color: Theme.of(context).primaryColor,
          child: const Home(),
        ),
      ),
    );
  }
}
