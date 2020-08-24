import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/myIdena_home.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/utils/sharedPreferencesHelper.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  int bottomSelectedIndex = 0;
  final _keyForm = GlobalKey<FormState>();
  String apiUrl;
  String keyApp;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<IdenaSharedPreferences>(
        future: SharedPreferencesHelper.getIdenaSharedPreferences(),
        builder: (BuildContext context,
            AsyncSnapshot<IdenaSharedPreferences> snapshot) {
          if (snapshot.hasData == false) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Form(
              key: _keyForm,
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  _pageChanged(index);
                },
                children: <Widget>[
                  _warning(index: 1),
                  _getPageUrlApi(
                      text: 'Type your\nurl api',
                      index: 2,
                      hint: 'urlApi',
                      snapshot: snapshot,
                      context: context),
                  _getPageKeyApp(
                      text: 'Type your\nkey app',
                      index: 3,
                      hint: 'keyApp',
                      snapshot: snapshot,
                      context: context),
                ],
              ),
            );
          }
        });
  }

  void _pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  _warning({int index}) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Image.asset('assets/images/icon.png'),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _getPageNav(index, context),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[
                  _getTellText("Warning"),
                  SizedBox(
                    height: 25,
                  ),
                  _getPageIndicator(index)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getPageUrlApi(
      {String text,
      int index,
      String hint,
      AsyncSnapshot<IdenaSharedPreferences> snapshot,
      BuildContext context}) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Image.asset('assets/images/icon.png'),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _getPageNav(index, context),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[
                  _getTellText(text),
                  SizedBox(
                    height: 25,
                  ),
                  _getPageIndicator(index)
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 20),
                      child: TextFormField(
                        controller: initialValue(snapshot.data.apiUrl == null
                            ? ''
                            : snapshot.data.apiUrl),
                        validator: (val) => val.isEmpty
                            ? AppLocalizations.of(context)
                                .translate("Enter your API url")
                            : null,
                        onChanged: (val) => apiUrl = val,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: MyIdenaAppTheme.fontName,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[400], width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFF2F3F8), width: 1.0),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14.0),
                          prefixIcon: Icon(
                            FlevaIcons.link_2,
                            color: Colors.black54,
                          ),
                          hintText: AppLocalizations.of(context)
                              .translate("Enter your API url"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _getPageKeyApp(
      {String text,
      int index,
      String hint,
      AsyncSnapshot<IdenaSharedPreferences> snapshot,
      BuildContext context}) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Image.asset('assets/images/icon.png'),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _getPageNav(index, context),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[
                  _getTellText(text),
                  SizedBox(
                    height: 25,
                  ),
                  _getPageIndicator(index)
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 20),
                      child: TextFormField(
                        controller: initialValue(snapshot.data.keyApp == null
                            ? ''
                            : snapshot.data.keyApp),
                        validator: (val) => val.isEmpty
                            ? AppLocalizations.of(context)
                                .translate("Enter your key app")
                            : null,
                        onChanged: (val) => keyApp = val,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: MyIdenaAppTheme.fontName,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[400], width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFF2F3F8), width: 1.0),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14.0),
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Colors.black54,
                          ),
                          hintText: AppLocalizations.of(context)
                              .translate("Enter your key app"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _getPageNav(int index, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
            splashColor: Colors.white.withOpacity(0.1),
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () {
              setState(() {
                pageController.previousPage(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeIn,
                );
              });
            },
            child: index > 1
                ? Icon(
                    FlevaIcons.arrow_circle_left_outline,
                    size: 40,
                    color: Colors.black,
                  )
                : Text("")),
        InkWell(
            splashColor: Colors.white.withOpacity(0.1),
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () {
              setState(() {
                if (index < 3) {
                  pageController.nextPage(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeIn,
                  );
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => Home()),
                  );
                }
              });
            },
            child: index < 3
                ? Icon(
                    FlevaIcons.arrow_circle_right_outline,
                    size: 40,
                    color: Colors.black,
                  )
                : Icon(FlevaIcons.checkmark_circle_2_outline,
                    size: 40, color: Colors.green)),
      ],
    );
  }

  initialValue(val) {
    return TextEditingController(text: val);
  }

  _getTextBox(hint, snapshot, context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
        child: TextFormField(
          controller: initialValue(
              snapshot.data.apiUrl == null ? '' : snapshot.data.apiUrl),
          validator: (val) => val.isEmpty
              ? AppLocalizations.of(context).translate("Enter your API url")
              : null,
          onChanged: (val) => apiUrl = val,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.black,
            fontFamily: MyIdenaAppTheme.fontName,
          ),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400], width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFF2F3F8), width: 1.0),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              FlevaIcons.link_2,
              color: Colors.black54,
            ),
            hintText:
                AppLocalizations.of(context).translate("Enter your API url"),
          ),
        ),
      ),
    );
  }

  _getPageIndicator(index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: index == 1 ? 16 : 6,
          height: 6,
          decoration: BoxDecoration(
              color: index == 1 ? Colors.black : Colors.black54,
              borderRadius: BorderRadius.circular(10)),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          width: index == 2 ? 16 : 6,
          height: 6,
          decoration: BoxDecoration(
              color: index == 2 ? Colors.black : Colors.black54,
              borderRadius: BorderRadius.circular(10)),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          width: index == 3 ? 16 : 6,
          height: 6,
          decoration: BoxDecoration(
              color: index == 3 ? Colors.black : Colors.black54,
              borderRadius: BorderRadius.circular(10)),
        ),
      ],
    );
  }

  _getTellText(text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.black, fontSize: 35, fontWeight: FontWeight.w500),
    );
  }
}
