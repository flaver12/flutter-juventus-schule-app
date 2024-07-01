import 'dart:ffi';
import 'package:bmi_app/service/database-service.dart';
import 'package:bmi_app/state/bmi-state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/bmi.dart';

class BmiShowResult extends StatefulWidget {
  BmiState bmiState = BmiState();

  BmiShowResult({required this.bmiState});

  @override
  _BmiShowResultState createState() => _BmiShowResultState();
}

class _BmiShowResultState extends State<BmiShowResult> {
  double _bmi = 0;
  final DatabaseService _databaseService = DatabaseService();
  List<Bmi> _bmiList = [];

  @override
  void initState() {
    super.initState();
    _bmi = widget.bmiState.calculateBmi();

    print("SECOND_PAGE: ${widget.bmiState.weight}, ${widget.bmiState.height}");
    print(_bmi);

    _saveBmi();
    _loadBmis();
  }

  Future<void> _saveBmi() async {
    final newBmi = Bmi(id: DateTime.now().millisecondsSinceEpoch, value: _bmi);
    await _databaseService.saveBmi(newBmi);
    await _loadBmis();
  }

  Future<void> _loadBmis() async {
    final bmiList = await _databaseService.loadBmis();
    setState(() {
      _bmiList = bmiList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Home Page'),
            ),
            Text(
              'Dein BMI ist: ${_bmi.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 20),
            Text(
              'Vergangene BMIs:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _bmiList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      'BMI: ${_bmiList[index].value.toStringAsFixed(2)}',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}