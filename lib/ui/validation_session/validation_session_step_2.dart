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
import 'package:my_idena/ui/validation_session/flip_detail_widget.dart';
import 'package:my_idena/ui/validation_session/validation_thumbnails.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/ui/widgets/count_down.dart';
import 'package:my_idena/ui/widgets/demo_mode_clip_widget.dart';
import 'package:my_idena/ui/widgets/dialog.dart';
import 'package:my_idena/util/caseconverter.dart';
import 'package:my_idena/util/enums/epoch_period.dart' as EpochPeriod;
import 'package:my_idena/util/enums/answer_type.dart' as AnswerType;

class ValidationSessionStep2Page extends StatefulWidget {
  final bool simulationMode;
  final String privateKey;

  ValidationSessionStep2Page({Key key, this.simulationMode, this.privateKey}) : super(key: key);

  @override
  _ValidationSessionStep2PageState createState() =>
      _ValidationSessionStep2PageState();
}

class _ValidationSessionStep2PageState
    extends State<ValidationSessionStep2Page> {
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
    ValidationSessionInfo _validationSessionInfo = await sl.get<ValidationService>()
        .getValidationSessionFlipsList(
            EpochPeriod.LongSession, null, widget.simulationMode, StateContainer.of(context)
                                .selectedAccount
                                .address);
    _validationSessionInfo.privateKey = widget.privateKey;
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
                            privateKey: validationSessionInfo.privateKey,
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
                          sl.get<ValidationService>()
                              .submitLongAnswers(validationSessionInfo);
                        }
                        Navigator.of(context).pushNamed(
                          '/home',
                        );
                      })
                  : SizedBox(),
              allSelect
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AppButton.buildAppButton(
                            context,
                            AppButtonType.PRIMARY,
                            AppLocalization.of(context).startCheckingKeywords,
                            Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
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
                            Navigator.of(context).pushNamed(
                                '/validation_session_step_3',
                                arguments: {
                                  'simulationMode': widget.simulationMode,
                                  'validationSessionInfo': validationSessionInfo,
                                  'privateKey' : validationSessionInfo.privateKey
                                });
                          });
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
