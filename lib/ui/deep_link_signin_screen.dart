// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:idena_lib_dart/deepLinks/deepLinkParamSignin.dart';
import 'package:idena_lib_dart/deepLinks/idena_url.dart';
import 'package:idena_lib_dart/factory/app_service.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/ui/util/routes.dart';
import 'package:my_idena/ui/util/ui_util.dart';
import 'package:my_idena/ui/widgets/buttons.dart';

class DeepLinkSigninScreen extends StatefulWidget {
  final DeepLinkParamSignin deepLinkParam;

  const DeepLinkSigninScreen({
    Key key,
    this.deepLinkParam,
  }) : super(key: key);

  @override
  _DeepLinkSigninScreenState createState() => _DeepLinkSigninScreenState();
}

class _DeepLinkSigninScreenState extends State<DeepLinkSigninScreen> {
  DeepLinkParamSignin deepLinkParam;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    deepLinkParam = widget.deepLinkParam;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: StateContainer.of(context).curTheme.backgroundDark,
      body: LayoutBuilder(
        builder: (context, constraints) => SafeArea(
          minimum: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.035,
              top: MediaQuery.of(context).size.height * 0.075),
          child: Column(
            children: <Widget>[
              // The header
              Container(
                margin: EdgeInsetsDirectional.only(
                  start: smallScreen(context) ? 30 : 40,
                  end: smallScreen(context) ? 30 : 40,
                  top: 10,
                ),
                alignment: AlignmentDirectional(-1, 0),
                child: AutoSizeText(
                  AppLocalization.of(context).signinConfirmation,
                  style: AppStyles.textStyleHeaderColored(context),
                  stepGranularity: 0.1,
                  maxLines: 1,
                  minFontSize: 12,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "Please confirm that you want to use your public address for the website login",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: StateContainer.of(context)
                                              .curTheme
                                              .primary,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w600,
                                        )),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Text(
                                      "Website: ",
                                      style:
                                          AppStyles.textStyleParagraphPrimary(
                                              context),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      deepLinkParam.nonceEndpoint != null
                                          ? IdenaUrl().getHostname(
                                              deepLinkParam.nonceEndpoint)
                                          : "",
                                      style:
                                          AppStyles.textStyleParagraph(context),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Address: ",
                                      style:
                                          AppStyles.textStyleParagraphPrimary(
                                              context),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      StateContainer.of(context)
                                          .selectedAccount
                                          .address,
                                      style:
                                          AppStyles.textStyleParagraph(context),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: Container(
                                        height: 52,
                                        width: 52,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              StateContainer.of(context)
                                                  .curTheme
                                                  .text05,
                                          backgroundImage:
                                              UIUtil.getRobohashURL(
                                                  StateContainer.of(context)
                                                      .selectedAccount
                                                      .address),
                                          radius: 50.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Token: ",
                                      style:
                                          AppStyles.textStyleParagraphPrimary(
                                              context),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      deepLinkParam.token != null
                                          ? deepLinkParam.token
                                          : "",
                                      style:
                                          AppStyles.textStyleParagraph(context),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    AppButton.buildAppButton(
                        context,
                        AppButtonType.TEXT_OUTLINE,
                        AppLocalization.of(context).yesButton,
                        Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () async {
                      deepLinkParam.address =
                          StateContainer.of(context).selectedAccount.address;
                      await _launchDeepLink(widget.deepLinkParam,
                          await StateContainer.of(context).getSeed());
                      setState(() {
                        Navigator.of(context)
                            .popUntil(RouteUtils.withNameLike('/home'));
                      });
                    }),
                    AppButton.buildAppButton(
                        context,
                        AppButtonType.TEXT_OUTLINE,
                        AppLocalization.of(context).cancel,
                        Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                      setState(() {
                        Navigator.of(context)
                            .popUntil(RouteUtils.withNameLike('/home'));
                      });
                    }),
                  ],
                )
              ])
            ],
          ),
        ),
      ),
    );
  }

  _launchDeepLink(deepLinkParam, String seed) async {
    deepLinkParam = await IdenaUrl().getNonce(deepLinkParam);
    deepLinkParam = await sl.get<AppService>().signin(deepLinkParam, seed);
    deepLinkParam = await IdenaUrl().authenticate(deepLinkParam);
    try {
      launch(deepLinkParam.callbackUrl,
          forceSafariVC: false, forceWebView: false);
    } catch (e) {}
  }
}
