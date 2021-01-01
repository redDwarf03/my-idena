import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:my_idena/network/model/response/dna_getEpoch_response.dart';
import 'package:my_idena/network/model/response/dna_identity_response.dart';
import 'package:my_idena/service/app_service.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/localization.dart';

class ProfileInfos extends StatefulWidget {
  final AnimationController profileInfosController;
  bool profileInfosOpen;
  String address;
  ProfileInfos(
      this.profileInfosController, this.profileInfosOpen, this.address);

  _ProfileInfosState createState() => _ProfileInfosState();
}

class _ProfileInfosState extends State<ProfileInfos> {
  final Logger log = sl.get<Logger>();
  DnaIdentityResponse dnaIdentityResponse = new DnaIdentityResponse();
  DnaGetEpochResponse dnaGetEpochResponse = new DnaGetEpochResponse();

  @override
  void initState() {
    super.initState();

    loadProfileInfos();
  }

  Future<void> loadProfileInfos() async {
    DnaIdentityResponse _dnaIdentityResponse =
        await AppService().getDnaIdentity(widget.address);
    DnaGetEpochResponse _dnaGetEpochResponse =
        await AppService().getDnaGetEpoch();

    setState(() {
      dnaIdentityResponse = _dnaIdentityResponse;
      dnaGetEpochResponse = _dnaGetEpochResponse;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: StateContainer.of(context).curTheme.backgroundDark,
          boxShadow: [
            BoxShadow(
                color: StateContainer.of(context).curTheme.overlay30,
                offset: Offset(-5, 0),
                blurRadius: 20),
          ],
        ),
        child: SafeArea(
          minimum: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.035,
            top: 60,
          ),
          child: Column(
            children: <Widget>[
              dnaIdentityResponse.result == null
                  ? SizedBox()
                  : Container(
                      margin: EdgeInsets.only(bottom: 10.0, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              //Back button
                              Container(
                                height: 40,
                                width: 40,
                                margin: EdgeInsets.only(right: 10, left: 10),
                                child: FlatButton(
                                    highlightColor: StateContainer.of(context)
                                        .curTheme
                                        .text15,
                                    splashColor: StateContainer.of(context)
                                        .curTheme
                                        .text15,
                                    onPressed: () {
                                      setState(() {
                                        widget.profileInfosOpen = false;
                                      });
                                      widget.profileInfosController.reverse();
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(AppIcons.back,
                                        color: StateContainer.of(context)
                                            .curTheme
                                            .text,
                                        size: 24)),
                              ),
                              // Header Text
                              Text(
                                AppLocalization.of(context).profileInfosHeader,
                                style:
                                    AppStyles.textStyleSettingsHeader(context),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                start: smallScreen(context) ? 30 : 40,
                                end: smallScreen(context) ? 30 : 40,
                                top: 16.0),
                            child: AutoSizeText(
                              AppLocalization.of(context).profileInfosAddress,
                              style:
                                  AppStyles.textStyleParagraphPrimary(context),
                              maxLines: 5,
                              stepGranularity: 0.5,
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                start: smallScreen(context) ? 30 : 40,
                                end: smallScreen(context) ? 30 : 40,
                                top: 8),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: '',
                                children: [
                                  TextSpan(
                                    text: dnaIdentityResponse.result.address,
                                    style:
                                        AppStyles.textStyleParagraph(context),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                start: smallScreen(context) ? 30 : 40,
                                end: smallScreen(context) ? 30 : 40,
                                top: 16.0),
                            child: AutoSizeText(
                              AppLocalization.of(context).profileInfosAge,
                              style:
                                  AppStyles.textStyleParagraphPrimary(context),
                              maxLines: 5,
                              stepGranularity: 0.5,
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                start: smallScreen(context) ? 30 : 40,
                                end: smallScreen(context) ? 30 : 40,
                                top: 8),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: '',
                                children: [
                                  TextSpan(
                                    text: dnaIdentityResponse.result.age
                                        .toString(),
                                    style:
                                        AppStyles.textStyleParagraph(context),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                start: smallScreen(context) ? 30 : 40,
                                end: smallScreen(context) ? 30 : 40,
                                top: 16.0),
                            child: AutoSizeText(
                              AppLocalization.of(context).profileInfosEpoch,
                              style:
                                  AppStyles.textStyleParagraphPrimary(context),
                              maxLines: 5,
                              stepGranularity: 0.5,
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                start: smallScreen(context) ? 30 : 40,
                                end: smallScreen(context) ? 30 : 40,
                                top: 8),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: '',
                                children: [
                                  TextSpan(
                                    text: (dnaGetEpochResponse.result.epoch -
                                                dnaIdentityResponse.result.age)
                                            .toString() +
                                        " - " +
                                        dnaGetEpochResponse.result.epoch
                                            .toString(),
                                    style:
                                        AppStyles.textStyleParagraph(context),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                start: smallScreen(context) ? 30 : 40,
                                end: smallScreen(context) ? 30 : 40,
                                top: 16.0),
                            child: AutoSizeText(
                              AppLocalization.of(context).profileInfosState,
                              style:
                                  AppStyles.textStyleParagraphPrimary(context),
                              maxLines: 5,
                              stepGranularity: 0.5,
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                start: smallScreen(context) ? 30 : 40,
                                end: smallScreen(context) ? 30 : 40,
                                top: 8),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: '',
                                children: [
                                  TextSpan(
                                    text: dnaIdentityResponse.result.state,
                                    style:
                                        AppStyles.textStyleParagraph(context),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                start: smallScreen(context) ? 30 : 40,
                                end: smallScreen(context) ? 30 : 40,
                                top: 16.0),
                            child: AutoSizeText(
                              AppLocalization.of(context).profileInfosScore,
                              style:
                                  AppStyles.textStyleParagraphPrimary(context),
                              maxLines: 5,
                              stepGranularity: 0.5,
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                start: smallScreen(context) ? 30 : 40,
                                end: smallScreen(context) ? 30 : 40,
                                top: 8),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: '',
                                children: [
                                  TextSpan(
                                    text: dnaIdentityResponse
                                            .result.totalShortFlipPoints
                                            .toString() +
                                        " / " +
                                        dnaIdentityResponse
                                            .result.totalQualifiedFlips
                                            .toString(),
                                    style:
                                        AppStyles.textStyleParagraph(context),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                start: smallScreen(context) ? 30 : 40,
                                end: smallScreen(context) ? 30 : 40,
                                top: 16.0),
                            child: AutoSizeText(
                              AppLocalization.of(context)
                                  .profileInfosRequiredFlips,
                              style:
                                  AppStyles.textStyleParagraphPrimary(context),
                              maxLines: 5,
                              stepGranularity: 0.5,
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                start: smallScreen(context) ? 30 : 40,
                                end: smallScreen(context) ? 30 : 40,
                                top: 8),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: '',
                                children: [
                                  TextSpan(
                                    text: dnaIdentityResponse
                                        .result.requiredFlips
                                        .toString(),
                                    style:
                                        AppStyles.textStyleParagraph(context),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                start: smallScreen(context) ? 30 : 40,
                                end: smallScreen(context) ? 30 : 40,
                                top: 16.0),
                            child: AutoSizeText(
                              AppLocalization.of(context).profileInfosMadeFlips,
                              style:
                                  AppStyles.textStyleParagraphPrimary(context),
                              maxLines: 5,
                              stepGranularity: 0.5,
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                start: smallScreen(context) ? 30 : 40,
                                end: smallScreen(context) ? 30 : 40,
                                top: 8),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: '',
                                children: [
                                  TextSpan(
                                    text: dnaIdentityResponse.result.madeFlips
                                        .toString(),
                                    style:
                                        AppStyles.textStyleParagraph(context),
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
        ));
  }
}
