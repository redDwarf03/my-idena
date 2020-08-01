import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:my_idena/beans/rpc/dna_all.dart';
import 'package:my_idena/beans/rpc/httpService.dart';
import 'package:flutter/material.dart';
import 'package:my_idena/beans/rpc/dna_becomOnline_response.dart';
import 'package:my_idena/beans/rpc/dna_becomeOffline_request.dart';
import 'package:my_idena/beans/rpc/dna_becomeOffline_response.dart';
import 'package:my_idena/beans/rpc/dna_becomeOnline_request.dart';
import 'package:my_idena/beans/rpc/dna_getBalance_request.dart';
import 'package:my_idena/beans/rpc/dna_getBalance_response.dart';
import 'package:my_idena/beans/rpc/dna_getCoinbaseAddr_request.dart';
import 'package:my_idena/beans/rpc/dna_getCoinbaseAddr_response.dart';
import 'package:my_idena/constants/containerMyIdena.dart';
import 'package:my_idena/constants/bottomNavigationBarMyIdena.dart';
import 'package:my_idena/beans/rpc/dna_identity_request.dart';
import 'package:my_idena/beans/rpc/dna_identity_response.dart';
import 'package:my_idena/pages/validation_session..dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

DnaAll dnaAll;
DnaGetCoinbaseAddrRequest dnaGetCoinbaseAddrRequest;
DnaGetCoinbaseAddrResponse dnaGetCoinbaseAddrResponse;
DnaIdentityRequest dnaIdentityRequest;
DnaIdentityResponse dnaIdentityResponse;
DnaGetBalanceRequest dnaGetBalanceRequest;
DnaGetBalanceResponse dnaGetBalanceResponse;
DnaBecomeOnlineRequest dnaBecomeOnlineRequest;
DnaBecomeOnlineResponse dnaBecomeOnlineResponse;
DnaBecomeOfflineRequest dnaBecomeOfflineRequest;
DnaBecomeOfflineResponse dnaBecomeOfflineResponse;

HttpClient httpClient = new HttpClient();

class _HomeState extends State<Home> {
  final HttpService httpService = HttpService();

  @override
  void initState() {
    super.initState();

    _startTimerValidationSession();
  }

  int _counter = 0;
  Timer _timer;

