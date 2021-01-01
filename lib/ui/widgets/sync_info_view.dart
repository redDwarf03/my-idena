import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/network/model/response/bcn_syncing_response.dart';
import 'package:my_idena/service/app_service.dart';
import 'package:my_idena/util/util_demo_mode.dart';
import 'package:my_idena/util/util_public_node.dart';

class SyncInfoView extends StatefulWidget {
  const SyncInfoView({Key key}) : super(key: key);

  @override
  _SyncInfoViewState createState() => _SyncInfoViewState();
}

class _SyncInfoViewState extends State<SyncInfoView> {
  Timer _timerSync;
  bool _status = true;
  bool _publicNode = false;
  bool _demoMode = false;
  AppService appService = new AppService();
  BcnSyncingResponse _bcnSyncingResponse;
  int _initialCurrentBlock = 0;

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
      _status = await appService.getWStatusGetResponse();
      _publicNode = await PublicNodeUtil().getPublicNode();
      _demoMode = await DemoModeUtil().getDemoModeStatus();
      _bcnSyncingResponse = await appService.checkSync();
      if (_initialCurrentBlock == 0 &&
          _bcnSyncingResponse != null &&
          _bcnSyncingResponse.result.highestBlock == 0) {
        _initialCurrentBlock = _bcnSyncingResponse.result.currentBlock;
      }
      if (_initialCurrentBlock != 0 &&
          _bcnSyncingResponse != null &&
          _bcnSyncingResponse.result.highestBlock != 0 &&
          _bcnSyncingResponse.result.highestBlock ==
              _bcnSyncingResponse.result.currentBlock) {
        _initialCurrentBlock = 0;
      }
      if (!mounted) return;
      setState(() {});
      _timeSyncUpdate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildChild(context);
  }

  Widget _buildChild(BuildContext context) {
    return Row(
      children: [
        _demoMode
            ? Column(
                children: [
                  Icon(
                    AppIcons.share,
                    color: Colors.green,
                    size: 15,
                  ),
                  SizedBox(height: 3),
                  Text(AppLocalization.of(context).demoMode,
                      style: TextStyle(color: Colors.green, fontSize: 8)),
                ],
              )
            : SizedBox(),
        SizedBox(width: 10),
        _publicNode
            ? Column(
                children: [
                  Icon(
                    AppIcons.share,
                    color: StateContainer.of(context).curTheme.primary,
                    size: 15,
                  ),
                  SizedBox(height: 3),
                  Text(AppLocalization.of(context).publicNode,
                      style: TextStyle(
                          color: StateContainer.of(context).curTheme.primary,
                          fontSize: 8)),
                ],
              )
            : SizedBox(),
        SizedBox(width: 10),
        _bcnSyncingResponse != null && _bcnSyncingResponse.result.syncing
            ? _bcnSyncingResponse != null &&
                    _bcnSyncingResponse.result.highestBlock == 0
                ? Column(
                    children: [
                      Icon(Icons.find_replace, color: Colors.orange, size: 18),
                      Text(AppLocalization.of(context).peersNotFound,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.orange, fontSize: 8))
                    ],
                  )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  
                    Text(
                        _bcnSyncingResponse.result.currentBlock.toString() +
                            "\n/" +
                            _bcnSyncingResponse.result.highestBlock.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.orange, fontSize: 8)),
                    Text(AppLocalization.of(context).synchronizingBlocks,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.orange, fontSize: 8))
                  ])
            : Text(""),
        SizedBox(width: 10),
        Column(
          children: [
            _status == false
                ? Icon(
                    Icons.signal_cellular_connected_no_internet_4_bar_rounded,
                    color: Colors.red,
                    size: 18)
                : _bcnSyncingResponse != null &&
                        _bcnSyncingResponse.result != null &&
                        _bcnSyncingResponse.result.syncing != null &&
                        _bcnSyncingResponse.result.syncing
                    ? Icon(Icons.signal_cellular_alt_rounded,
                        color: Colors.orange, size: 18)
                    : Icon(Icons.signal_cellular_alt_rounded,
                        color: Colors.green, size: 18),
            _status == false
                ? Text(AppLocalization.of(context).notConnected,
                    style: TextStyle(color: Colors.red, fontSize: 8))
                : _bcnSyncingResponse != null &&
                        _bcnSyncingResponse.result != null &&
                        _bcnSyncingResponse.result.syncing != null &&
                        _bcnSyncingResponse.result.syncing
                    ? Text(AppLocalization.of(context).notSynchronized,
                        style: TextStyle(color: Colors.orange, fontSize: 8))
                    : Text(AppLocalization.of(context).connected,
                        style: TextStyle(color: Colors.green, fontSize: 8))
          ],
        ),
      ],
    );
  }
}
