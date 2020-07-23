
String constructTime(int seconds) {
  int minute = seconds % 3600 ~/ 60;
  int second = seconds % 60;
  return formatTime(minute) + ":" + formatTime(second);
 }

 // Digital formatting, converting 0-9 time to 00-09
 String formatTime(int timeNum) {
  return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
 }