import 'package:flutter/material.dart';
import 'package:my_idena/beans/dictWords.dart';
import 'package:my_idena/beans/rpc/dna_all.dart';
import 'package:my_idena/beans/rpc/dna_identity_response.dart';
import 'package:my_idena/constants/bottomNavigationBarMyIdena.dart';
import 'package:my_idena/constants/containerMyIdena.dart';
import 'package:my_idena/pages/flip_upload_img.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/utils/util_flip.dart';

UtilFlip utilFlip = new UtilFlip();

class FlipWords extends StatefulWidget {
  final DnaAll dnaAll;

  FlipWords({Key key, this.dnaAll}) : super(key: key);

  @override
  _FlipWordsState createState() => _FlipWordsState();
}

DictWords dictWords;
DnaIdentityResponse dnaIdentityResponse;
int flipKeyWordPairsNumber;

class _FlipWordsState extends State<FlipWords> {
  final DictWords dictWordsLoad = DictWords();

  @override
  void initState() {
    super.initState();
    flipKeyWordPairsNumber =
        utilFlip.getFirstFlipKeyWordPairsNotUsed(widget.dnaAll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      bottomNavigationBar: BottomNavigationBarMyIdena(indexInit: 1),
      body: FutureBuilder(
          future: dictWordsLoad.getDictWords(),
          builder: (BuildContext context, AsyncSnapshot<DictWords> snapshot) {
            if (snapshot.hasData) {
              dictWords = snapshot.data;
              return SafeArea(
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
                      top: 40,
                      bottom: 0,
                      left: 20,
                      right: 20,
                      child: ListView(
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context).translate("Think up a story"),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            AppLocalizations.of(context).translate("Think up a short story about someone/something related to the two key words below according to the template"),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 135,
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
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              dictWords
                                                      .words[widget
                                                          .dnaAll
                                                          .dnaIdentityResponse
                                                          .result
                                                          .flipKeyWordPairs
                                                          .elementAt(
                                                              flipKeyWordPairsNumber)
                                                          .words[0]]
                                                      .name +
                                                  " : ",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            Text(
                                              dictWords
                                                  .words[widget
                                                      .dnaAll
                                                      .dnaIdentityResponse
                                                      .result
                                                      .flipKeyWordPairs
                                                      .elementAt(
                                                          flipKeyWordPairsNumber)
                                                      .words[0]]
                                                  .desc,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'OpenSans',
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              dictWords
                                                      .words[widget
                                                          .dnaAll
                                                          .dnaIdentityResponse
                                                          .result
                                                          .flipKeyWordPairs
                                                          .elementAt(
                                                              flipKeyWordPairsNumber)
                                                          .words[1]]
                                                      .name +
                                                  " : ",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            Text(
                                              dictWords
                                                  .words[widget
                                                      .dnaAll
                                                      .dnaIdentityResponse
                                                      .result
                                                      .flipKeyWordPairs
                                                      .elementAt(
                                                          flipKeyWordPairsNumber)
                                                      .words[1]]
                                                  .desc,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'OpenSans',
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ],
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
                      top: 450,
                      bottom: 0,
                      left: 20,
                      right: 20,
                      child: ListView(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            child: RaisedButton(
                                elevation: 5.0,
                                onPressed: () async {
                                  setState(() {
                                    flipKeyWordPairsNumber = utilFlip
                                        .findNextFlipKeyWordPairsNotUsed(
                                            widget.dnaAll,
                                            flipKeyWordPairsNumber + 1);
                                  });
                                },
                                padding: EdgeInsets.all(15.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: Colors.white,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.autorenew,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                          AppLocalizations.of(context).translate("Change words") + " (#" +
                                            (flipKeyWordPairsNumber + 1).toString() +
                                            ")",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          letterSpacing: 1.5,
                                          fontSize: 15.0,
                                          fontFamily: 'OpenSans',
                                        ),
                                      ),
                                    ])),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 540,
                      bottom: 0,
                      left: 20,
                      right: 20,
                      child: ListView(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            child: RaisedButton(
                              elevation: 5.0,
                              onPressed: () async {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => FlipUploadImg()));
                              },
                              padding: EdgeInsets.all(15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              color: Colors.white,
                              child: Text(
                                AppLocalizations.of(context).translate("Next step"),
                                style: TextStyle(
                                  color: Colors.grey,
                                  letterSpacing: 1.5,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
