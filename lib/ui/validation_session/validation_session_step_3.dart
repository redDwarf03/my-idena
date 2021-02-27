import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/network/model/response/dna_ceremonyIntervals_response.dart';
import 'package:my_idena/network/model/response/dna_getEpoch_response.dart';
import 'package:my_idena/network/model/validation_session_infos.dart';
import 'package:my_idena/service/app_service.dart';
import 'package:my_idena/service/validation_service.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/ui/util/ui_util.dart';
import 'package:my_idena/ui/validation_session/evaluation_flip_widget.dart';
import 'package:my_idena/ui/validation_session/flip_detail_widget.dart';
import 'package:my_idena/ui/validation_session/validation_thumbnails.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/ui/widgets/count_down.dart';
import 'package:my_idena/ui/widgets/demo_mode_clip_widget.dart';
import 'package:my_idena/ui/widgets/dialog.dart';
import 'package:my_idena/util/caseconverter.dart';
import 'package:my_idena/util/enums/epoch_period.dart' as EpochPeriod;
import 'package:my_idena/util/enums/answer_type.dart' as AnswerType;
import 'package:my_idena/util/enums/relevance_type.dart' as RelevantType;

class ValidationSessionStep3Page extends StatefulWidget {
  final ValidationSessionInfo paramValidationSessionInfo;
  final bool simulationMode;
  final String privateKey;
  final String address;

  ValidationSessionStep3Page(
      {Key key,
      this.paramValidationSessionInfo,
      this.simulationMode,
      this.privateKey,
      this.address})
      : super(key: key);

  @override
  _ValidationSessionStep3PageState createState() =>
      _ValidationSessionStep3PageState();
}

