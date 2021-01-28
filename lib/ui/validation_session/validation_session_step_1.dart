import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/network/model/response/dna_ceremonyIntervals_response.dart';
import 'package:my_idena/network/model/response/dna_getEpoch_response.dart';
import 'package:my_idena/network/model/validation_session_infos.dart';
import 'package:my_idena/service/app_service.dart';
import 'package:my_idena/service/validation_service.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/ui/validation_session/flip_detail_widget.dart';
import 'package:my_idena/ui/validation_session/validation_thumbnails.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/ui/widgets/count_down.dart';
import 'package:my_idena/ui/widgets/demo_mode_clip_widget.dart';
import 'package:my_idena/util/enums/epoch_period.dart' as EpochPeriod;
import 'package:my_idena/util/enums/answer_type.dart' as AnswerType;

class ValidationSessionStep1Page extends StatefulWidget {
  final bool simulationMode;

  ValidationSessionStep1Page({Key key, this.simulationMode}) : super(key: key);

  @override
  _ValidationSessionStep1PageState createState() =>
      _ValidationSessionStep1PageState();
}

class _ValidationSessionStep1PageState
    extends State<ValidationSessionStep1Page> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  ValidationSessionInfo validationSessionInfo = new ValidationSessionInfo();
  int _durationSession = 0;

  bool allSelect;

  @override
  void initState() {
    super.initState();

    loadDurationSession();
    allSelect = false;
    loadValidationSession();
  }

  Future<void> loadDurationSession() async {
    DnaCeremonyIntervalsResponse dnaCeremonyIntervalsResponse =
        await AppService().getDnaCeremonyIntervals();
    DnaGetEpochResponse dnaGetEpochResponse =
        await AppService().getDnaGetEpoch();

    int _durationCalculation = 0;
    if (widget.simulationMode) {
      _durationCalculation =
          dnaCeremonyIntervalsResponse.result.shortSessionDuration;
      print("Duration : " + _durationCalculation.toString());
    } else {
      _durationCalculation =
          dnaCeremonyIntervalsResponse.result.shortSessionDuration -
              DateTime.now()
                  .difference(dnaGetEpochResponse.result.nextValidation)
                  .inSeconds -
              5;
      print("Duration : " +
          dnaCeremonyIntervalsResponse.result.shortSessionDuration.toString() +
          "-" +
          DateTime.now()
              .difference(dnaGetEpochResponse.result.nextValidation)
              .inSeconds
              .toString() +
          "-5");
    }

    setState(() {
      _durationSession = _durationCalculation;
    });
  }

  Future<void> loadValidationSession() async {
    ValidationSessionInfo _validationSessionInfo = await ValidationService()
        .getValidationSessionFlipsList(
            EpochPeriod.ShortSession, null, widget.simulationMode);

    setState(() {
      validationSessionInfo = _validationSessionInfo;
    });

    print("nb Flips loaded : " +
        validationSessionInfo.listSessionValidationFlips.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      backgroundColor: StateContainer.of(context).curTheme.backgroundDark,
      body: LayoutBuilder(
        builder: (context, constraints) => SafeArea(
          minimum: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.035,
              top: MediaQuery.of(context).size.height * 0.075),
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      // Back Button
                      Container(
                        margin: EdgeInsetsDirectional.only(
                            start: smallScreen(context) ? 15 : 20),
                        height: 50,
                        width: 50,
                        child: FlatButton(
                            highlightColor:
                                StateContainer.of(context).curTheme.text15,
                            splashColor:
                                StateContainer.of(context).curTheme.text15,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Icon(AppIcons.back,
                                color: StateContainer.of(context).curTheme.text,
                                size: 24)),
                      ),
                      Text(
                        AppLocalization.of(context).validationHeader,
                        style: AppStyles.textStyleSettingsHeader(context),
                      ),
                      Container(
                          margin: EdgeInsetsDirectional.only(
                              end: smallScreen(context) ? 15 : 20),
                          height: 50,
                          width: 50,
                          child: FlatButton(
                              highlightColor:
                                  StateContainer.of(context).curTheme.text15,
                              splashColor:
                                  StateContainer.of(context).curTheme.text15,
                              onPressed: () {
                                loadValidationSession();
                                setState(() {
                                  for (int i = 0;
                                      i <
                                          validationSessionInfo
                                              .listSessionValidationFlips
                                              .length;
                                      i++) {
                                    validationSessionInfo
                                        .listSessionValidationFlips[i]
                                        .answerType = AnswerType.NONE;
                                  }
                                  allSelect = false;
                                });
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                              padding: EdgeInsets.all(0.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.refresh,
                                      color: Colors.red[300], size: 24),
                                  Text("hot\nreload",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 7, color: Colors.red[300]))
                                ],
                              ))),
                    ],
                  ),
                  demoModeClipWidget(context, widget.simulationMode),
                  Container(
                    margin: EdgeInsetsDirectional.only(
                        start: smallScreen(context) ? 30 : 40,
                        end: smallScreen(context) ? 30 : 40,
                        top: 16.0),
                    child: AutoSizeText(
                      AppLocalization.of(context).validationStep1Header,
                      style: AppStyles.textStyleParagraphPrimary(context),
                      maxLines: 5,
                      stepGranularity: 0.5,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    new ValidationThumbnails(
                      listSessionValidationFlip:
                          validationSessionInfo.listSessionValidationFlips,
                    ),
                    ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: 0.0, bottom: 15),
                      itemCount: validationSessionInfo == null ||
                              validationSessionInfo
                                      .listSessionValidationFlips ==
                                  null
                          ? 0
                          : validationSessionInfo
                              .listSessionValidationFlips.length,
                      itemBuilder: (context, index) {
                        return FlipDetail(
                            address: StateContainer.of(context)
                                .selectedAccount
                                .address,
                            simulationMode: widget.simulationMode,
                            validationSessionInfoFlips: validationSessionInfo
                                .listSessionValidationFlips[index],
                            onSelectFlip: (ValidationSessionInfoFlips
                                _validationSessionInfoFlips) {
                              setState(() {
                                allSelect = true;
                                for (int i = 0;
                                    i <
                                        validationSessionInfo
                                            .listSessionValidationFlips.length;
                                    i++) {
                                  if (validationSessionInfo
                                          .listSessionValidationFlips[i]
                                          .answerType ==
                                      AnswerType.NONE) {
                                    allSelect = false;
                                    break;
                                  }
                                }
                                validationSessionInfo
                                        .listSessionValidationFlips[index] =
                                    _validationSessionInfoFlips;
                              });
                            });
                      },
                    ),
                  ],
                ),
              ),

              // Next Screen Button
              _durationSession != 0
                  ? CountDown(
                      durationInSeconds: _durationSession,
                      isEndCountDown: (bool isEnd) {
                        if (widget.simulationMode == false) {
                          ValidationService()
                              .submitShortAnswers(validationSessionInfo);
                        }
                        Navigator.of(context).pushNamed(
                            '/validation_session_step_2',
                            arguments: widget.simulationMode);
                      })
                  : SizedBox(),
              allSelect
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AppButton.buildAppButton(
                            context,
                            AppButtonType.PRIMARY,
                            AppLocalization.of(context).submitAnswers,
                            Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                          if (widget.simulationMode == false) {
                            ValidationService()
                                .submitShortAnswers(validationSessionInfo);
                          }
                          Navigator.of(context).pushNamed(
                              '/validation_session_step_2',
                              arguments: widget.simulationMode);
                        }),
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
