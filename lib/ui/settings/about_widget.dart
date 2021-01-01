import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/localization.dart';

class About extends StatefulWidget {
  final AnimationController aboutController;
  bool aboutOpen;

  About(this.aboutController, this.aboutOpen);

  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  final Logger log = sl.get<Logger>();

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
              Container(
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
                              highlightColor:
                                  StateContainer.of(context).curTheme.text15,
                              splashColor:
                                  StateContainer.of(context).curTheme.text15,
                              onPressed: () {
                                setState(() {
                                  widget.aboutOpen = false;
                                });
                                widget.aboutController.reverse();
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                              padding: EdgeInsets.all(8.0),
                              child: Icon(AppIcons.back,
                                  color:
                                      StateContainer.of(context).curTheme.text,
                                  size: 24)),
                        ),
                        // Header Text
                        Text(
                          AppLocalization.of(context).aboutHeader,
                          style: AppStyles.textStyleSettingsHeader(context),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(
                          start: smallScreen(context) ? 30 : 40,
                          end: smallScreen(context) ? 30 : 40,
                          top: 16.0),
                      child: AutoSizeText(
                        AppLocalization.of(context).thanksForHelp,
                        style: AppStyles.textStyleParagraphPrimary(context),
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
                              text:
                                  "Mahmoud !!!, Cryptomatrix, Andrew, Rioda, Sysy, Bus, JaymenChou, Gutalean, Tony, Dont Ramp, Qsvtr, Ludiveen, Set Animals, Rados, Alek, Shadowcrypto, Kazunori, Bingbinglee, gσѕϯ111, Neotame, Toni.dev, Orizhial, Kevin G., Marko, Martin Grabarz, CoinDrix, ...",
                              style: AppStyles.textStyleParagraph(context),
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
                      child: Text(
                        AppLocalization.of(context).thanksAuthor,
                        style: AppStyles.textStyleParagraphPrimary(context),
                      ),
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(
                          start: smallScreen(context) ? 30 : 40,
                          end: smallScreen(context) ? 30 : 40,
                          top: 16.0),
                      child:
                          Image.asset('assets/images/reddwarf.jpg', width: 70),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
