// @dart=2.9
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/ui/util/ui_util.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AppShareCard extends StatefulWidget {
  final GlobalKey key;
  final Widget qrSVG;
  final Widget logoSvg;

  AppShareCard(this.key, this.qrSVG, this.logoSvg);

  @override
  _AppShareCardState createState() => _AppShareCardState(key, qrSVG, logoSvg);
}

class _AppShareCardState extends State<AppShareCard> {
  GlobalKey globalKey;
  Widget qrSVG;
  Widget logoSvg;

  _AppShareCardState(this.globalKey, this.qrSVG, this.logoSvg);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: globalKey,
      child: Container(
        height: 125,
        width: 235,
        decoration: BoxDecoration(
          color: StateContainer.of(context).curTheme.backgroundDark,
          borderRadius: BorderRadius.circular(12.5),
        ),
        child: Container(
          margin: EdgeInsets.only(left: 12.5, right: 12.5, top: 12.5),
          constraints: BoxConstraints.expand(),
          // The main row that holds QR, logo, the address, ticker and the website text
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // A container for QR
              Container(
                margin: EdgeInsets.only(bottom: 12.5),
                width: 100,
                height: 100.0,
                child: Stack(
                  children: <Widget>[
                    // Background QR
                    Center(
                      child: Container(
                        width: 91.954,
                        height: 91.954,
                        child: qrSVG,
                      ),
                    ),
                    // Actual QR part of the QR
                    Center(
                      child: Container(
                        height: 60,
                        width: 60,
                        child: QrImage(
                          padding: EdgeInsets.all(0.0),
                          data: StateContainer.of(context).wallet.address,
                          version: 6,
                          gapless: false,
                          errorCorrectionLevel: QrErrorCorrectLevel.Q,
                        ),
                      ),
                    ),
                    // Outer Ring
                    Center(
                      child: Container(
                        width: 95,
                        height: 95,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color:
                                  StateContainer.of(context).curTheme.primary,
                              width: 1.3913),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 26.5,
                        height: 26.5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            width: 1.44545,
                            color: StateContainer.of(context)
                                .curTheme
                                .backgroundDark,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1.06,
                              color:
                                  StateContainer.of(context).curTheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(),
                    Center(
                      child: Container(
                        width: 25.44,
                        height: 25.44,
                        margin: EdgeInsetsDirectional.only(top: 1.44545),
                        child: CircleAvatar(
                          backgroundColor: StateContainer.of(context).curTheme.text05,
                          backgroundImage: UIUtil.getRobohashURL(StateContainer.of(context)
                                .selectedAccount
                                .address),
                          radius: 50.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // A column for logo, address, ticker and website text
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Logo
                  Container(
                    width: 96,
                    height: 20,
                    margin: EdgeInsetsDirectional.only(start: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Currency Icon
                        Container(
                          width: 29,
                          child: AutoSizeText(
                            "  ",
                            style: TextStyle(
                              color:
                                  StateContainer.of(context).curTheme.primary,
                              fontFamily: "AppIcons",
                              fontWeight: FontWeight.w500,
                            ),
                            minFontSize: 0.1,
                            stepGranularity: 0.1,
                            maxLines: 1,
                          ),
                        ),
                        Container(
                          width: 60,
                          margin: EdgeInsets.only(top: 1),
                          child: AutoSizeText(
                            "IDNA",
                            style: TextStyle(
                              color:
                                  StateContainer.of(context).curTheme.primary,
                              fontFamily: "Comfortaa",
                              fontWeight: FontWeight.w300,
                              fontSize: 40,
                              letterSpacing: 1.5,
                            ),
                            minFontSize: 0.1,
                            stepGranularity: 0.1,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Address
                  Container(
                    padding: EdgeInsets.only(bottom: 7),
                    child: Column(
                      children: <Widget>[
                        // First row of the address
                        Container(
                          width: 97,
                          child: AutoSizeText.rich(
                            TextSpan(
                              children: [
                                // Primary part of the first row
                                TextSpan(
                                  text: StateContainer.of(context)
                                      .wallet
                                      .address
                                      .substring(0, 12),
                                  style: TextStyle(
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .primary,
                                    fontFamily: "OverpassMono",
                                    fontWeight: FontWeight.w100,
                                    fontSize: 50.0,
                                    height: 1.2,
                                  ),
                                ),
                                TextSpan(
                                  text: StateContainer.of(context)
                                      .wallet
                                      .address
                                      .substring(12, 16),
                                  style: TextStyle(
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .text,
                                    fontFamily: "OverpassMono",
                                    fontWeight: FontWeight.w100,
                                    fontSize: 50.0,
                                    height: 1.2,
                                  ),
                                ),
                              ],
                            ),
                            maxLines: 1,
                            stepGranularity: 0.1,
                            minFontSize: 1,
                            style: TextStyle(
                              fontSize: 50.0,
                              fontFamily: "OverpassMono",
                              fontWeight: FontWeight.w100,
                              height: 1.2,
                            ),
                          ),
                        ),
                        // Second row of the address
                        Container(
                          width: 97,
                          child: AutoSizeText(
                            StateContainer.of(context)
                                .wallet
                                .address
                                .substring(16, 32),
                            minFontSize: 1.0,
                            stepGranularity: 0.1,
                            maxFontSize: 50,
                            maxLines: 1,
                            style: TextStyle(
                              color: StateContainer.of(context).curTheme.text,
                              fontFamily: "OverpassMono",
                              fontWeight: FontWeight.w100,
                              fontSize: 50,
                              height: 1.2,
                            ),
                          ),
                        ),
                        // Third row of the address
                        Container(
                          width: 97,
                          child: AutoSizeText(
                            StateContainer.of(context)
                                .wallet
                                .address
                                .substring(32, 48),
                            minFontSize: 1.0,
                            stepGranularity: 0.1,
                            maxFontSize: 50,
                            maxLines: 1,
                            style: TextStyle(
                              color: StateContainer.of(context).curTheme.text,
                              fontFamily: "OverpassMono",
                              fontWeight: FontWeight.w100,
                              fontSize: 50,
                              height: 1.2,
                            ),
                          ),
                        ),
                        // Fourth(last) row of the address
                        Container(
                          width: 97,
                          child: AutoSizeText.rich(
                            TextSpan(
                              children: [
                                // Text colored part of the last row
                                TextSpan(
                                  text: StateContainer.of(context)
                                      .wallet
                                      .address
                                      .substring(48, 59),
                                  style: TextStyle(
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .text,
                                    fontFamily: "OverpassMono",
                                    fontWeight: FontWeight.w100,
                                    fontSize: 50.0,
                                    height: 1.2,
                                  ),
                                ),
                                // Primary colored part of the last row
                                TextSpan(
                                  text: StateContainer.of(context)
                                      .wallet
                                      .address
                                      .substring(59),
                                  style: TextStyle(
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .primary,
                                    fontFamily: "OverpassMono",
                                    fontWeight: FontWeight.w100,
                                    fontSize: 50.0,
                                    height: 1.2,
                                  ),
                                ),
                              ],
                            ),
                            maxLines: 1,
                            stepGranularity: 0.1,
                            minFontSize: 1,
                            style: TextStyle(
                              fontSize: 50,
                              fontFamily: "OverpassMono",
                              fontWeight: FontWeight.w100,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Ticker & Website
                  Container(
                    width: 97,
                    margin: EdgeInsets.only(bottom: 12.5),
                    child: AutoSizeText(
                      "\$IDENA      IDENA.IO",
                      minFontSize: 0.1,
                      stepGranularity: 0.1,
                      maxLines: 1,
                      style: TextStyle(
                        color: StateContainer.of(context).curTheme.primary,
                        fontFamily: "Comfortaa",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
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
