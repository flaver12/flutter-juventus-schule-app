import 'package:bmi_app/bmi-show-result.dart';
import 'package:bmi_app/bmi-categories.dart';
import 'package:bmi_app/user.dart';
import 'package:bmi_app/state/bmi-state.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'BMI App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BmiState _bmiState = BmiState();

  final TextEditingController _controllerHeight = TextEditingController();
  final TextEditingController _controllerWeight = TextEditingController();

  void _updateInputNumber() {
    setState(() {
      double height = double.tryParse(_controllerHeight.text) ?? 0;
      double weight = double.tryParse(_controllerWeight.text) ?? 0;

      _bmiState.height = height;
      _bmiState.weight = weight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'info') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BmiCategories()));
              } else if (value == 'user') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserSelect()));
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'info',
                  child: Text('BMI Kategorien'),
                ),
                PopupMenuItem<String>(
                  value: 'user',
                  child: Text('Benutzer auswahl'),
                )
              ];
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controllerHeight,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Gebe deine grösse ein(cm)',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _controllerWeight,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Gebe dein gewicht ein',
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  _updateInputNumber();
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BmiShowResult(bmiState: _bmiState)))
                      .then((_) => setState(() {})); // then == redraw
                },
                child: Text("Finde deinen BMI Heraus!")),
          ],
        ),
      ),
    );
  }
}
