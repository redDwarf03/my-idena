import 'package:flutter/material.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/utils/sharedPreferencesHelper.dart';
import 'package:my_idena/beans/rpc/dna_all.dart';
import 'package:my_idena/constants/bottomNavigationBarMyIdena.dart';
import 'package:my_idena/constants/containerMyIdena.dart';
import 'package:my_idena/constants/constants.dart';

// TODO: Bug dans la console à corriger
// The getter 'keyApp' was called on null.
// Receiver: null
// Tried calling: keyApp

class ParamRPC extends StatefulWidget {
  final DnaAll dnaAll;

  ParamRPC({Key key, this.dnaAll}) : super(key: key);

  @override
  _ParamRPCState createState() => _ParamRPCState();
}

class _ParamRPCState extends State<ParamRPC> {
  final _keyForm = GlobalKey<FormState>();

  String apiUrl = '';
  String keyApp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      bottomNavigationBar: BottomNavigationBarMyIdena(indexInit: 3),
      body: SafeArea(
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
                      AppLocalizations.of(context).translate("my Idena"),
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
                top: 100,
                bottom: 0,
                left: 20,
                right: 20,
                child: ListView(
                  children: <Widget>[
                    FutureBuilder<IdenaSharedPreferences>(
                        future:
                            SharedPreferencesHelper.getIdenaSharedPreferences(),
                        builder: (BuildContext context,
                            AsyncSnapshot<IdenaSharedPreferences> snapshot) {
                          return Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextFormField(
                              controller: initialValue(snapshot.data.apiUrl),
                              validator: (val) => val.isEmpty
                                  ? AppLocalizations.of(context)
                                      .translate("Enter your API url")
                                  : null,
                              onChanged: (val) => apiUrl = val,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.blur_on,
                                  color: Colors.white,
                                ),
                                hintText: AppLocalizations.of(context)
                                    .translate("Enter your API url"),
                                hintStyle: kHintTextStyle,
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
              Positioned(
                top: 200,
                bottom: 0,
                left: 20,
                right: 20,
                child: ListView(
                  children: <Widget>[
                    FutureBuilder<IdenaSharedPreferences>(
                        future:
                            SharedPreferencesHelper.getIdenaSharedPreferences(),
                        builder: (BuildContext context,
                            AsyncSnapshot<IdenaSharedPreferences> snapshot) {
                          return Container(
                            alignment: Alignment.centerLeft,
                            decoration: kBoxDecorationStyle,
                            height: 60.0,
                            child: TextFormField(
                              controller: initialValue(snapshot.data.keyApp),
                              validator: (val) => val.isEmpty
                                  ? AppLocalizations.of(context)
                                      .translate("Enter your key app")
                                  : null,
                              onChanged: (val) => keyApp = val,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.vpn_key,
                                  color: Colors.white,
                                ),
                                hintText: AppLocalizations.of(context)
                                    .translate("Enter your key app"),
                                hintStyle: kHintTextStyle,
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
              Positioned(
                top: 300,
                bottom: 0,
                left: 20,
                right: 20,
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 25.0),
                      width: double.infinity,
                      child: RaisedButton(
                        elevation: 5.0,
                        onPressed: () async {
                          if (_keyForm.currentState.validate()) {
                            try {
                              await SharedPreferencesHelper
                                  .setIdenaSharedPreferences(
                                      IdenaSharedPreferences(apiUrl, keyApp));
                              Navigator.of(context).pushNamed('/home');
                            } catch (e) {
                              print(e.toString());
                            }
                          }
                        },
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Colors.white,
                        child:
                            Text(AppLocalizations.of(context).translate("Save"),
                                style: TextStyle(
                                  color: Colors.grey,
                                  letterSpacing: 1.5,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
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
    );
  }

  initialValue(val) {
    return TextEditingController(text: val);
  }
}