  void _startTimerValidationSession() {
    _counter = 0;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();

              /*Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new ValidationSession(dnaAll: dnaAll),
                ),);*/
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      bottomNavigationBar: BottomNavigationBarMyIdena(indexInit: 0),
      body: FutureBuilder(
          future: httpService.getDnaAll(),
          builder: (BuildContext context, AsyncSnapshot<DnaAll> snapshot) {
            if (snapshot.hasData) {
              dnaAll = snapshot.data;
              if (dnaAll == null || dnaAll.dnaIdentityResponse == null) {
                return SafeArea(
                  child: Stack(
                    children: <Widget>[
                      ContainerMyIdena(),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context)
                                  .translate("my Idena"),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        // TODO: Do something better...
                        child: Text("Go to param!!"),
                        top: 20,
                        right: 0,
                        left: 0,
                      ),
                    ],
                  ),
                );
              } else {
                return SafeArea(
                  child: Stack(
                    children: <Widget>[
                      ContainerMyIdena(),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context)
                                  .translate("my Idena"),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        child: HomePageContent(),
                        top: 20,
                        right: 0,
                        left: 0,
                      ),
                      Positioned(
                        top: 110,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ListView(
                          children: <Widget>[
                            InfoCard(
                              icon: "icon",
                              type: AppLocalizations.of(context)
                                  .translate("Main"),
                              value: double.parse(
                                  dnaAll.dnaGetBalanceResponse.result.balance),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 220,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ListView(
                          children: <Widget>[
                            InfoCard(
                              icon: "icon",
                              type: AppLocalizations.of(context)
                                  .translate("Stake"),
                              value: double.parse(
                                  dnaAll.dnaGetBalanceResponse.result.stake),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 330,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ListView(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 9.0, horizontal: 21.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              padding: EdgeInsets.all(1),
                              child: Container(
                                width: double.infinity,
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 1,
                                          ),
                                          Text(
                                            AppLocalizations.of(context)
                                                    .translate("State :") + " " +
                                                dnaAll.dnaIdentityResponse
                                                    .result.state,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'OpenSans',
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            AppLocalizations.of(context)
                                                    .translate("Age :") + " " +
                                                dnaAll.dnaIdentityResponse
                                                    .result.age
                                                    .toString() +
                                                " - " +
                                                AppLocalizations.of(context)
                                                    .translate("Epoch") +
                                                " (" +
                                                (dnaAll.dnaGetEpochResponse
                                                            .result.epoch -
                                                        dnaAll
                                                            .dnaIdentityResponse
                                                            .result
                                                            .age)
                                                    .toString() +
                                                " - " +
                                                dnaAll.dnaGetEpochResponse
                                                    .result.epoch
                                                    .toString() +
                                                ")",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'OpenSans',
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            dnaAll.dnaIdentityResponse.result
                                                .address,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'OpenSans',
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 394,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ListView(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 9.0, horizontal: 21.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              padding: EdgeInsets.all(1),
                              child: Container(
                                width: double.infinity,
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 1,
                                          ),
                                          SwitchListTile(
                                            title: Text(
                                              AppLocalizations.of(context)
                                                  .translate("Mining"),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'OpenSans',
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            value: dnaAll.dnaIdentityResponse
                                                .result.online,
                                            onChanged: (value) {
                                              setState(() {
                                                if (dnaAll.dnaIdentityResponse
                                                    .result.online) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          _boiteDeDialogueStopMining(
                                                              context));
                                                } else {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          _boiteDeDialogueStartMining(
                                                              context));
                                                }
                                              });
                                            },
                                            activeTrackColor: Colors.green[100],
                                            activeColor: Colors.green[300],
                                            secondary:
                                                const Icon(Icons.blur_on),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 460,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ListView(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 9.0, horizontal: 21.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              padding: EdgeInsets.all(1),
                              child: Container(
                                padding: EdgeInsets.all(17),
                                width: double.infinity,
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate("Next validation"),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'OpenSans',
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            new DateFormat.yMd()
                                                .add_jm()
                                                .format(dnaAll
                                                    .dnaGetEpochResponse
                                                    .result
                                                    .nextValidation),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'OpenSans',
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 540,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ListView(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 9.0, horizontal: 21.0),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              padding: EdgeInsets.all(15),
                              child: Container(
                                width: double.infinity,
                                child: Row(
                                  children: <Widget>[
                                    (_counter > 0)
                                        ? Text(AppLocalizations.of(context)
                                                .translate("Idena validation will start soon :") + " $_counter",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'OpenSans',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                            ),
                                          )
                                        : Text("")
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget _boiteDeDialogueStopMining(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                  AppLocalizations.of(context)
                      .translate("Deactivate mining status"),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                    fontSize: 20.0,
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                  AppLocalizations.of(context).translate(
                      "Submit the form to deactivate your mining status."),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                    fontSize: 15.0,
                  )),
              SizedBox(height: 20.0),
              Text(
                  AppLocalizations.of(context)
                      .translate("You can activate it again afterwards."),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                    fontSize: 15.0,
                  )),
              SizedBox(height: 10.0),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                      child: Text(
                        AppLocalizations.of(context).translate("Submit"),
                      ),
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () {
                        httpService.becomeOffline();
                        setState(() {
                          Navigator.pop(context);
                        });
                      }),
                  FlatButton(
                      child: Text(
                        AppLocalizations.of(context).translate("Cancel"),
                      ),
                      color: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () async {
                        await httpService.becomeOffline();
                        Navigator.of(context).pop();
                      })
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _boiteDeDialogueStartMining(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                  AppLocalizations.of(context)
                      .translate("Activate mining status"),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                    fontSize: 20.0,
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                  AppLocalizations.of(context).translate(
                      "Submit the form to start mining. Your node has to be online\n                unless you deactivate your status. Otherwise penalties might be\n                charged after being offline more than 1 hour."),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                    fontSize: 15.0,
                  )),
              SizedBox(height: 20.0),
              Text(
                  AppLocalizations.of(context).translate(
                      "You can deactivate your online status at any time."),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                    fontSize: 15.0,
                  )),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                      child: Text(
                        AppLocalizations.of(context).translate("Submit"),
                      ),
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () async {
                        await httpService.becomeOnline();
                        Navigator.of(context).pop();
                      }),
                  FlatButton(
                      child: Text(
                        AppLocalizations.of(context).translate("Cancel"),
                      ),
                      color: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      })
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class HomePageContent extends StatelessWidget {
  HomePageContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 269,
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 21.0),
      child: Column(
        children: <Widget>[
          Divider(color: Colors.grey),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(AppLocalizations.of(context).translate("Total Balance"),
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    (double.parse(dnaAll.dnaGetBalanceResponse.result.balance) +
                                double.parse(
                                    dnaAll.dnaGetBalanceResponse.result.stake))
                            .toString() +
                        " DNA",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 25.0,
                    ),
                  ),
                ],
              ),
              Image.network(
                'https://robohash.org/0x72563cb949bd0167acfff47b5865fe30e1960e70',
                width: 50,
                height: 50,
              ),
            ],
          ),
          Divider(color: Colors.grey),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String icon, type;
  final double value;

  InfoCard({Key key, this.icon, this.type, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 9.0, horizontal: 21.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      padding: EdgeInsets.all(17),
      child: Container(
        width: double.infinity,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    type,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'OpenSans',
                      fontSize: 15.0,
                    ),
                    softWrap: false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    AppLocalizations.of(context).translate("Balance :"),
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'OpenSans',
                      fontSize: 15.0,
                    ),
                  ),
                  Text(
                    value.toString() + " DNA",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'OpenSans',
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
