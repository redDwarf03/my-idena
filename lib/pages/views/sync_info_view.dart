import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/bean/bcn_syncing_response.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';
import 'package:my_idena/main.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/utils/util_public_node.dart';

class SyncInfoView extends StatefulWidget {
  const SyncInfoView({Key key}) : super(key: key);

  @override
  _SyncInfoViewState createState() => _SyncInfoViewState();
}

class _SyncInfoViewState extends State<SyncInfoView> {
  Timer _timerSync;
  BcnSyncingResponse bcnSyncingResponse;
  HttpService httpService = new HttpService();

  @override
  void initState() {
    _timeSyncUpdate();
    super.initState();
  }

  @override
  void dispose() {
    _timerSync.cancel();
    super.dispose();
  }

  _timeSyncUpdate() {
    _timerSync = Timer(const Duration(milliseconds: 200), () async {
      bcnSyncingResponse = await httpService.checkSync();
      if (!mounted) return;
      setState(() {});
      _timeSyncUpdate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildChild();
  }

  Widget _buildChild() {
    return getPublicNode() == null
        ? Chip(
            backgroundColor: Colors.red,
            padding: EdgeInsets.all(0),
            label: Text(AppLocalizations.of(context).translate("Not connected"),
                style: TextStyle(fontSize: 12, color: Colors.white)),
          )
        : idenaAddress == ""
            ? Chip(
                backgroundColor: Colors.red,
                padding: EdgeInsets.all(0),
                label: Text(
                    AppLocalizations.of(context).translate("Not connected"),
                    style: TextStyle(fontSize: 12, color: Colors.white)),
              )
            : getPublicNode()
                ? Chip(
                    backgroundColor: Colors.blue[800],
                    padding: EdgeInsets.all(0),
                    label: Text(
                        AppLocalizations.of(context).translate("Public Node"),
                        style: TextStyle(fontSize: 12, color: Colors.white)),
                  )
                : bcnSyncingResponse.result.syncing
                    ? Chip(
                        backgroundColor: Colors.orange[600],
                        padding: EdgeInsets.all(0),
                        label: Text(
                            AppLocalizations.of(context)
                                .translate("Not synchronized"),
                            style:
                                TextStyle(fontSize: 12, color: Colors.white)),
                      )
                    : Chip(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.all(0),
                        label: Text(
                            AppLocalizations.of(context)
                                .translate("Synchronized"),
                            style:
                                TextStyle(fontSize: 12, color: Colors.white)),
                      );
  }
}
