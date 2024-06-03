// Second Page
import 'dart:ffi';

import 'package:bmi_app/state/bmi-state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BmiShowResult extends StatefulWidget {
  BmiState bmiState = BmiState();

  BmiShowResult({ required  this.bmiState });

  @override
  _BmiShowResultState createState() => _BmiShowResultState();
}

class _BmiShowResultState extends State<BmiShowResult> {
  double _bmi = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bmi = widget.bmiState.calculateBmi();

    print("SECOND_PAGE: ${widget.bmiState.weight}, ${widget.bmiState.height}");
    print(_bmi);
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
          ],
        ),
      ),
    );
  }
}
