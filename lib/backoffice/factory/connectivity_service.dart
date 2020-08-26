import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:my_idena/enums/connection_status.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:provider/provider.dart';

class ConnectivityService {
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectionStatusController.add(_getStatusFromResult(result));
    });
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }

  Widget getConnectionStatus(BuildContext context) {
    // Get our connection status from the provider
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    if (connectionStatus == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      if (connectionStatus == ConnectivityStatus.WiFi) {
        return Row(
          children: [
            Icon(
              Icons.network_check,
              size: 30,
              color: Colors.green,
            ),
            Text(
              AppLocalizations.of(context).translate("Wifi"),
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontFamily: MyIdenaAppTheme.fontName,
                  letterSpacing: -0.2,
                  fontWeight: FontWeight.w500),
            ),
          ],
        );
      } else {
        if (connectionStatus == ConnectivityStatus.Cellular) {
          return Opacity(
              opacity: 1,
              child: Row(
                children: [
                  Icon(
                    Icons.network_check,
                    size: 20,
                    color: Colors.green,
                  ),
                  Text(
                    AppLocalizations.of(context).translate("Cellular"),
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontFamily: MyIdenaAppTheme.fontName,
                        letterSpacing: -0.2,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ));
        } else {
          if (connectionStatus == ConnectivityStatus.Offline) {
            return Opacity(
                opacity: 0.5,
                child: Row(
                  children: [
                    Icon(
                      Icons.network_check,
                      size: 30,
                      color: Colors.red,
                    ),
                    Text(AppLocalizations.of(context).translate("Offline"),
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontFamily: MyIdenaAppTheme.fontName,
                            letterSpacing: -0.2,
                            fontWeight: FontWeight.w500)),
                  ],
                ));
          }
          else
          {
            return SizedBox(width: 1, height: 1,);
          }
        }
      }
    }
  }
}
