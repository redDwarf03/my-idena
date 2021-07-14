// @dart=2.9

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:idena_lib_dart/factory/app_service.dart';
import 'package:idena_lib_dart/model/response/bcn_syncing_response.dart';
import 'package:idena_lib_dart/model/response/dna_identity_response.dart';

// Project imports:
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/util/util_node.dart';

class SyncInfoView extends StatefulWidget {
  const SyncInfoView({Key key}) : super(key: key);

  @override
  _SyncInfoViewState createState() => _SyncInfoViewState();
}

class _SyncInfoViewState extends State<SyncInfoView> {
  Timer _timerSync;
  bool _status = true;
  int _nodeType = UNKOWN_NODE;
  bool _mining;
  int _nbOfInvites = 0;
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
      _nodeType = await NodeUtil().getNodeType();

      if (StateContainer.of(context).selectedAccount.address != null) {
        DnaIdentityResponse _dnaIdentityResponse = await sl
            .get<AppService>()
            .getDnaIdentity(StateContainer.of(context).selectedAccount.address);
        if (_dnaIdentityResponse != null &&
            _dnaIdentityResponse.result != null) {
          _mining = _dnaIdentityResponse.result.online;
          _nbOfInvites = _dnaIdentityResponse.result.invites;
        }
      }
      _bcnSyncingResponse = await sl.get<AppService>().checkSync();
      if (_bcnSyncingResponse != null &&
          _bcnSyncingResponse.result != null) {
        _status = true;
      } else {
        _status = false;
      }
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
        Column(
          children: [
            _nbOfInvites != null && _nbOfInvites > 0
                ? Icon(
                    FontAwesome.user_plus,
                    color: StateContainer.of(context).curTheme.primary,
                    size: 15,
                  )
                : Icon(
                    FontAwesome.user_plus,
                    color: Colors.grey[600],
                    size: 15,
                  ),
            SizedBox(height: 3),
            _nbOfInvites != null && _nbOfInvites > 0
                ? _nbOfInvites == 1
                    ? Text(_nbOfInvites.toString() + " Invite",
                        style: TextStyle(
                            color: StateContainer.of(context).curTheme.primary,
                            fontSize: 8))
                    : Text(_nbOfInvites.toString() + " Invites",
                        style: TextStyle(
                            color: StateContainer.of(context).curTheme.primary,
                            fontSize: 8))
                : Text("0 Invite",
                    style: TextStyle(color: Colors.grey[600], fontSize: 8)),
          ],
        ),
        SizedBox(width: 10),
        Column(
          children: [
            Icon(
              AppIcons.share,
              color: StateContainer.of(context).curTheme.primary,
              size: 15,
            ),
            SizedBox(height: 3),
            Text(NodeUtil().getLabel(_nodeType),
                style: TextStyle(
                    color: StateContainer.of(context).curTheme.primary,
                    fontSize: 8)),
          ],
        ),
        SizedBox(width: 10),
        _nodeType != SHARED_NODE && _nodeType != DEMO_NODE && _mining != null
            ? Column(
                children: [
                  _mining == false
                      ? Icon(RpgAwesome.mining_diamonds,
                          size: 24, color: Colors.grey)
                      : Icon(RpgAwesome.mining_diamonds,
                          size: 24, color: Colors.green),
                ],
              )
            : SizedBox(),
             SizedBox(width: 10),
        _nodeType == DEMO_NODE
            ? SizedBox()
            : _bcnSyncingResponse != null && _bcnSyncingResponse.result.syncing
                ? _bcnSyncingResponse != null &&
                        _bcnSyncingResponse.result.highestBlock == 0
                    ? Column(
                        children: [
                          Icon(Icons.find_replace,
                              color: Colors.orange, size: 18),
                          Text(AppLocalization.of(context).peersNotFound,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 8))
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                            Text(
                                _bcnSyncingResponse.result.currentBlock
                                        .toString() +
                                    "\n/" +
                                    _bcnSyncingResponse.result.highestBlock
                                        .toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 8)),
                            Text(
                                AppLocalization.of(context).synchronizingBlocks,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 8))
                          ])
                : Text(""),
        _nodeType == DEMO_NODE ? SizedBox() : SizedBox(width: 10),
        _nodeType == DEMO_NODE
            ? SizedBox()
            : Column(
                children: [
                  _status == false
                      ? Icon(
                          Icons
                              .signal_cellular_connected_no_internet_4_bar_rounded,
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
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 8))
                          : Text(AppLocalization.of(context).connected,
                              style:
                                  TextStyle(color: Colors.green, fontSize: 8))
                ],
              ),
      ],
    );
  }
}
