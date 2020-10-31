import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/bean/bcn_syncing_response.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';

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
    _timerSync = Timer(const Duration(seconds: 1), () async {
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
    return bcnSyncingResponse == null
        ? Chip(
            backgroundColor: Colors.red,
            padding: EdgeInsets.all(0),
            label: Text('Not connected',
                style: TextStyle(fontSize: 12, color: Colors.white)),
          )
        : bcnSyncingResponse.result.syncing
            ? Chip(
                backgroundColor: Colors.orange[600],
                padding: EdgeInsets.all(0),
                label: Text('Not synchronized',
                    style: TextStyle(fontSize: 12, color: Colors.white)),
              )
            : Chip(
                backgroundColor: Colors.green,
                padding: EdgeInsets.all(0),
                label: Text('Synchronized',
                    style: TextStyle(fontSize: 12, color: Colors.white)),
              );
  }
}
