import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';
import 'package:my_idena/pages/myIdena_home.dart';
import 'package:my_idena/pages/screens/on_boarding_screen.dart';
import 'package:my_idena/utils/sharedPreferencesHelper.dart';
import 'package:ntp/ntp.dart';

class RouteScreen extends StatefulWidget {
  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  HttpService httpService = HttpService();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<bool> checkTime() async {
    DateTime _myTime;
    DateTime _ntpTime;
    int _differenceTime;

    try {
      _myTime = await NTP.now();
      final int offset = await NTP.getNtpOffset(localTime: DateTime.now());
      _ntpTime = _myTime.add(Duration(milliseconds: offset));

      _differenceTime = _myTime.difference(_ntpTime).inMilliseconds;
    } catch (e) {}

    if (_differenceTime != null && _differenceTime.abs() < 1000) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    String apiUrl;
    String keyApp;
    return FutureBuilder<IdenaSharedPreferences>(
        future: SharedPreferencesHelper.getIdenaSharedPreferences(),
        builder: (BuildContext context,
            AsyncSnapshot<IdenaSharedPreferences> snapshot) {
          if (snapshot.hasData == false) {
            return Center(child: CircularProgressIndicator());
          } else {
            apiUrl = snapshot.data.apiUrl != null ? snapshot.data.apiUrl : "";
            keyApp = snapshot.data.keyApp != null ? snapshot.data.keyApp : "";
            return FutureBuilder<bool>(
                future: httpService.checkConnection(apiUrl, keyApp),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData == false || snapshot.data == null) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.data) {
                      return FutureBuilder<bool>(
                          future: checkTime(),
                          builder: (BuildContext context,
                              AsyncSnapshot<bool> snapshot) {
                            if (snapshot.hasData == false ||
                                snapshot.data == null) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return Home();
                            }
                          });
                    } else {
                      return OnBoardingScreen();
                    }
                  }
                });
          }
        });
  }
}
