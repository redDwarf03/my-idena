// @dart=2.9
import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/base/animation/actor_animation.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:my_idena/model/deepLinks/idena_url.dart';
import 'package:my_idena/factory/app_service.dart';
import 'package:my_idena/themes.dart';
import 'package:my_idena/ui/send/send_sheet.dart';
import 'package:my_idena/ui/smartContracts/smart_contract_vote_sheet.dart';
import 'package:my_idena/ui/widgets/dialog.dart';
import 'package:my_idena/util/enums/identity_status.dart' as IdentityStatus;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:my_idena/network/model/response/bcn_transactions_response.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/model/db/contact.dart';
import 'package:my_idena/model/db/appdb.dart';
import 'package:my_idena/network/model/block_types.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/ui/contacts/add_contact.dart';
import 'package:my_idena/ui/popup_button.dart';
import 'package:my_idena/ui/receive/receive_sheet.dart';
import 'package:my_idena/ui/settings/settings_drawer.dart';
import 'package:my_idena/ui/validation_session/validation_session_countdown_view.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/ui/widgets/sheet_util.dart';
import 'package:my_idena/ui/widgets/list_slidable.dart';
import 'package:my_idena/ui/util/routes.dart';
import 'package:my_idena/ui/widgets/reactive_refresh.dart';
import 'package:my_idena/ui/util/ui_util.dart';
import 'package:my_idena/ui/widgets/sync_info_view.dart';
import 'package:my_idena/util/helpers.dart';

import 'package:my_idena/util/sharedprefsutil.dart';
import 'package:my_idena/util/hapticutil.dart';
import 'package:my_idena/util/caseconverter.dart';
import 'package:my_idena/util/util_node.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:my_idena/bus/events.dart';

class AppHomePage extends StatefulWidget {
  PriceConversion priceConversion;

  AppHomePage({this.priceConversion}) : super();

  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage>
    with
        WidgetsBindingObserver,
        SingleTickerProviderStateMixin,
        FlareController {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Logger log = sl.get<Logger>();

  // Controller for placeholder card animations
  AnimationController _placeholderCardAnimationController;
  Animation<double> _opacityAnimation;
  bool _animationDisposed;

  // Receive card instance
  ReceiveSheet receive;

  // A separate unfortunate instance of this list, is a little unfortunate
  // but seems the only way to handle the animations
  final Map<String, GlobalKey<AnimatedListState>> _listKeyMap = Map();

  // List of contacts (Store it so we only have to query the DB once for transaction cards)
  List<Contact> _contacts = List();

  // Price conversion state (BTC, app cryptocurrency, NONE)
  PriceConversion _priceConversion;

  bool _isRefreshing = false;

  bool _lockDisabled = false; // whether we should avoid locking the app

  int _nodeType = UNKOWN_NODE;

  // Main card height
  double mainCardHeight;
  double settingsIconMarginTop = 5;

  // Animation for swiping to send
  ActorAnimation _sendSlideAnimation;
  ActorAnimation _sendSlideReleaseAnimation;
  double _fanimationPosition;
  bool releaseAnimation = false;

  void initialize(FlutterActorArtboard actor) {
    _fanimationPosition = 0.0;
    _sendSlideAnimation = actor.getAnimation("pull");
    _sendSlideReleaseAnimation = actor.getAnimation("release");
  }

  void setViewTransform(Mat2D viewTransform) {}

  bool advance(FlutterActorArtboard artboard, double elapsed) {
    if (releaseAnimation) {
      _sendSlideReleaseAnimation.apply(
          _sendSlideReleaseAnimation.duration * (1 - _fanimationPosition),
          artboard,
          1.0);
    } else {
      _sendSlideAnimation.apply(
          _sendSlideAnimation.duration * _fanimationPosition, artboard, 1.0);
    }
    return true;
  }

  @override
  void initState() {
    super.initState();

    _setNodeType();
    _registerBus();
    WidgetsBinding.instance.addObserver(this);
    if (widget.priceConversion != null) {
      _priceConversion = widget.priceConversion;
    } else {
      _priceConversion = PriceConversion.BTC;
    }
    // Main Card Size
    if (_priceConversion == PriceConversion.BTC) {
      mainCardHeight = 120;
      settingsIconMarginTop = 7;
    } else if (_priceConversion == PriceConversion.NONE) {
      mainCardHeight = 64;
      settingsIconMarginTop = 7;
    } else if (_priceConversion == PriceConversion.HIDDEN) {
      mainCardHeight = 64;
      settingsIconMarginTop = 5;
    }

    _addSampleContact();
    _updateContacts();

    // Setup placeholder animation and start
    _animationDisposed = false;
    _placeholderCardAnimationController = new AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _placeholderCardAnimationController
        .addListener(_animationControllerListener);
    _opacityAnimation = new Tween(begin: 1.0, end: 0.4).animate(
      CurvedAnimation(
        parent: _placeholderCardAnimationController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      ),
    );
    _opacityAnimation.addStatusListener(_animationStatusListener);
    _placeholderCardAnimationController.forward();
  }

  void _animationStatusListener(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
        _placeholderCardAnimationController.forward();
        break;
      case AnimationStatus.completed:
        _placeholderCardAnimationController.reverse();
        break;
      default:
        return null;
    }
  }

  void _animationControllerListener() {
    setState(() {});
  }

  void _startAnimation() {
    if (_animationDisposed) {
      _animationDisposed = false;
      _placeholderCardAnimationController
          .addListener(_animationControllerListener);
      _opacityAnimation.addStatusListener(_animationStatusListener);
      _placeholderCardAnimationController.forward();
    }
  }

  void _disposeAnimation() {
    if (!_animationDisposed) {
      _animationDisposed = true;
      _opacityAnimation.removeStatusListener(_animationStatusListener);
      _placeholderCardAnimationController
          .removeListener(_animationControllerListener);
      _placeholderCardAnimationController.stop();
    }
  }

  Future<void> _setNodeType() async {
    _nodeType = await NodeUtil().getNodeType();
  }

