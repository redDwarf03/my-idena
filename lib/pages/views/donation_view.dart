import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/widgets/line_widget.dart';
import 'package:my_idena/pages/widgets/text_above_line_widget.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/utils/util_hexcolor.dart';

class DonationView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const DonationView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _DonationViewState createState() => _DonationViewState();
}

class _DonationViewState extends State<DonationView> {
  final _keyFormDonation = GlobalKey<FormState>();
  final number = TextEditingController();
  String amount = '';
  HttpService httpService = HttpService();
  var logger = Logger();
  DnaAll dnaAll;

  @override
  void initState() {
    super.initState();

    number.value = new TextEditingValue(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: httpService.getDnaAll(),
        builder: (BuildContext context, AsyncSnapshot<DnaAll> snapshot) {
          if (snapshot.hasData) {
            dnaAll = snapshot.data;
            if (dnaAll == null || dnaAll.dnaIdentityResponse == null) {
              return Text("");
            } else {
              return AnimatedBuilder(
                  animation: widget.animationController,
                  builder: (BuildContext context, Widget child) {
                    return FadeTransition(
                      opacity: widget.animation,
                      child: Form(
                        key: _keyFormDonation,
                        child: new Transform(
                          transform: new Matrix4.translationValues(
                              0.0, 30 * (1.0 - widget.animation.value), 0.0),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, top: 16, bottom: 18),
                            child: Container(
                              decoration: BoxDecoration(
                                color: MyIdenaAppTheme.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    bottomLeft: Radius.circular(8.0),
                                    bottomRight: Radius.circular(68.0),
                                    topRight: Radius.circular(8.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color:
                                          MyIdenaAppTheme.grey.withOpacity(0.2),
                                      offset: Offset(1.1, 1.1),
                                      blurRadius: 10.0),
                                ],
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 24,
                                        right: 24,
                                        top: 8,
                                        bottom: 16),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              textAboveLineWidget(AppLocalizations
                                                      .of(context)
                                                  .translate(
                                                      "You can help with a donation :)"), 14),
                                              lineWidget(70),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6),
                                                child: TextFormField(
                                                  controller: number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  validator: (val) => val
                                                          .isEmpty
                                                      ? AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              "Enter your amount")
                                                      : null,
                                                  onChanged: (val) =>
                                                      amount = val,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: MyIdenaAppTheme
                                                        .fontName,
                                                  ),
                                                  decoration: InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Colors.grey[400],
                                                          width: 1.0),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFF2F3F8),
                                                          width: 1.0),
                                                    ),
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 14.0),
                                                    prefixIcon: Icon(
                                                      Icons.monetization_on,
                                                      color: Colors.black54,
                                                    ),
                                                    hintText: AppLocalizations
                                                                .of(context)
                                                            .translate(
                                                                "Enter your amount") +
                                                        " (iDNA)",
                                                    suffix: Text(
                                                      "iDNA    ",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            MyIdenaAppTheme
                                                                .fontName,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 10,
                                                        letterSpacing: -0.2,
                                                        color: MyIdenaAppTheme
                                                            .grey
                                                            .withOpacity(0.5),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6),
                                                child: RaisedButton(
                                                  elevation: 5.0,
                                                  onPressed: () {
                                                    if (_keyFormDonation
                                                        .currentState
                                                        .validate()) {
                                                      try {
                                                        httpService.sendTransaction(
                                                            dnaAll
                                                                .dnaIdentityResponse
                                                                .result
                                                                .address,
                                                            double.tryParse(
                                                                    amount) ??
                                                                0);
                                                      } catch (e) {
                                                        logger.e(e.toString());
                                                      }
                                                      showDialog(
                                                          context: context,
                                                          builder:
                                                              (context) =>
                                                                  SimpleDialog(
                                                                    contentPadding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    children: <
                                                                        Widget>[
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        child:
                                                                            Column(
                                                                          children: <
                                                                              Widget>[
                                                                            Text(
                                                                              AppLocalizations.of(context).translate("Thank you !!! :)"),
                                                                              style: TextStyle(fontFamily: MyIdenaAppTheme.fontName, fontWeight: FontWeight.w500, fontSize: 16, letterSpacing: -0.1, color: MyIdenaAppTheme.darkText),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ));
                                                      setState(() {
                                                        number.value =
                                                            new TextEditingValue(
                                                                text: "");
                                                      });
                                                    }
                                                  },
                                                  padding: EdgeInsets.all(5.0),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                  color: Colors.white,
                                                  child: Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              "Send a donation"),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        letterSpacing: 1.5,
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            MyIdenaAppTheme
                                                                .fontName,
                                                      )),
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
                      ),
                    );
                  });
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
