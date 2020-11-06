import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/bean/votings_list_response.dart';
import 'package:my_idena/backoffice/factory/oracle_service.dart';

import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/pages/widgets/line_small_widget.dart';
import 'package:my_idena/pages/widgets/line_widget.dart';
import 'package:my_idena/pages/widgets/text_above_line_widget.dart';
import 'package:my_idena/utils/app_localizations.dart';

OracleService oracleService = OracleService();
VotingsListResponse votingsListResponse;

class VotingsListView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const VotingsListView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _VotingsListViewState createState() => _VotingsListViewState();
}

class _VotingsListViewState extends State<VotingsListView> {
  int nbVotings = 30;

  @override
  void initState() {
    oracleService.createContractDataReader();
    oracleService.sendVote();
    oracleService.sendVoteProof();
    oracleService.contractReadonlyCall();
    oracleService.contractCall();
    oracleService.contractEstimateCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: oracleService.getVotingsListResponse(nbVotings),
        builder: (BuildContext context,
            AsyncSnapshot<VotingsListResponse> snapshot) {
          if (snapshot.hasData) {
            votingsListResponse = snapshot.data;
            if (votingsListResponse == null) {
              return Text("");
            } else {
              return FadeTransition(
                opacity: widget.animation,
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
                            bottomRight: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: MyIdenaAppTheme.grey.withOpacity(0.2),
                              offset: Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, left: 0, right: 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5, top: 0),
                                        child: Column(
                                          children: <Widget>[
                                            new Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 440,
                                              child: ListView.builder(
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  itemCount: votingsListResponse
                                                      .result.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    VotingsListResponseResult
                                                        voting =
                                                        votingsListResponse
                                                            .result[index];
                                                    return getVotingDisplay(
                                                        voting);
                                                  }),
                                            )
                                          ],
                                        ),
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
                ),
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget getVotingDisplay(VotingsListResponseResult voting) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              voting.title,
              style: TextStyle(
                fontFamily: MyIdenaAppTheme.fontName,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                letterSpacing: -0.2,
                color: MyIdenaAppTheme.darkText,
              ),
            ),
            SizedBox(height: 10),
            Text(
              voting.desc,
              style: TextStyle(
                fontFamily: MyIdenaAppTheme.fontName,
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: MyIdenaAppTheme.grey.withOpacity(0.5),
              ),
            ),
            SizedBox(height: 10),
            // TODO: add votingMinPayment properties
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    textAboveLineWidget(
                        AppLocalizations.of(context).translate("Total prize"),
                        14),
                    lineWidget(100),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        voting.balance + " iDNA",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: MyIdenaAppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: MyIdenaAppTheme.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    textAboveLineWidget(
                        AppLocalizations.of(context).translate("Deadline"), 14),
                    lineWidget(100),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        "TdD",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: MyIdenaAppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: MyIdenaAppTheme.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    textAboveLineWidget(
                        AppLocalizations.of(context)
                            .translate("Quorum required"),
                        14),
                    lineWidget(100),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        "TdD",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: MyIdenaAppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: MyIdenaAppTheme.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    textAboveLineWidget(
                        AppLocalizations.of(context).translate("Vote"), 14),
                    lineWidget(100),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        // TODO Verify
                        voting.votesCount.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: MyIdenaAppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: MyIdenaAppTheme.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    textAboveLineWidget(
                        AppLocalizations.of(context).translate("Free voting"),
                        14),
                    lineWidget(100),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: MyIdenaAppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: MyIdenaAppTheme.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    textAboveLineWidget(
                        AppLocalizations.of(context).translate("Your reward"),
                        14),
                    lineWidget(100),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        "TdD",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: MyIdenaAppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: MyIdenaAppTheme.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 10),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                    child: Text(
                      AppLocalizations.of(context).translate("Open"),
                    ),
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {}),
                FlatButton(
                    child: Text(
                      AppLocalizations.of(context).translate("Add fund"),
                    ),
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {})
              ],
            ),
            smallLineWidget(),
          ],
        ),
      ),
    );
  }
}
