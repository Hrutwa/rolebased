
// import 'package:abc/provider/extra_time_provider.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class TimerProvider with ChangeNotifier {
  Timer? _timer;
  int _hour = 0;
  int _minute = 0;
  int _seconds = 0;
  int _Extrahour = 0;
  int _Extraminute = 0;
  int _Extraseconds = 0;
  bool _startEnable = true;
  bool _stopEnable = false;
  bool _continueEnable = false;

  int get hour => _hour;
  int get minute => _minute;
  int get seconds => _seconds;
  int get Extrahour => _Extrahour;
  int get Extraminute => _Extraminute;
  int get Extraseconds => _Extraseconds;
  bool get startEnable => _startEnable;
  bool get stopEnable => _stopEnable;
  bool get continueEnable => _continueEnable;

  void setVars(int hr, int min, int sec) {
    _hour = hr;
    _minute = min;
    _seconds = sec;
  }

  void startTimer(int hr, int min, int sec) async {
    // ExtraTimerProvider().startTimer();
    _hour = hr;
    _minute = min;
    _seconds = sec;
    _startEnable = false;
    _stopEnable = true;
    _continueEnable = false;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 1) {
        _seconds--;
      } else if (_seconds == 1 && _hour == 0 && _minute == 0) {
        _seconds--;
        stopTimer();
        ExtrastartTimer();

        return;
      } else if (_seconds == 0) {
        _seconds = 59;
        if (_minute == 0) {
          if (_hour != 0) {
            _hour--;
            _minute = 59;
          }
        } else {
          _minute--;
        }
      }

      notifyListeners();
    });
  }

  void stopTimer() {
    // ExtraTimerProvider extraTimerProvider =
    //     Provider.of<ExtraTimerProvider>(context, listen: false);
    if (_startEnable == false) {
      _startEnable = true;
      _continueEnable = true;
      _stopEnable = false;
      _timer!.cancel();
    }
    notifyListeners();
  }

  void continueTimer() {
    _startEnable = false;
    _stopEnable = true;
    _continueEnable = false;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 1) {
        _seconds--;
      } else if (_seconds == 1 && _hour == 0 && _minute == 0) {
        _seconds--;
        stopTimer();
        ExtrastartTimer();

        return;
      } else if (_seconds == 0) {
        _seconds = 59;
        if (_minute == 0) {
          if (_hour != 0) {
            _hour--;
            _minute = 59;
          }
        } else {
          _minute--;
        }
      }

      notifyListeners();
    });
  }

  void ExtrastartTimer() async {
    // ExtraTimerProvider().startTimer();
    _Extrahour = 0;
    _Extraminute = 0;
    _Extraseconds = 0;
    _startEnable = false;
    _stopEnable = true;
    _continueEnable = false;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_Extraseconds < 59) {
        _Extraseconds++;
      } else if (_Extraseconds == 59) {
        _Extraseconds = 0;
        if (_Extraminute == 59) {
          _Extrahour++;
          _Extraminute = 0;
        } else {
          _Extraminute++;
        }
      }

      notifyListeners();
    });
  }
}