// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

// Project imports:
import 'package:my_idena/appstate_container.dart';

class TimeLockCountDown extends StatefulWidget {
  final durationInSeconds;
  final Function(bool) isEndCountDown;

  const TimeLockCountDown(
      {Key key, this.durationInSeconds, this.isEndCountDown})
      : super(key: key);

  @override
  _TimeLockCountDownState createState() => _TimeLockCountDownState();
}

class _TimeLockCountDownState extends State<TimeLockCountDown> {
  CountDownController _countDownController = CountDownController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildChild();
  }

  Widget _buildChild() {
    return widget.durationInSeconds > 0
        ? CircularCountDownTimer(
            duration: widget.durationInSeconds,
            controller: _countDownController,
            width: 200,
            height: 200,
            ringColor: Colors.white,
            fillColor: StateContainer.of(context).curTheme.primary20,
            backgroundColor: null,
            strokeWidth: 5.0,
            strokeCap: StrokeCap.butt,
            textStyle: TextStyle(
                fontSize: 20.0,
                color: StateContainer.of(context).curTheme.primary,
                fontWeight: FontWeight.bold),
            isReverse: true,
            isReverseAnimation: true,
            isTimerTextShown: true,
            onComplete: () {
              //print('Countdown Ended');
              widget.isEndCountDown(true);
            },
          )
        : SizedBox();
  }
}