  /// Add donations contact if it hasnt already been added
  Future<void> _addSampleContact() async {
    bool contactAdded = await sl.get<SharedPrefsUtil>().getFirstContactAdded();
    if (!contactAdded) {
      bool addressExists = await sl
          .get<DBHelper>()
          .contactExistsWithAddress(AppLocalization.of(context).donationsUrl);
      if (addressExists) {
        return;
      }
      bool nameExists = await sl
          .get<DBHelper>()
          .contactExistsWithName(AppLocalization.of(context).donationsName);
      if (nameExists) {
        return;
      }
      await sl.get<SharedPrefsUtil>().setFirstContactAdded(true);
      Contact c = Contact(
          name: AppLocalization.of(context).donationsName,
          address: AppLocalization.of(context).donationsUrl);
      await sl.get<DBHelper>().saveContact(c);
    }
  }

  void _updateContacts() {
    sl.get<DBHelper>().getContacts().then((contacts) {
      setState(() {
        _contacts = contacts;
      });
    });
  }

  StreamSubscription<HistoryHomeEvent> _historySub;
  StreamSubscription<ContactModifiedEvent> _contactModifiedSub;
  StreamSubscription<DisableLockTimeoutEvent> _disableLockSub;
  StreamSubscription<AccountChangedEvent> _switchAccountSub;

  void _registerBus() {
    _historySub = EventTaxiImpl.singleton()
        .registerTo<HistoryHomeEvent>()
        .listen((event) {
      setState(() {
        _isRefreshing = false;
      });
      if (StateContainer.of(context).initialDeepLink != null) {
        handleDeepLink(StateContainer.of(context).initialDeepLink);
        StateContainer.of(context).initialDeepLink = null;
      }
    });
    _contactModifiedSub = EventTaxiImpl.singleton()
        .registerTo<ContactModifiedEvent>()
        .listen((event) {
      _updateContacts();
    });
    // Hackish event to block auto-lock functionality
    _disableLockSub = EventTaxiImpl.singleton()
        .registerTo<DisableLockTimeoutEvent>()
        .listen((event) {
      if (event.disable) {
        cancelLockEvent();
      }
      _lockDisabled = event.disable;
    });
    // User changed account
    _switchAccountSub = EventTaxiImpl.singleton()
        .registerTo<AccountChangedEvent>()
        .listen((event) {
      setState(() {
        StateContainer.of(context).wallet.loading = true;
        StateContainer.of(context).wallet.historyLoading = true;

        _startAnimation();
        StateContainer.of(context).updateWallet(account: event.account);
      });
      paintQrCode(address: event.account.address);
      if (event.delayPop) {
        Future.delayed(Duration(milliseconds: 300), () {
          Navigator.of(context).popUntil(RouteUtils.withNameLike("/home"));
        });
      } else if (!event.noPop) {
        Navigator.of(context).popUntil(RouteUtils.withNameLike("/home"));
      }
    });
  }

  @override
  void dispose() {
    _destroyBus();
    WidgetsBinding.instance.removeObserver(this);
    _placeholderCardAnimationController.dispose();
    super.dispose();
  }

  void _destroyBus() {
    if (_historySub != null) {
      _historySub.cancel();
    }
    if (_contactModifiedSub != null) {
      _contactModifiedSub.cancel();
    }
    if (_disableLockSub != null) {
      _disableLockSub.cancel();
    }
    if (_switchAccountSub != null) {
      _switchAccountSub.cancel();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle websocket connection when app is in background
    // terminate it to be eco-friendly
    setBrightnessMode();
    switch (state) {
      case AppLifecycleState.paused:
        setAppLockEvent();
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.resumed:
        cancelLockEvent();
        if (!StateContainer.of(context).wallet.loading &&
            StateContainer.of(context).initialDeepLink != null) {
          handleDeepLink(StateContainer.of(context).initialDeepLink);
          StateContainer.of(context).initialDeepLink = null;
        }
        super.didChangeAppLifecycleState(state);
        break;
      default:
        super.didChangeAppLifecycleState(state);
        break;
    }
  }

  // To lock and unlock the app
  StreamSubscription<dynamic> lockStreamListener;

  Future<void> setAppLockEvent() async {
    if (((await sl.get<SharedPrefsUtil>().getLock())) && !_lockDisabled) {
      if (lockStreamListener != null) {
        lockStreamListener.cancel();
      }
      Future<dynamic> delayed = new Future.delayed(
          (await sl.get<SharedPrefsUtil>().getLockTimeout()).getDuration());
      delayed.then((_) {
        return true;
      });
      lockStreamListener = delayed.asStream().listen((_) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      });
    }
  }

  Future<void> cancelLockEvent() async {
    if (lockStreamListener != null) {
      lockStreamListener.cancel();
    }
  }

  void setBrightnessMode() {
    setState(() {
      StateContainer.of(context).curTheme =
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? IdenaDarkTheme()
              : IdenaTheme();
    });
  }