class _ValidationSessionStep3PageState
    extends State<ValidationSessionStep3Page> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool allSelect;
  bool allQualify;
  bool irrelvantCtl;
  int nbIrrelevant;
  int nbRelevant;
  ValidationSessionInfo validationSessionInfo = new ValidationSessionInfo();
  int _durationSession = 0;

  @override
  void initState() {
    super.initState();

    loadDurationSession();

    allSelect = true;
    allQualify = false;
    nbIrrelevant = 0;
    nbRelevant = 0;
    irrelvantCtl = false;
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
          dnaCeremonyIntervalsResponse.result.longSessionDuration;
      print("Duration : " + _durationCalculation.toString());
    } else {
      _durationCalculation = dnaGetEpochResponse.result.nextValidation
              .add(new Duration(
                  seconds:
                      dnaCeremonyIntervalsResponse.result.longSessionDuration))
              .add(new Duration(
                  seconds:
                      dnaCeremonyIntervalsResponse.result.shortSessionDuration))
              .difference(DateTime.now())
              .inSeconds -
          5;
      print("Duration : " +
          dnaGetEpochResponse.result.nextValidation
              .add(new Duration(
                  seconds:
                      dnaCeremonyIntervalsResponse.result.longSessionDuration))
              .add(new Duration(
                  seconds:
                      dnaCeremonyIntervalsResponse.result.shortSessionDuration))
              .difference(DateTime.now())
              .inSeconds
              .toString() +
          "-5");
    }

    setState(() {
      _durationSession = _durationCalculation;
    });
  }

  Future<void> loadValidationSession() async {
    validationSessionInfo = await sl
        .get<ValidationService>()
        .getValidationSessionFlipsList(
            EpochPeriod.LongSession,
            widget.paramValidationSessionInfo,
            widget.simulationMode,
            widget.address);
    validationSessionInfo.privateKey = widget.privateKey;
    setState(() {});
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
                      Container(
                        margin: EdgeInsetsDirectional.only(
                            start: smallScreen(context) ? 15 : 20),
                        height: 50,
                        width: 50,
                        child: SizedBox(height: 50, width: 50),
                      ),
                      Text(
                        AppLocalization.of(context).validationHeader,
                        style: AppStyles.textStyleSettingsHeader(context),
                      ),
                    ],
                  ),
                  demoModeClipWidget(context, widget.simulationMode),
                  Container(
                    margin: EdgeInsetsDirectional.only(
                        start: smallScreen(context) ? 30 : 40,
                        end: smallScreen(context) ? 30 : 40,
                        top: 16.0),
                    child: AutoSizeText(
                      AppLocalization.of(context).validationStep3Header,
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
                        return Column(
                          children: [
                            FlipDetail(
                                privateKey: validationSessionInfo.privateKey,
                                address: StateContainer.of(context)
                                    .selectedAccount
                                    .address,
                                simulationMode: widget.simulationMode,
                                validationSessionInfoFlips:
                                    validationSessionInfo
                                        .listSessionValidationFlips[index],
                                onSelectFlip: (ValidationSessionInfoFlips
                                    _validationSessionInfoFlips) {
                                  setState(() {
                                    allSelect = true;
                                    for (int i = 0;
                                        i <
                                            validationSessionInfo
                                                .listSessionValidationFlips
                                                .length;
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
                                }),
                            EvaluationFlip(
                                simulationMode: widget.simulationMode,
                                validationSessionInfoFlips:
                                    validationSessionInfo
                                        .listSessionValidationFlips[index],
                                wordsMap:
                                    StateContainer.of(context).dictWords.words,
                                onSelectFlip: (ValidationSessionInfoFlips
                                    _validationSessionInfoFlips) {
                                  setState(() {
                                    allQualify = true;

                                    nbIrrelevant = 0;
                                    nbRelevant = 0;
                                    for (int i = 0;
                                        i <
                                            validationSessionInfo
                                                .listSessionValidationFlips
                                                .length;
                                        i++) {
                                      if (validationSessionInfo
                                              .listSessionValidationFlips[i]
                                              .relevanceType ==
                                          RelevantType.NO_INFO) {
                                        allQualify = false;
                                      }
                                      if (validationSessionInfo
                                              .listSessionValidationFlips[i]
                                              .relevanceType ==
                                          RelevantType.RELEVANT) {
                                        nbRelevant++;
                                      }
                                      if (validationSessionInfo
                                              .listSessionValidationFlips[i]
                                              .relevanceType ==
                                          RelevantType.IRRELEVANT) {
                                        nbIrrelevant++;
                                      }
                                    }
                                    validationSessionInfo
                                            .listSessionValidationFlips[index] =
                                        _validationSessionInfoFlips;
                                    if (allQualify &&
                                        nbIrrelevant != 0 &&
                                        nbRelevant / nbIrrelevant < 3) {
                                      irrelvantCtl = false;
                                      UIUtil.showSnackbar(
                                          AppLocalization.of(context)
                                              .validationFlipsIrrelevantLimitControl,
                                          context);
                                    } else {
                                      irrelvantCtl = true;
                                    }
                                  });
                                }),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              _durationSession != 0
                  ? CountDown(
                      durationInSeconds: _durationSession,
                      isEndCountDown: (bool isEnd) {
                        if (widget.simulationMode == false) {
                          sl
                              .get<ValidationService>()
                              .submitLongAnswers(validationSessionInfo);
                        }
                        Navigator.of(context).pushNamed(
                          '/home',
                        );
                      })
                  : SizedBox(),
              // Next Screen Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AppButton.buildAppButton(
                      context,
                      allSelect && allQualify && irrelvantCtl
                          ? AppButtonType.PRIMARY
                          : AppButtonType.PRIMARY_OUTLINE,
                      AppLocalization.of(context).submitAnswers,
                      Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                    if (allSelect && allQualify && irrelvantCtl == false) {
                      AppDialogs.showConfirmDialog(
                          context,
                          AppLocalization.of(context)
                              .validationAnswersNotAllSelectTitle,
                          AppLocalization.of(context)
                              .validationAnswersNotAllQualifyDesc,
                          CaseChange.toUpperCase(
                              AppLocalization.of(context).yesButton, context),
                          () async {
                        AppDialogs.showConfirmDialog(
                            context,
                            AppLocalization.of(context)
                                .validationAnswersNotYetSubmitted,
                            AppLocalization.of(context)
                                    .validationQualifyKeywords +
                                " " +
                                AppLocalization.of(context)
                                    .validationFlipsIrrelevantKeywordsWarning,
                            CaseChange.toUpperCase(
                                AppLocalization.of(context)
                                    .validationUnderstand,
                                context), () {
                          AppDialogs.showConfirmDialog(
                              context,
                              AppLocalization.of(context).validationHeader,
                              AppLocalization.of(context)
                                  .validationFlipsSubmitOk,
                              CaseChange.toUpperCase(
                                  AppLocalization.of(context).goHome, context),
                              () {
                            if (widget.simulationMode == false) {
                              sl
                                  .get<ValidationService>()
                                  .submitLongAnswers(validationSessionInfo);
                            }
                            Navigator.of(context).pushNamed(
                              '/home',
                            );
                          });
                        });
                      });
                    } else {
                      AppDialogs.showConfirmDialog(
                          context,
                          AppLocalization.of(context).validationHeader,
                          AppLocalization.of(context).validationFlipsSubmitOk,
                          CaseChange.toUpperCase(
                              AppLocalization.of(context).goHome, context), () {
                        if (widget.simulationMode == false) {
                          sl
                              .get<ValidationService>()
                              .submitLongAnswers(validationSessionInfo);
                        }
                        Navigator.of(context).pushNamed(
                          '/home',
                        );
                      });
                    }
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
