import 'package:flutter/material.dart';
import 'package:my_idena/beans/rpc/dna_all.dart';
import 'package:my_idena/beans/rpc/httpService.dart';
import 'package:my_idena/constants/containerMyIdena.dart';
import 'package:my_idena/constants/bottomNavigationBarMyIdena.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/constants/constants.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  final _keyForm = GlobalKey<FormState>();
  HttpService httpService = new HttpService();
  final number = TextEditingController();
  String amount = '';
  String address = '';
  DnaAll dnaAll;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      bottomNavigationBar: BottomNavigationBarMyIdena(indexInit: 4),
      body: FutureBuilder(
          future: httpService.getDnaAll(),
          builder: (BuildContext context, AsyncSnapshot<DnaAll> snapshot) {
            if (snapshot.hasData) {
              dnaAll = snapshot.data;
              if (dnaAll != null && dnaAll.dnaIdentityResponse != null) {
                return SafeArea(
                  child: Form(
                    key: _keyForm,
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
                          top: 40,
                          bottom: 0,
                          left: 90,
                          right: 100,
                          child: ListView(
                            children: <Widget>[
                              Container(
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
                                          children: <Widget>[
                                            Image.asset(
                                                "assets/myIdenaLogo_200.png"),
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
                          top: 250,
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
                                padding: EdgeInsets.all(15),
                                child: Container(
                                  width: double.infinity,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate(
                                                      "You can help with a donation :)"),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'OpenSans',
                                                fontSize: 15.0,
                                              ),
                                            ),
                                                                                        SizedBox(
                                              height: 5,
                                            ),
Container(
                                              alignment: Alignment.center,
                                              decoration: kBoxDecorationStyle,
                                              height: 60.0,
                                              child: TextFormField(
                                                controller: number,
                                                validator: (val) => val.isEmpty
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
                                                  color: Colors.white,
                                                  fontFamily: 'OpenSans',
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          top: 14.0),
                                                  prefixIcon: Icon(
                                                    Icons.monetization_on,
                                                    color: Colors.white,
                                                  ),
                                                  hintText: AppLocalizations.of(
                                                          context)
                                                      .translate(
                                                          "Enter your amount"),
                                                  hintStyle: kHintTextStyle,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 25.0),
                                              width: double.infinity,
                                              child: RaisedButton(
                                                elevation: 5.0,
                                                onPressed: () async {
                                                  if (_keyForm.currentState
                                                      .validate()) {
                                                    try {
                                                      await httpService
                                                          .sendTransaction(
                                                              dnaAll.dnaIdentityResponse.result.address,
                                                              double.parse(
                                                                  amount));
                                                      Navigator.of(context)
                                                          .pushNamed('/home');
                                                    } catch (e) {
                                                      print(e.toString());
                                                    }
                                                  }
                                                },
                                                padding: EdgeInsets.all(15.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                                color: Colors.white,
                                                child: Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                            "Send a donation"),
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      letterSpacing: 1.5,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'OpenSans',
                                                    )),
                                              ),
                                            )
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
                      ],
                    ),
                  ),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