  // Used to build list items that haven't been removed.
  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    if (index >= StateContainer.of(context).wallet.history.length) {
    } else {
      String displayName = smallScreen(context)
          ? StateContainer.of(context)
              .wallet
              .history[index]
              .getShorterString(context)
          : StateContainer.of(context)
              .wallet
              .history[index]
              .getShortString(context);
      _contacts.forEach((contact) {
        if (contact.address.toLowerCase() ==
            StateContainer.of(context)
                .wallet
                .history[index]
                .to
                .toString()
                .toLowerCase()) {
          displayName = contact.name;
        }
      });
      return _buildTransactionCard(
          StateContainer.of(context).wallet.history[index],
          animation,
          displayName,
          context);
    }
  }

  // Return widget for list
  Widget _getListWidget(BuildContext context) {
    if (StateContainer.of(context).wallet == null ||
        StateContainer.of(context).wallet.historyLoading) {
      // Loading Animation
      return ReactiveRefreshIndicator(
          backgroundColor: StateContainer.of(context).curTheme.backgroundDark,
          onRefresh: _refresh,
          isRefreshing: _isRefreshing,
          child: ListView(
            padding: EdgeInsetsDirectional.fromSTEB(0, 5.0, 0, 15.0),
            children: <Widget>[
              _buildLoadingTransactionCard(
                  "Sent", "10244000", "123456789121234", context),
              _buildLoadingTransactionCard(
                  "Received", "100,00000", "@reddwarf1234", context),
              _buildLoadingTransactionCard(
                  "Sent", "14500000", "12345678912345671234", context),
              _buildLoadingTransactionCard(
                  "Sent", "12,51200", "123456789121234", context),
              _buildLoadingTransactionCard(
                  "Received", "1,45300", "123456789121234", context),
              _buildLoadingTransactionCard(
                  "Sent", "100,00000", "12345678912345671234", context),
              _buildLoadingTransactionCard(
                  "Received", "24,00000", "12345678912345671234", context),
              _buildLoadingTransactionCard(
                  "Sent", "1,00000", "123456789121234", context),
              _buildLoadingTransactionCard(
                  "Sent", "1,00000", "123456789121234", context),
              _buildLoadingTransactionCard(
                  "Sent", "1,00000", "123456789121234", context),
            ],
          ));
    } else if (StateContainer.of(context).wallet.history.length == 0 &&
        _nodeType != SHARED_NODE &&
        _nodeType != PUBLIC_NODE) {
      _disposeAnimation();
      return ReactiveRefreshIndicator(
        backgroundColor: StateContainer.of(context).curTheme.backgroundDark,
        child: ListView(
          padding: EdgeInsetsDirectional.fromSTEB(0, 5.0, 0, 15.0),
          children: <Widget>[
            _buildWelcomeTransactionCard(context),
            _buildDummyTransactionCard(
              AppLocalization.of(context).sent,
              AppLocalization.of(context).exampleCardLittle,
              AppLocalization.of(context).exampleCardTo,
              context,
            ),
            _buildDummyTransactionCard(
              AppLocalization.of(context).received,
              AppLocalization.of(context).exampleCardLot,
              AppLocalization.of(context).exampleCardFrom,
              context,
            ),
          ],
        ),
        onRefresh: _refresh,
        isRefreshing: _isRefreshing,
      );
    } else {
      _disposeAnimation();
    }
    return ReactiveRefreshIndicator(
      backgroundColor: StateContainer.of(context).curTheme.backgroundDark,
      child: AnimatedList(
        key: _listKeyMap[StateContainer.of(context).wallet.address],
        padding: EdgeInsetsDirectional.fromSTEB(0, 5.0, 0, 15.0),
        initialItemCount: StateContainer.of(context).wallet.history.length,
        itemBuilder: _buildItem,
      ),
      onRefresh: _refresh,
      isRefreshing: _isRefreshing,
    );
  }

  // Refresh list
  Future<void> _refresh() async {
    setState(() {
      _isRefreshing = true;
    });
    sl.get<HapticUtil>().success();
    StateContainer.of(context).requestUpdate();

    // Hide refresh indicator after 3 seconds if no server response
    Future.delayed(new Duration(seconds: 3), () {
      setState(() {
        _isRefreshing = false;
      });
    });
  }

  void handleDeepLink(String link) {
    IdenaUrl idenaUrl = new IdenaUrl().getInfo(Uri.decodeFull(link));

    if (idenaUrl.deepLinkParamSignin != null) {
      Navigator.of(context)
          .pushNamed('/signin', arguments: idenaUrl.deepLinkParamSignin);
    } else if (idenaUrl.deepLinkParamSend != null) {
      Sheets.showAppHeightNineSheet(
          context: context,
          widget: SendSheet(
              quickSendAmount: idenaUrl.deepLinkParamSend.amount,
              address: idenaUrl.deepLinkParamSend.address,
              localCurrency: StateContainer.of(context).curCurrency));
    }
  }

  void paintQrCode({String address}) {
    if (StateContainer.of(context).wallet.address != null && address != null) {
      QrPainter painter = QrPainter(
        data: address == null
            ? StateContainer.of(context).wallet.address
            : address,
        version: 6,
        gapless: false,
        errorCorrectionLevel: QrErrorCorrectLevel.Q,
      );
      painter.toImageData(MediaQuery.of(context).size.width).then((byteData) {
        setState(() {
          receive = ReceiveSheet(
            qrWidget: Container(
                width: MediaQuery.of(context).size.width / 2.675,
                child: Image.memory(byteData.buffer.asUint8List())),
          );
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Create QR ahead of time because it improves performance this way
    if (receive == null && StateContainer.of(context).wallet != null) {
      paintQrCode(address: StateContainer.of(context).wallet.address);
    }

    return Scaffold(
      drawerEdgeDragWidth: 200,
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      backgroundColor: StateContainer.of(context).curTheme.background,
      drawer: SizedBox(
        width: UIUtil.drawerWidth(context),
        child: Drawer(
          child: SettingsSheet(receive, _nodeType, context),
        ),
      ),
      body: SafeArea(
        minimum: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.045,
            bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  //Everything else
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Main Card
                      _buildMainCard(context, _scaffoldKey),
                      //Main Card End

                      //Transactions Text
                      Container(
                        margin: EdgeInsetsDirectional.fromSTEB(
                            30.0, 20.0, 26.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _nodeType != SHARED_NODE && _nodeType != PUBLIC_NODE
                                ? Text(
                                    CaseChange.toUpperCase(
                                        AppLocalization.of(context)
                                            .transactions,
                                        context),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w100,
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .text,
                                    ),
                                  )
                                : SizedBox(),
                            SyncInfoView(),
                          ],
                        ),
                      ), //Transactions Text End

                      //Transactions List
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            _getListWidget(context),
                            //List Top Gradient End
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 10.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      StateContainer.of(context)
                                          .curTheme
                                          .background00,
                                      StateContainer.of(context)
                                          .curTheme
                                          .background
                                    ],
                                    begin: AlignmentDirectional(0.5, 1.0),
                                    end: AlignmentDirectional(0.5, -1.0),
                                  ),
                                ),
                              ),
                            ), // List Top Gradient End

                            //List Bottom Gradient
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 30.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      StateContainer.of(context)
                                          .curTheme
                                          .background00,
                                      StateContainer.of(context)
                                          .curTheme
                                          .background
                                    ],
                                    begin: AlignmentDirectional(0.5, -1),
                                    end: AlignmentDirectional(0.5, 0.5),
                                  ),
                                ),
                              ),
                            ), //List Bottom Gradient End
                          ],
                        ),
                      ), //Transactions List End
                      //Buttons background
                      SizedBox(
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                      ), //Buttons background
                    ],
                  ),
                  //
                  //_nodeType != SHARED_NODE &&
                  _nodeType != PUBLIC_NODE && _nodeType != UNKOWN_NODE
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            AppPopupButton(),
                            ValidationSessionCountdownText(),
                          ],
                        )
                      : _nodeType == UNKOWN_NODE
                          ? SizedBox()
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    bottomLeft: Radius.circular(8.0),
                                    bottomRight: Radius.circular(8.0),
                                    topRight: Radius.circular(68.0)),
                                color: Colors.red[300],
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      offset: Offset(0.1, 1.1),
                                      blurRadius: 5.0),
                                ],
                              ),
                              height: 130,
                              width: (MediaQuery.of(context).size.width - 14),
                              margin: EdgeInsetsDirectional.only(
                                  start: 7, top: 0.0, end: 7.0),
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 0, bottom: 0),
                                  child: Container(
                                      child: Row(children: <Widget>[
                                    Expanded(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                          Column(
                                            children: [
                                              Icon(Icons.warning,
                                                  color: Colors.white),
                                              _nodeType == SHARED_NODE
                                                  ? Text(
                                                      "WARNING:\nValidation Session with shared node is not yet available on this app. Work in progress...\nPlease use the web application: https://app.idena.io")
                                                  : Text(
                                                      "WARNING:\nValidation Session with public node is not available\nPlease use the web application: https://app.idena.io")
                                            ],
                                          )
                                        ]))
                                  ])))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Transaction Card/List Item
  Widget _buildTransactionCard(Transaction item, Animation<double> animation,
      String displayName, BuildContext context) {
    if (BlockTypes().isHiddenType(item.type)) {
      return SizedBox();
    } else {
      String typeLabel = BlockTypes()
          .getTransactionTypeLabel(item.type, item.payload, context);
      String text = typeLabel == "" ? item.type : typeLabel;
      text = item.smartContractMultiSig != null &&
              item.to == StateContainer.of(context).selectedAccount.address
          ? "Demand to vote"
          : text;
      return Slidable(
        delegate: SlidableScrollDelegate(),
        actionExtentRatio: 0.35,
        movementDuration: Duration(milliseconds: 300),
        enabled: StateContainer.of(context).wallet != null &&
            StateContainer.of(context).wallet.accountBalance > 0,
        onTriggered: (preempt) {},
        onAnimationChanged: (animation) {
          if (animation != null) {
            _fanimationPosition = animation.value;
            if (animation.value == 0.0 && releaseAnimation) {
              setState(() {
                releaseAnimation = false;
              });
            }
          }
        },
        secondaryActions: <Widget>[
          SlideAction(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              margin: EdgeInsetsDirectional.only(
                  end: MediaQuery.of(context).size.width * 0.15,
                  top: 4,
                  bottom: 4),
              child: Container(
                alignment: AlignmentDirectional(-0.5, 0),
                constraints: BoxConstraints.expand(),
                child: FlareActor("assets/pulltosend_animation.flr",
                    animation: "pull",
                    fit: BoxFit.contain,
                    controller: this,
                    color: StateContainer.of(context).curTheme.primary),
              ),
            ),
          ),
        ],
        child: _SizeTransitionNoClip(
          sizeFactor: animation,
          child: Container(
            margin: EdgeInsetsDirectional.fromSTEB(14.0, 4.0, 14.0, 4.0),
            decoration: BoxDecoration(
              color: StateContainer.of(context).curTheme.backgroundDark,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [StateContainer.of(context).curTheme.boxShadow],
            ),
            child: FlatButton(
              highlightColor: StateContainer.of(context).curTheme.text15,
              splashColor: StateContainer.of(context).curTheme.text15,
              color: StateContainer.of(context).curTheme.backgroundDark,
              padding: EdgeInsets.all(0.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              onPressed: () {
                Sheets.showAppHeightEightSheet(
                    color: StateContainer.of(context).curTheme.background,
                    context: context,
                    widget: TransactionDetailsSheet(
                        item: item, displayName: displayName),
                    animationDurationMs: 175);
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 14.0, horizontal: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 3.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  text,
                                  textAlign: TextAlign.start,
                                  style: AppStyles.textStyleTransactionType(
                                      context),
                                ),
                                item.timestamp > 0
                                    ? Text(
                                        DateFormat.yMEd(
                                                Localizations.localeOf(context)
                                                    .languageCode)
                                            .add_Hm()
                                            .format(DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        item.timestamp * 1000)
                                                .toLocal())
                                            .toString(),
                                        style:
                                            AppStyles.textStyleTransactionUnit(
                                                context),
                                      )
                                    : Text(
                                        AppLocalization.of(context)
                                            .transactionDetailUnconfirmed,
                                        textAlign: TextAlign.start,
                                        style:
                                            AppStyles.textStyleTransactionUnit(
                                                context),
                                      ),
                                item.smartContractMultiSig != null &&
                                        item.to ==
                                            StateContainer.of(context)
                                                .selectedAccount
                                                .address
                                    ? new SizedBox(
                                        height: 18.0,
                                        width: 18.0,
                                        child: IconButton(
                                            highlightColor:
                                                StateContainer.of(context)
                                                    .curTheme
                                                    .text15,
                                            splashColor:
                                                StateContainer.of(context)
                                                    .curTheme
                                                    .text15,
                                            onPressed: () {
                                              Sheets.showAppHeightEightSheet(
                                                  context: context,
                                                  widget: SmartContractVoteSheet(
                                                      title: AppLocalization
                                                              .of(context)
                                                          .multisigTitle,
                                                      contractAddress: item
                                                          .smartContractMultiSig
                                                          .contractAddress,
                                                      contractBalance: item
                                                          .smartContractMultiSig
                                                          .balance
                                                          .toString(),
                                                      nodeAddress:
                                                          StateContainer.of(
                                                                  context)
                                                              .selectedAccount
                                                              .address));
                                            },
                                            padding: EdgeInsets.all(0.0),
                                            icon: Icon(FontAwesome5.signature,
                                                color: Colors.red[400],
                                                size: 18)),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 2.4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  double.tryParse(item
                                              .getFormattedAmount()
                                              .replaceAll(",", "")) >
                                          0
                                      ? Container(
                                          child: RichText(
                                            textAlign: TextAlign.start,
                                            text: TextSpan(
                                              text: '',
                                              children: [
                                                TextSpan(
                                                  text: item.from !=
                                                          StateContainer.of(
                                                                  context)
                                                              .selectedAccount
                                                              .address
                                                      ? "+ " +
                                                          item
                                                              .getFormattedAmount() +
                                                          " IDNA"
                                                      : "- " +
                                                          item.getFormattedAmount() +
                                                          " IDNA",
                                                  style: item.from !=
                                                          StateContainer.of(
                                                                  context)
                                                              .selectedAccount
                                                              .address
                                                      ? AppStyles
                                                          .textStyleTransactionTypeGreen(
                                                              context)
                                                      : AppStyles
                                                          .textStyleTransactionTypeRed(
                                                              context),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  item.to == null
                                      ? item.type == 'online'
                                          ? item.payload == '0x'
                                              ? Icon(RpgAwesome.mining_diamonds,
                                                  color: Colors.grey
                                                      .withOpacity(0.6))
                                              : Icon(RpgAwesome.mining_diamonds,
                                                  color: Colors.green
                                                      .withOpacity(0.6))
                                          : item.type == 'submitFlip'
                                              ? Icon(Entypo.picture,
                                                  color:
                                                      StateContainer.of(context)
                                                          .curTheme
                                                          .primary60)
                                              : SizedBox()
                                      : Container(
                                          width: 26.0,
                                          height: 26.0,
                                          child: CircleAvatar(
                                            backgroundColor:
                                                StateContainer.of(context)
                                                    .curTheme
                                                    .text05,
                                            backgroundImage:
                                                UIUtil.getRobohashURL(
                                                    item.from !=
                                                            StateContainer.of(
                                                                    context)
                                                                .selectedAccount
                                                                .address
                                                        ? item.from
                                                        : item.to),
                                            radius: 30.0,
                                          ),
                                        ),
                                  Text(
                                    displayName,
                                    textAlign: TextAlign.end,
                                    style:
                                        AppStyles.textStyleTransactionAddress(
                                            context),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  } //Transaction Card End

  // Dummy Transaction Card
  Widget _buildDummyTransactionCard(
      String type, String amount, String address, BuildContext context) {
    String text;
    IconData icon;
    Color iconColor;
    if (type == AppLocalization.of(context).sent) {
      text = AppLocalization.of(context).sent;
      icon = AppIcons.sent;
      iconColor = StateContainer.of(context).curTheme.text60;
    } else {
      text = AppLocalization.of(context).received;
      icon = AppIcons.received;
      iconColor = StateContainer.of(context).curTheme.primary60;
    }
    return Container(
      margin: EdgeInsetsDirectional.fromSTEB(14.0, 4.0, 14.0, 4.0),
      decoration: BoxDecoration(
        color: StateContainer.of(context).curTheme.backgroundDark,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [StateContainer.of(context).curTheme.boxShadow],
      ),
      child: FlatButton(
        onPressed: () {
          return null;
        },
        highlightColor: StateContainer.of(context).curTheme.text15,
        splashColor: StateContainer.of(context).curTheme.text15,
        color: StateContainer.of(context).curTheme.backgroundDark,
        padding: EdgeInsets.all(0.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsetsDirectional.only(end: 16.0),
                      child: Icon(icon, color: iconColor, size: 15),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            text,
                            textAlign: TextAlign.start,
                            style: AppStyles.textStyleTransactionType(context),
                          ),
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              text: '',
                              children: [
                                TextSpan(
                                  text: amount,
                                  style: AppStyles.textStyleTransactionAmount(
                                      context),
                                ),
                                TextSpan(
                                  text: " IDNA",
                                  style: AppStyles.textStyleTransactionUnit(
                                      context),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.4,
                  child: Text(
                    address,
                    textAlign: TextAlign.end,
                    style: AppStyles.textStyleTransactionAddress(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  } //Dummy Transaction Card End

  // Welcome Card
  TextSpan _getExampleHeaderSpan(BuildContext context) {
    String workingStr;
    if (StateContainer.of(context).selectedAccount == null ||
        StateContainer.of(context).selectedAccount.index == 0) {
      workingStr = AppLocalization.of(context).exampleCardIntro;
    } else {
      workingStr = AppLocalization.of(context).newAccountIntro;
    }
    if (!workingStr.contains("IDNA")) {
      return TextSpan(
        text: workingStr,
        style: AppStyles.textStyleTransactionWelcome(context),
      );
    }
    // Colorize cryptocurrency
    List<String> splitStr = workingStr.split("IDNA");
    if (splitStr.length != 2) {
      return TextSpan(
        text: workingStr,
        style: AppStyles.textStyleTransactionWelcome(context),
      );
    }
    return TextSpan(
      text: '',
      children: [
        TextSpan(
          text: splitStr[0],
          style: AppStyles.textStyleTransactionWelcome(context),
        ),
        TextSpan(
          text: "IDNA",
          style: AppStyles.textStyleTransactionWelcomePrimary(context),
        ),
        TextSpan(
          text: splitStr[1],
          style: AppStyles.textStyleTransactionWelcome(context),
        ),
      ],
    );
  }

  Widget _buildWelcomeTransactionCard(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.fromSTEB(14.0, 4.0, 14.0, 4.0),
      decoration: BoxDecoration(
        color: StateContainer.of(context).curTheme.backgroundDark,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [StateContainer.of(context).curTheme.boxShadow],
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 7.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0)),
                color: StateContainer.of(context).curTheme.primary,
                boxShadow: [StateContainer.of(context).curTheme.boxShadow],
              ),
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 14.0, horizontal: 15.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: _getExampleHeaderSpan(context),
                ),
              ),
            ),
            Container(
              width: 7.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
                color: StateContainer.of(context).curTheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  } // Welcome Card End

  // Loading Transaction Card
  Widget _buildLoadingTransactionCard(
      String type, String amount, String address, BuildContext context) {
    String text;
    IconData icon;
    Color iconColor;
    if (type == "Sent") {
      text = "Senttt";
      icon = AppIcons.dotfilled;
      iconColor = StateContainer.of(context).curTheme.text20;
    } else {
      text = "Receiveddd";
      icon = AppIcons.dotfilled;
      iconColor = StateContainer.of(context).curTheme.primary20;
    }
    return Container(
      margin: EdgeInsetsDirectional.fromSTEB(14.0, 4.0, 14.0, 4.0),
      decoration: BoxDecoration(
        color: StateContainer.of(context).curTheme.backgroundDark,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [StateContainer.of(context).curTheme.boxShadow],
      ),
      child: FlatButton(
        onPressed: () {
          return null;
        },
        highlightColor: StateContainer.of(context).curTheme.text15,
        splashColor: StateContainer.of(context).curTheme.text15,
        color: StateContainer.of(context).curTheme.backgroundDark,
        padding: EdgeInsets.all(0.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // Transaction Icon
                    Opacity(
                      opacity: _opacityAnimation.value,
                      child: Container(
                          margin: EdgeInsetsDirectional.only(end: 16.0),
                          child: Icon(icon, color: iconColor, size: 20)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Transaction Type Text
                          Container(
                            child: Stack(
                              alignment: AlignmentDirectional(-1, 0),
                              children: <Widget>[
                                Text(
                                  text,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: AppFontSizes.small,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.transparent,
                                  ),
                                ),
                                Opacity(
                                  opacity: _opacityAnimation.value,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .text45,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Text(
                                      text,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: AppFontSizes.small - 4,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Amount Text
                          Container(
                            child: Stack(
                              alignment: AlignmentDirectional(-1, 0),
                              children: <Widget>[
                                Text(
                                  amount,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      color: Colors.transparent,
                                      fontSize: AppFontSizes.smallest,
                                      fontWeight: FontWeight.w600),
                                ),
                                Opacity(
                                  opacity: _opacityAnimation.value,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .primary20,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Text(
                                      amount,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontFamily: "Roboto",
                                          color: Colors.transparent,
                                          fontSize: AppFontSizes.smallest - 3,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Address Text
                Container(
                  width: MediaQuery.of(context).size.width / 2.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Stack(
                          alignment: AlignmentDirectional(1, 0),
                          children: <Widget>[
                            Text(
                              address,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: AppFontSizes.smallest,
                                fontFamily: 'OverpassMono',
                                fontWeight: FontWeight.w100,
                                color: Colors.transparent,
                              ),
                            ),
                            Opacity(
                              opacity: _opacityAnimation.value,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .text20,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Text(
                                  address,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: AppFontSizes.smallest - 3,
                                    fontFamily: 'OverpassMono',
                                    fontWeight: FontWeight.w100,
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  } // Loading Transaction Card End

  //Main Card
  Widget _buildMainCard(BuildContext context, _scaffoldKey) {
    return Container(
      decoration: BoxDecoration(
        color: StateContainer.of(context).curTheme.backgroundDark,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [StateContainer.of(context).curTheme.boxShadow],
      ),
      margin: EdgeInsets.only(
          left: 14.0,
          right: 14.0,
          top: MediaQuery.of(context).size.height * 0.005),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            width: 80.0,
            height: mainCardHeight,
            alignment: AlignmentDirectional(-1, -1),
            child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                margin: EdgeInsetsDirectional.only(
                    top: settingsIconMarginTop, start: 5),
                height: 100,
                width: 50,
                child: Column(
                  children: [
                    FlatButton(
                        highlightColor:
                            StateContainer.of(context).curTheme.text15,
                        splashColor: StateContainer.of(context).curTheme.text15,
                        onPressed: () {
                          _scaffoldKey.currentState.openDrawer();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Icon(LineariconsFree.menu_circle,
                            color: StateContainer.of(context).curTheme.icon,
                            size: 24)),
                    StateContainer.of(context).selectedAccount.state ==
                            IdentityStatus.Invite
                        ? FlatButton(
                            highlightColor:
                                StateContainer.of(context).curTheme.text15,
                            splashColor:
                                StateContainer.of(context).curTheme.text15,
                            onPressed: () {
                              AppDialogs.showConfirmDialog(
                                  context,
                                  AppLocalization.of(context).invitationHeader,
                                  AppLocalization.of(context)
                                      .invitationActivateHeader,
                                  CaseChange.toUpperCase(
                                      AppLocalization.of(context)
                                          .invitationActivateButton,
                                      context), () async {
                                await sl.get<AppService>().activateInvitation(
                                    "",
                                    StateContainer.of(context)
                                        .selectedAccount
                                        .address);
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Icon(Icons.circle_notifications,
                                color: Colors.red[400], size: 28))
                        : SizedBox(),
                  ],
                )),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: mainCardHeight,
            curve: Curves.easeInOut,
            child: _getBalanceWidget(),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            width: mainCardHeight == 64 ? 60 : 74,
            height: mainCardHeight == 64 ? 60 : 74,
            margin: EdgeInsets.only(right: 2),
            alignment: Alignment(0, 0),
            child: Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    child: Hero(
                      tag: "avatar",
                      child: InkWell(
                        onTap: () {
                          if (StateContainer.of(context)
                                  .selectedAccount
                                  .address !=
                              null) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return UIUtil.showAccountWebview(
                                  context,
                                  StateContainer.of(context)
                                      .selectedAccount
                                      .address);
                            }));
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor:
                              StateContainer.of(context).curTheme.text05,
                          backgroundImage: UIUtil.getRobohashURL(
                              StateContainer.of(context)
                                  .selectedAccount
                                  .address),
                          radius: 50.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  } //Main Card

  // Get balance display
  Widget _getBalanceWidget() {
    if (StateContainer.of(context).wallet == null ||
        StateContainer.of(context).wallet.loading) {
      // Placeholder for balance text
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _priceConversion == PriceConversion.BTC
                ? Container(
                    child: Stack(
                      alignment: AlignmentDirectional(0, 0),
                      children: <Widget>[
                        Text(
                          "1234567",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: AppFontSizes.small,
                              fontWeight: FontWeight.w600,
                              color: Colors.transparent),
                        ),
                        Opacity(
                          opacity: _opacityAnimation.value,
                          child: Container(
                            decoration: BoxDecoration(
                              color: StateContainer.of(context).curTheme.text20,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              "1234567",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: AppFontSizes.small - 3,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.transparent),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 225),
              child: Stack(
                alignment: AlignmentDirectional(0, 0),
                children: <Widget>[
                  AutoSizeText(
                    "1234567",
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: AppFontSizes.largestc,
                        fontWeight: FontWeight.w900,
                        color: Colors.transparent),
                    maxLines: 1,
                    stepGranularity: 0.1,
                    minFontSize: 1,
                  ),
                  Opacity(
                    opacity: _opacityAnimation.value,
                    child: Container(
                      decoration: BoxDecoration(
                        color: StateContainer.of(context).curTheme.primary60,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: AutoSizeText(
                        "1234567",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: AppFontSizes.largestc - 8,
                            fontWeight: FontWeight.w900,
                            color: Colors.transparent),
                        maxLines: 1,
                        stepGranularity: 0.1,
                        minFontSize: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _priceConversion == PriceConversion.BTC
                ? Container(
                    child: Stack(
                      alignment: AlignmentDirectional(0, 0),
                      children: <Widget>[
                        Text(
                          "1234567",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: AppFontSizes.small,
                              fontWeight: FontWeight.w600,
                              color: Colors.transparent),
                        ),
                        Opacity(
                          opacity: _opacityAnimation.value,
                          child: Container(
                            decoration: BoxDecoration(
                              color: StateContainer.of(context).curTheme.text20,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              "1234567",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: AppFontSizes.small - 3,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.transparent),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
      );
    }
    // Balance texts
    return GestureDetector(
      onTap: () {
        if (_priceConversion == PriceConversion.BTC) {
          // Hide prices
          setState(() {
            _priceConversion = PriceConversion.NONE;
            mainCardHeight = 64;
            settingsIconMarginTop = 7;
          });
          sl.get<SharedPrefsUtil>().setPriceConversion(PriceConversion.NONE);
        } else if (_priceConversion == PriceConversion.NONE) {
          // Cycle to hidden
          setState(() {
            _priceConversion = PriceConversion.HIDDEN;
            mainCardHeight = 64;
            settingsIconMarginTop = 7;
          });
          sl.get<SharedPrefsUtil>().setPriceConversion(PriceConversion.HIDDEN);
        } else if (_priceConversion == PriceConversion.HIDDEN) {
          // Cycle to BTC price
          setState(() {
            mainCardHeight = 120;
            settingsIconMarginTop = 5;
          });
          Future.delayed(Duration(milliseconds: 150), () {
            setState(() {
              _priceConversion = PriceConversion.BTC;
            });
          });
          sl.get<SharedPrefsUtil>().setPriceConversion(PriceConversion.BTC);
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width - 190,
        color: Colors.transparent,
        child: _priceConversion == PriceConversion.HIDDEN
            ? Center(
                child: Container(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset("assets/icon.png"),
                  ),
                ),
              )
            : Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _priceConversion == PriceConversion.BTC
                        ? Text(
                            StateContainer.of(context)
                                .wallet
                                .getLocalCurrencyPrice(
                                    StateContainer.of(context).curCurrency,
                                    locale: StateContainer.of(context)
                                        .currencyLocale),
                            textAlign: TextAlign.center,
                            style: AppStyles.textStyleCurrencyAlt(context))
                        : SizedBox(height: 0),
                    Container(
                      margin: EdgeInsetsDirectional.only(end: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width -
                                            205),
                                child: AutoSizeText.rich(
                                  TextSpan(
                                    children: [
                                      // Main balance text
                                      TextSpan(
                                        text: "B: " +
                                            StateContainer.of(context)
                                                .wallet
                                                .getAccountBalanceDisplay() +
                                            " IDNA",
                                        style: _priceConversion ==
                                                PriceConversion.BTC
                                            ? AppStyles.textStyleCurrency(
                                                context)
                                            : AppStyles
                                                .textStyleCurrencySmaller(
                                                    context),
                                      ),
                                    ],
                                  ),
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: _priceConversion ==
                                              PriceConversion.BTC
                                          ? 28
                                          : 22),
                                  stepGranularity: 0.1,
                                  minFontSize: 1,
                                  maxFontSize:
                                      _priceConversion == PriceConversion.BTC
                                          ? 28
                                          : 22,
                                ),
                              ),
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width -
                                            205),
                                child: AutoSizeText.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "S: " +
                                            StateContainer.of(context)
                                                .wallet
                                                .getAccountStakeDisplay() +
                                            " IDNA",
                                        style: _priceConversion ==
                                                PriceConversion.BTC
                                            ? AppStyles
                                                .textStyleCurrencyStakeSmaller(
                                                    context)
                                            : AppStyles
                                                .textStyleCurrencyStakeSmaller(
                                                    context),
                                      ),
                                    ],
                                  ),
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: _priceConversion ==
                                              PriceConversion.BTC
                                          ? 28
                                          : 22),
                                  stepGranularity: 0.1,
                                  minFontSize: 1,
                                  maxFontSize:
                                      _priceConversion == PriceConversion.BTC
                                          ? 28
                                          : 22,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    _priceConversion == PriceConversion.BTC
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                  _priceConversion == PriceConversion.BTC
                                      ? AppIcons.btc
                                      // TODO : pas bon
                                      : AppIcons.accountwallet,
                                  color:
                                      _priceConversion == PriceConversion.NONE
                                          ? Colors.transparent
                                          : StateContainer.of(context)
                                              .curTheme
                                              .text60,
                                  size: 14),
                              Text(StateContainer.of(context).wallet.btcPrice,
                                  textAlign: TextAlign.center,
                                  style:
                                      AppStyles.textStyleCurrencyAlt(context)),
                            ],
                          )
                        : SizedBox(height: 0),
                  ],
                ),
              ),
      ),
    );
  }
}

class TransactionDetailsSheet extends StatefulWidget {
  final String displayName;
  final Transaction item;

  TransactionDetailsSheet({this.item, this.displayName}) : super();

  _TransactionDetailsSheetState createState() =>
      _TransactionDetailsSheetState();
}

class _TransactionDetailsSheetState extends State<TransactionDetailsSheet> {
  // Current state references
  bool _addressCopied = false;
  // Timer reference so we can cancel repeated events
  Timer _addressCopiedTimer;

  @override
  Widget build(BuildContext context) {
    String typeLabel = BlockTypes().getTransactionTypeLabel(
        widget.item.type, widget.item.payload, context);
    return SafeArea(
      minimum: EdgeInsets.only(
        left: 30,
        right: 30,
        top: 50,
        bottom: MediaQuery.of(context).size.height * 0.035,
      ),
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(
                children: [
                  SizedBox(height: 20),
                  Text(typeLabel == "" ? widget.item.type : typeLabel,
                      style: AppStyles.textStyleTransactionType(context),
                      textAlign: TextAlign.center),
                  SizedBox(height: 10),
                  Text(AppLocalization.of(context).transactionDetailBlock,
                      style: AppStyles.textStyleTransactionWelcome(context)),
                  SelectableText(
                      widget.item.blockHash == null
                          ? ""
                          : widget.item.blockHash,
                      style: AppStyles.textStyleParagraphThinPrimary(context),
                      textAlign: TextAlign.center),
                  SizedBox(height: 10),
                  Text(AppLocalization.of(context).transactionDetailDate,
                      style: AppStyles.textStyleTransactionWelcome(context)),
                  Text(
                      DateFormat.yMEd(
                              Localizations.localeOf(context).languageCode)
                          .add_Hm()
                          .format(DateTime.fromMillisecondsSinceEpoch(
                                  widget.item.timestamp * 1000)
                              .toLocal())
                          .toString(),
                      style: AppStyles.textStyleParagraphThinPrimary(context)),
                  SizedBox(height: 10),
                  Text(AppLocalization.of(context).transactionDetailFrom,
                      style: AppStyles.textStyleTransactionWelcome(context)),
                  SelectableText(widget.item.from,
                      style: AppStyles.textStyleParagraphThinPrimary(context)),
                  SizedBox(height: 10),
                  Text(AppLocalization.of(context).transactionDetailTo,
                      style: AppStyles.textStyleTransactionWelcome(context)),
                  SelectableText(widget.item.to == null ? "" : widget.item.to,
                      style: AppStyles.textStyleParagraphThinPrimary(context)),
                  SizedBox(height: 10),
                  Text(AppLocalization.of(context).transactionDetailTxId,
                      style: AppStyles.textStyleTransactionWelcome(context)),
                  SelectableText(widget.item.hash,
                      style: AppStyles.textStyleParagraphThinPrimary(context),
                      textAlign: TextAlign.center),
                  SizedBox(height: 10),
                  Text(AppLocalization.of(context).transactionDetailAmount,
                      style: AppStyles.textStyleTransactionWelcome(context)),
                  Text(
                      widget.item.from !=
                              StateContainer.of(context).selectedAccount.address
                          ? "+ " + widget.item.getFormattedAmount() + " IDNA"
                          : "- " + widget.item.getFormattedAmount() + " IDNA",
                      style: AppStyles.textStyleParagraphThinPrimary(context)),
                  SizedBox(height: 10),
                  Text(AppLocalization.of(context).transactionDetailFee,
                      style: AppStyles.textStyleTransactionWelcome(context)),
                  Text("- " + widget.item.usedFee.toString() + " IDNA",
                      style: AppStyles.textStyleParagraphThinPrimary(context)),
                  SizedBox(height: 10),
                  Text(AppLocalization.of(context).transactionDetailReward,
                      style: AppStyles.textStyleTransactionWelcome(context)),
                  Text(widget.item.tips.toString() + " IDNA",
                      style: AppStyles.textStyleParagraphThinPrimary(context)),
                  SizedBox(height: 10),
                  Text(AppLocalization.of(context).transactionDetailPayload,
                      style: AppStyles.textStyleTransactionWelcome(context)),
                  SelectableText(AppHelpers.fromHexString(widget.item.payload),
                      style: AppStyles.textStyleParagraphThinPrimary(context)),
                  SizedBox(height: 20),
                  Text(
                      "* " +
                          AppLocalization.of(context)
                              .transactionDetailCopyPaste,
                      style: AppStyles.textStyleParagraphThinPrimary(context),
                      textAlign: TextAlign.left),
                ],
              ),
              Column(
                children: <Widget>[
                  // A stack for Copy Address and Add Contact buttons
                  Stack(
                    children: <Widget>[
                      // A row for Copy Address Button
                      Row(
                        children: <Widget>[
                          AppButton.buildAppButton(
                              context,
                              // Share Address Button
                              _addressCopied
                                  ? AppButtonType.SUCCESS
                                  : AppButtonType.PRIMARY,
                              _addressCopied
                                  ? AppLocalization.of(context).addressCopied
                                  : AppLocalization.of(context).copyAddress,
                              Dimens.BUTTON_TOP_EXCEPTION_DIMENS,
                              onPressed: () {
                            Clipboard.setData(
                                new ClipboardData(text: widget.item.to));
                            if (mounted) {
                              setState(() {
                                // Set copied style
                                _addressCopied = true;
                              });
                            }
                            if (_addressCopiedTimer != null) {
                              _addressCopiedTimer.cancel();
                            }
                            _addressCopiedTimer = new Timer(
                                const Duration(milliseconds: 800), () {
                              if (mounted) {
                                setState(() {
                                  _addressCopied = false;
                                });
                              }
                            });
                          }),
                        ],
                      ),
                      // A row for Add Contact Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                top: Dimens.BUTTON_TOP_EXCEPTION_DIMENS[1],
                                end: Dimens.BUTTON_TOP_EXCEPTION_DIMENS[2]),
                            child: Container(
                              height: 55,
                              width: 55,
                              // Add Contact Button
                              child: !widget.displayName.startsWith("@")
                                  ? FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Sheets.showAppHeightNineSheet(
                                            context: context,
                                            widget: AddContactSheet(
                                                address: widget.item.to));
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100.0)),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 10),
                                      child: Icon(AppIcons.addcontact,
                                          size: 35,
                                          color: _addressCopied
                                              ? StateContainer.of(context)
                                                  .curTheme
                                                  .successDark
                                              : StateContainer.of(context)
                                                  .curTheme
                                                  .backgroundDark),
                                    )
                                  : SizedBox(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// This is used so that the elevation of the container is kept and the
/// drop shadow is not clipped.
///
class _SizeTransitionNoClip extends AnimatedWidget {
  final Widget child;

  const _SizeTransitionNoClip(
      {@required Animation<double> sizeFactor, this.child})
      : super(listenable: sizeFactor);

  @override
  Widget build(BuildContext context) {
    return new Align(
      alignment: const AlignmentDirectional(-1.0, -1.0),
      widthFactor: null,
      heightFactor: (this.listenable as Animation<double>).value,
      child: child,
    );
  }
}
