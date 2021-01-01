import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class CountDown extends StatefulWidget {
  final durationInSeconds;
  final Function(bool) isEndCountDown;

  const CountDown({Key key, this.durationInSeconds, this.isEndCountDown}) : super(key: key);

  @override
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
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
    return CircularCountDownTimer(
      duration: widget.durationInSeconds,
      controller: _countDownController,
      width: 50,
      height: 50,
      color: Colors.white,
      fillColor: Colors.red,
      backgroundColor: null,
      strokeWidth: 5.0,
      strokeCap: StrokeCap.butt,
      textStyle: TextStyle(
          fontSize: 10.0, color: Colors.black, fontWeight: FontWeight.bold),
      isReverse: true,
      isReverseAnimation: true,
      isTimerTextShown: true,
      onComplete: () {
        print('Countdown Ended');
        widget.isEndCountDown(true);
      },
    );
  }
}
