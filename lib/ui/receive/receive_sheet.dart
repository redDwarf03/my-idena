import 'dart:async';
import 'dart:typed_data';
import 'package:my_idena/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/ui/util/ui_util.dart';
import 'package:my_idena/ui/receive/share_card.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReceiveSheet extends StatefulWidget {
  final Widget qrWidget;

  ReceiveSheet({this.qrWidget}) : super();

  _ReceiveSheetStateState createState() => _ReceiveSheetStateState();
}

class _ReceiveSheetStateState extends State<ReceiveSheet> {
  GlobalKey shareCardKey;
  ByteData shareImageData;

  // Address copied items
  // Current state references
  bool _showShareCard;
  bool _addressCopied;
  // Timer reference so we can cancel repeated events
  Timer _addressCopiedTimer;

  @override
  void initState() {
    super.initState();
    // Set initial state of copy button
    _addressCopied = false;
    // Create our SVG-heavy things in the constructor because they are slower operations
    // Share card initialization
    shareCardKey = GlobalKey();
    _showShareCard = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            // A row for the address text and close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Empty SizedBox
                SizedBox(
                  width: 60,
                  height: 60,
                ),
                //Container for the address text and sheet handle
                Column(
                  children: <Widget>[
                    // Sheet handle
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.15,
                      decoration: BoxDecoration(
                        color: StateContainer.of(context).curTheme.text10,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: UIUtil.threeLineAddressText(
                          context, StateContainer.of(context).wallet.address,
                          type: ThreeLineAddressTextType.PRIMARY60),
                    ),
                  ],
                ),
                //Empty SizedBox
                SizedBox(
                  width: 60,
                  height: 60,
                ),
              ],
            ),

            // QR which takes all the available space left from the buttons & address text
            Expanded(
              child: Center(
                child: Stack(
                  children: <Widget>[
                    _showShareCard
                        ? Container(
                            child: AppShareCard(
                                shareCardKey,
                                SvgPicture.asset('assets/QR.svg'),
                                SvgPicture.asset('assets/sharecard_logo.svg')),
                            alignment: AlignmentDirectional(0.0, 0.0),
                          )
                        : SizedBox(),
                    // This is for hiding the share card
                    Center(
                      child: Container(
                        width: 260,
                        height: 150,
                        color:
                            StateContainer.of(context).curTheme.backgroundDark,
                      ),
                    ),
                    // Background/border part the QR
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.74,
                        child: SvgPicture.asset('assets/QR.svg'),
                      ),
                    ),
                    // Actual QR part of the QR
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.width / 2.65,
                        width: MediaQuery.of(context).size.width / 2.65,
                        child: widget.qrWidget,
                      ),
                    ),
                    // Outer ring
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.68,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color:
                                  StateContainer.of(context).curTheme.primary,
                              width: MediaQuery.of(context).size.width / 110),
                        ),
                      ),
                    ),
                    // Logo Background White
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 6,
                        height: MediaQuery.of(context).size.width / 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            width: (MediaQuery.of(context).size.width / 110),
                            color: StateContainer.of(context)
                                .curTheme
                                .backgroundDark,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: MediaQuery.of(context).size.width / 150,
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
                        width: MediaQuery.of(context).size.width / 6.25,
                        height: MediaQuery.of(context).size.width / 6.25,
                        margin: EdgeInsetsDirectional.only(
                            top: MediaQuery.of(context).size.width / 110),
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
            ),

            //A column with Copy Address and Share Address buttons
            Column(
              children: <Widget>[
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
                        Dimens.BUTTON_TOP_DIMENS, onPressed: () {
                      Clipboard.setData(new ClipboardData(
                          text: StateContainer.of(context).wallet.address));
                      setState(() {
                        // Set copied style
                        _addressCopied = true;
                      });
                      if (_addressCopiedTimer != null) {
                        _addressCopiedTimer.cancel();
                      }
                      _addressCopiedTimer =
                          new Timer(const Duration(milliseconds: 800), () {
                        setState(() {
                          _addressCopied = false;
                        });
                      });
                    }),
                  ],
                ),
            
              ],
            ),
          ],
        ));
  }
}
