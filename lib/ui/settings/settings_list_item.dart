// @dart=2.9
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/model/setting_item.dart';
import 'package:my_idena/ui/util/ui_util.dart';

class AppSettings {
  //Settings item with a dropdown option
  static Widget buildSettingsListItemDoubleLine(
      BuildContext context,
      String heading,
      SettingSelectionItem defaultMethod,
      IconData icon,
      Function onPressed,
      {bool disabled = false}) {
    return IgnorePointer(
      ignoring: disabled,
      child: FlatButton(
        highlightColor: StateContainer.of(context).curTheme.text15,
        splashColor: StateContainer.of(context).curTheme.text15,
        onPressed: () {
          onPressed();
        },
        padding: EdgeInsets.all(0.0),
        child: Container(
          height: 60.0,
          margin: EdgeInsetsDirectional.only(start: 30.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsetsDirectional.only(end: 13.0),
                child: Container(
                  child: Icon(icon,
                      color: disabled
                          ? StateContainer.of(context).curTheme.icon45
                          : StateContainer.of(context).curTheme.icon,
                      size: 24),
                  margin: EdgeInsets.only(top: 3, left: 3, bottom: 3, right: 3),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: UIUtil.drawerWidth(context) - 100,
                    child: AutoSizeText(
                      heading,
                      style: disabled
                          ? AppStyles.textStyleSettingItemHeader45(context)
                          : AppStyles.textStyleSettingItemHeader(context),
                      maxLines: 1,
                      stepGranularity: 0.1,
                      minFontSize: 8,
                    ),
                  ),
                  Container(
                    width: UIUtil.drawerWidth(context) - 100,
                    child: AutoSizeText(
                      defaultMethod.getDisplayName(context),
                      style: disabled
                          ? AppStyles.textStyleSettingItemSubheader30(context)
                          : AppStyles.textStyleSettingItemSubheader(context),
                      maxLines: 1,
                      stepGranularity: 0.1,
                      minFontSize: 8,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Settings item without any dropdown option but rather a direct functionality
  static Widget buildSettingsListItemSingleLine(
      BuildContext context, String heading, IconData settingIcon,
      {Function onPressed}) {
    return FlatButton(
      highlightColor: StateContainer.of(context).curTheme.text15,
      splashColor: StateContainer.of(context).curTheme.text15,
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        } else {
          return;
        }
      },
      padding: EdgeInsets.all(0.0),
      child: Container(
        height: 60.0,
        margin: EdgeInsetsDirectional.only(start: 30.0),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsetsDirectional.only(end: 13.0),
              child: Container(
                child: Icon(
                  settingIcon,
                  color: StateContainer.of(context).curTheme.icon,
                  size: 24,
                ),
                margin: EdgeInsetsDirectional.only(
                  top: 3,
                  start: settingIcon == AppIcons.logout
                      ? 6
                      : settingIcon == AppIcons.changerepresentative
                          ? 0
                          : settingIcon == AppIcons.backupseed
                              ? 1
                              : settingIcon == AppIcons.transferfunds
                                  ? 2
                                  : 3,
                  bottom: 3,
                  end: settingIcon == AppIcons.logout
                      ? 0
                      : settingIcon == AppIcons.changerepresentative
                          ? 6
                          : settingIcon == AppIcons.backupseed
                              ? 5
                              : settingIcon == AppIcons.transferfunds
                                  ? 4
                                  : 3,
                ),
              ),
            ),
            Container(
              width: UIUtil.drawerWidth(context) - 100,
              child: Text(
                heading,
                style: AppStyles.textStyleSettingItemHeader(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
  static Widget buildSettingsListItemSingleLineWithInfos(
      BuildContext context, String heading, String info, IconData settingIcon,
      {Function onPressed}) {
    return FlatButton(
      highlightColor: StateContainer.of(context).curTheme.text15,
      splashColor: StateContainer.of(context).curTheme.text15,
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        } else {
          return;
        }
      },
      padding: EdgeInsets.all(0.0),
      child: Container(
        height: 100.0,
        margin: EdgeInsetsDirectional.only(start: 30.0),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsetsDirectional.only(end: 13.0),
              child: Container(
                child: Icon(
                  settingIcon,
                  color: StateContainer.of(context).curTheme.icon,
                  size: 24,
                ),
                margin: EdgeInsetsDirectional.only(
                  top: 3,
                  start: 3,
                  bottom: 3,
                  end: 3,
                ),
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: UIUtil.drawerWidth(context) - 100,
                    child: Text(
                      heading,
                      style: AppStyles.textStyleSettingItemHeader(context),
                    ),
                  ),
                  Container(
                    width: UIUtil.drawerWidth(context) - 100,
                    child: AutoSizeText(
                      info,
                      maxLines: 5,
                      stepGranularity: 0.1,
                      minFontSize: 8,
                      style: AppStyles.textStyleSettingItemSubheader(context),
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }

  static Widget buildSettingsListItemSwitch(BuildContext context,
      String heading, IconData settingIcon, bool _isSwitched,
      {Function onChanged}) {
    return FlatButton(
      highlightColor: StateContainer.of(context).curTheme.text15,
      splashColor: StateContainer.of(context).curTheme.text15,
      onPressed: () {},
      padding: EdgeInsets.all(0.0),
      child: Container(
        height: 60.0,
        margin: EdgeInsetsDirectional.only(start: 30.0),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsetsDirectional.only(end: 13.0),
              child: Container(
                child: Icon(
                  settingIcon,
                  color: StateContainer.of(context).curTheme.icon,
                  size: 24,
                ),
                margin: EdgeInsetsDirectional.only(
                  top: 3,
                  start: 3,
                  bottom: 3,
                  end: 3,
                ),
              ),
            ),
            Container(
                width: UIUtil.drawerWidth(context) - 100,
                child: Row(
                  children: [
                    Text(
                      heading,
                      style: AppStyles.textStyleSettingItemHeader(context),
                    ),
                    Switch(
                        value: _isSwitched == null ? false : _isSwitched,
                        onChanged: (value) {
                          if (onChanged != null) {
                            _isSwitched = value;
                            onChanged(_isSwitched);
                          } else {
                            return;
                          }
                        },
                        activeTrackColor: StateContainer.of(context)
                            .curTheme
                            .backgroundDarkest,
                        activeColor: Colors.green),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
