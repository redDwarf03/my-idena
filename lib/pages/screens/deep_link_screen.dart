import 'package:flutter/material.dart';
import 'package:my_idena/beans/deepLinkParam.dart';
import 'package:my_idena/main.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/myIdena_home.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/utils/util_deepLinks.dart';
import 'package:url_launcher/url_launcher.dart';

class DeepLinkScreen extends StatefulWidget {
  final DeepLinkParam deepLinkParam;

  const DeepLinkScreen({
    Key key,
    this.deepLinkParam,
  }) : super(key: key);

  @override
  _DeepLinkScreenState createState() => _DeepLinkScreenState();
}

class _DeepLinkScreenState extends State<DeepLinkScreen> {
  DeepLinkParam deepLinkParam;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    deepLinkParam = widget.deepLinkParam;
  }

  @override
  Widget build(BuildContext context) {
    if (deepLinkParam != null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/images/img_idena_intro.png'),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context)
                                  .translate("Login confirmation"),
                              style: TextStyle(
                                  fontFamily: MyIdenaAppTheme.fontName,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  letterSpacing: -0.1,
                                  color: MyIdenaAppTheme.white),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  AppLocalizations.of(context).translate(
                                      "Please confirm that you want to use your public address for the website login"),
                                  style: TextStyle(
                                      fontFamily: MyIdenaAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      letterSpacing: -0.1,
                                      color: MyIdenaAppTheme.white),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Website: ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: MyIdenaAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: -0.2,
                                    color: MyIdenaAppTheme.white,
                                  ),
                                ),
                                Text(
                                  deepLinkParam.nonceEndpoint != null
                                      ? UtilDeepLinks().getHostname(
                                          deepLinkParam.nonceEndpoint)
                                      : "",
                                  style: TextStyle(
                                      fontFamily: MyIdenaAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      letterSpacing: -0.1,
                                      color: MyIdenaAppTheme.white),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Address: ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: MyIdenaAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: -0.2,
                                    color: MyIdenaAppTheme.white,
                                  ),
                                ),
                                Text(
                                  idenaAddress,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: MyIdenaAppTheme.fontName,
                                    fontSize: 13,
                                    letterSpacing: -0.2,
                                    color: MyIdenaAppTheme.white,
                                  ),
                                ),
                                Image.network(
                                  'https://robohash.org/' + idenaAddress,
                                  width: 50,
                                  height: 50,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Token: ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: MyIdenaAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: -0.2,
                                    color: MyIdenaAppTheme.white,
                                  ),
                                ),
                                Text(
                                  deepLinkParam.token != null
                                      ? deepLinkParam.token
                                      : "",
                                  style: TextStyle(
                                      fontFamily: MyIdenaAppTheme.fontName,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      letterSpacing: -0.1,
                                      color: MyIdenaAppTheme.white),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FlatButton(
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate("Submit"),
                                        ),
                                        color: Colors.grey[200],
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        onPressed: () {
                                          deepLinkParam.address = idenaAddress;
                                          setState(() {
                                            deepLinkParam = null;
                                            _launchDeepLink(
                                                widget.deepLinkParam);
                                          });
                                        }),
                                    FlatButton(
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate("Cancel"),
                                        ),
                                        color: Colors.grey[200],
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        onPressed: () {
                                          setState(() {
                                            deepLinkParam = null;
                                          });
                                        })
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Home();
    }
  }

  _launchDeepLink(deepLinkParam) async {
    deepLinkParam = await UtilDeepLinks().getNonce(deepLinkParam);
    deepLinkParam = await httpService.signin(deepLinkParam);
    deepLinkParam = await UtilDeepLinks().authenticate(deepLinkParam);
    try {
      launch(deepLinkParam.callbackUrl);
    } catch (e) {}
    /*if (await canLaunch(deepLinkParam.callbackUrl)) {
      await launch(deepLinkParam.callbackUrl);
    } else {
      logger.e('Could not launch ' + deepLinkParam.callbackUrl);
    }*/
  }
}
