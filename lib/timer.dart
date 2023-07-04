import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rolebased/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final timerController = TextEditingController();
  late Timer _timer;
  int _counter = 0;
  int _upCounter = 0;
  // ignore: prefer_typing_uninitialized_variables

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration.zero, () {});
  }

  @override
  void dispose() {
    _timer.cancel();
    timerController.dispose();
    super.dispose();
  }

  void startTimer() {
    if (timerController.text.isNotEmpty) {
      int duration = int.parse(timerController.text) * 60; // convert minutes to seconds
      _timer.cancel();
      _counter = duration;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_counter > 0) {
          setState(() {
            // _counter--;

            var timerInfo = Provider.of<TimerInfo>(context, listen: false);
      timerInfo.updateRemainingTime();
          });
        } else {
          _timer.cancel();
          startUpCounter();
        }
      });
    }
  }

  void startUpCounter() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _upCounter++;
      });
    });
  }

  void stopUpCounter() {
    _timer.cancel();
    setState(() {
      _upCounter = 0;
    });
  }

  void resetTimer() {
    _timer.cancel();
    setState(() {
      _counter = 0;
      _upCounter = 0;
      timerController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Timer App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Timer App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: timerController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter timer duration (in minutes)',
                ),
              ),
              SizedBox(height: 16),
              Text(
                '${_counter ~/ 60}:${(_counter % 60).toString().padLeft(2, '0')}', // convert seconds to minutes and seconds
                style: TextStyle(fontSize: 48),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: startTimer,
                    child: Text('Start'),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: resetTimer,
                    child: Text('Reset'),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: stopUpCounter,
                    child: Text('Stop Up Counter'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                '${_upCounter ~/ 60}:${(_upCounter % 60).toString().padLeft(2, '0')}', // convert seconds to minutes and seconds
                style: TextStyle(fontSize: 48),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



