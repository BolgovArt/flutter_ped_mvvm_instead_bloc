
import 'package:flutter/material.dart';
import 'package:flutter_ped_mvvm_instead_block/widgets/example_widget.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MVVM instead Block',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (_) => ViewModel(),
        child: const ExampleWidget(),
        // lazy: false,
      )
    );
  }
}
