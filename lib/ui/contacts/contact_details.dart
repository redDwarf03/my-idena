// @dart=2.9

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:idena_lib_dart/enums/identity_status.dart' as IdentityStatus;
import 'package:idena_lib_dart/factory/app_service.dart';
import 'package:idena_lib_dart/model/response/dna_identity_response.dart';
import 'package:idena_lib_dart/model/response/dna_send_invite_response.dart';

// Project imports:
import 'package:my_idena/app_icons.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/bus/events.dart';
import 'package:my_idena/dimens.dart';
import 'package:my_idena/localization.dart';
import 'package:my_idena/model/db/appdb.dart';
import 'package:my_idena/model/db/contact.dart';
import 'package:my_idena/service_locator.dart';
import 'package:my_idena/styles.dart';
import 'package:my_idena/ui/util/ui_util.dart';
import 'package:my_idena/ui/widgets/buttons.dart';
import 'package:my_idena/ui/widgets/dialog.dart';
import 'package:my_idena/ui/widgets/sheets.dart';
import 'package:my_idena/util/caseconverter.dart';
import 'package:my_idena/util/util_node.dart';

// Contact Details Sheet
class ContactDetailsSheet {
  Contact contact;
  String documentsDirectory;
  int nbInvites;
  int nodeType;

  ContactDetailsSheet(this.contact, this.documentsDirectory, this.nbInvites, this.nodeType);

  // State variables
  bool _addressCopied = false;
  // Timer reference so we can cancel repeated events
  Timer _addressCopiedTimer;

  mainBottomSheet(BuildContext context) {
    AppSheets.showAppHeightEightSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            getStatus();
            return SafeArea(
                minimum: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.035),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        contact.address ==
                                AppLocalization.of(context).donationsUrl
                            ? SizedBox()
                            :
                            // Trashcan Button
                            Container(
                                width: 50,
                                height: 50,
                                margin: EdgeInsetsDirectional.only(
                                    top: 10.0, start: 10.0),
                                child: FlatButton(
                                  highlightColor: StateContainer.of(context)
                                      .curTheme
                                      .text15,
                                  splashColor: StateContainer.of(context)
                                      .curTheme
                                      .text15,
                                  onPressed: () {
                                    AppDialogs.showConfirmDialog(
                                        context,
                                        AppLocalization.of(context)
                                            .removeContact,
                                        AppLocalization.of(context)
                                            .removeContactConfirmation
                                            .replaceAll('%1', contact.name),
                                        CaseChange.toUpperCase(
                                            AppLocalization.of(context).yes,
                                            context), () {
                                      sl
                                          .get<DBHelper>()
                                          .deleteContact(contact)
                                          .then((deleted) {
                                        if (deleted) {
                                          EventTaxiImpl.singleton().fire(
                                              ContactRemovedEvent(
                                                  contact: contact));
                                          EventTaxiImpl.singleton().fire(
                                              ContactModifiedEvent(
                                                  contact: contact));
                                          UIUtil.showSnackbar(
                                              AppLocalization.of(context)
                                                  .contactRemoved
                                                  .replaceAll(
                                                      "%1", contact.name),
                                              context);
                                          Navigator.of(context).pop();
                                        } else {
                                          // TODO - error for failing to delete contact
                                        }
                                      });
                                    },
                                        cancelText: CaseChange.toUpperCase(
                                            AppLocalization.of(context).no,
                                            context));
                                  },
                                  child: Icon(AppIcons.trashcan,
                                      size: 24,
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .text),
                                  padding: EdgeInsets.all(13.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.0)),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.padded,
                                ),
                              ),
                        // The header of the sheet
                        Container(
                          margin: EdgeInsets.only(top: 25.0),
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width - 140),
                          child: Column(
                            children: <Widget>[
                              AutoSizeText(
                                CaseChange.toUpperCase(
                                    AppLocalization.of(context).contactHeader,
                                    context),
                                style: AppStyles.textStyleHeader(context),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                stepGranularity: 0.1,
                              ),
                            ],
                          ),
                        ),
                        // Search Button
                        Container(
                          width: 50,
                          height: 50,
                          margin:
                              EdgeInsetsDirectional.only(top: 10.0, end: 10.0),
                          child: FlatButton(
                            highlightColor:
                                StateContainer.of(context).curTheme.text15,
                            splashColor:
                                StateContainer.of(context).curTheme.text15,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return UIUtil.showAccountWebview(
                                    context, contact.address);
                              }));
                            },
                            child: Icon(AppIcons.search,
                                size: 24,
                                color:
                                    StateContainer.of(context).curTheme.text),
                            padding: EdgeInsets.all(13.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0)),
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                          ),
                        ),
                      ],
                    ),

                    // The main container that holds Contact Name and Contact Address
                    Expanded(
                      child: Container(
                        padding: EdgeInsetsDirectional.only(top: 4, bottom: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 128.0,
                              height: 128.0,
                              child: CircleAvatar(
                                backgroundColor:
                                    StateContainer.of(context).curTheme.text05,
                                backgroundImage: contact.status ==
                                        IdentityStatus.NonExistentAddress
                                    ? UIUtil.getRobohashURL(null)
                                    : UIUtil.getRobohashURL(contact.address),
                                radius: 50.0,
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                contact.online != null
                                    ? contact.online
                                        ? Icon(
                                            Icons.signal_cellular_alt_rounded,
                                            color: Colors.green,
                                            size: 18)
                                        : Icon(
                                            Icons.signal_cellular_alt_rounded,
                                            color: Colors.red,
                                            size: 18)
                                    : Icon(Icons.signal_cellular_alt_rounded,
                                        color: Colors.grey, size: 18),
                                SizedBox(width: 10),
                                contact.status != null
                                    ? Text(contact.status,
                                        style: AppStyles
                                            .textStyleTransactionAddress(
                                                context))
                                    : Text(IdentityStatus.Undefined,
                                        style: AppStyles
                                            .textStyleTransactionAddress(
                                                context)),
                              ],
                            ),
                            // Contact Name container
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.105,
                                right:
                                    MediaQuery.of(context).size.width * 0.105,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 12.0),
                              decoration: BoxDecoration(
                                color: StateContainer.of(context)
                                    .curTheme
                                    .backgroundDarkest,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Text(
                                contact.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .primary,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ),
                            // Contact Address
                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                    new ClipboardData(text: contact.address));
                                setState(() {
                                  _addressCopied = true;
                                });
                                if (_addressCopiedTimer != null) {
                                  _addressCopiedTimer.cancel();
                                }
                                _addressCopiedTimer = new Timer(
                                    const Duration(milliseconds: 800), () {
                                  setState(() {
                                    _addressCopied = false;
                                  });
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.105,
                                    right: MediaQuery.of(context).size.width *
                                        0.105,
                                    top: 15),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25.0, vertical: 15.0),
                                decoration: BoxDecoration(
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .backgroundDarkest,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: UIUtil.threeLineAddressText(
                                    context, contact.address,
                                    type: _addressCopied
                                        ? ThreeLineAddressTextType.SUCCESS_FULL
                                        : ThreeLineAddressTextType.PRIMARY),
                              ),
                            ),
                            // Address Copied text container
                            Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                  _addressCopied
                                      ? AppLocalization.of(context)
                                          .addressCopied
                                      : "",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .success,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              nbInvites > 0 && nodeType != PUBLIC_NODE && nodeType != SHARED_NODE ?
                              AppButton.buildAppButton(
                                  context,
                                  AppButtonType.PRIMARY_OUTLINE,
                                  AppLocalization.of(context).sendInvite,
                                  Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                                AppDialogs.showConfirmDialog(
                                    context,
                                    AppLocalization.of(context)
                                        .sendInviteConfirmationHeader,
                                    AppLocalization.of(context)
                                        .sendInviteConfirmationInfos,
                                    CaseChange.toUpperCase(
                                        AppLocalization.of(context).yesButton,
                                        context), () async {
                                  DnaSendInviteResponse dnaSendInviteResponse =
                                      await sl.get<AppService>().sendInvitation(
                                          contact.address, "0", 0, 0);
                                  if (dnaSendInviteResponse == null) {
                                    UIUtil.showSnackbar(
                                        AppLocalization.of(context).sendError,
                                        context);
                                  } else {
                                    if (dnaSendInviteResponse.error != null) {
                                      UIUtil.showSnackbar(
                                          AppLocalization.of(context)
                                                  .sendError +
                                              " (" +
                                              dnaSendInviteResponse
                                                  .error.message +
                                              ")",
                                          context);
                                    } else {
                                      UIUtil.showSnackbar(
                                          AppLocalization.of(context)
                                              .sendInviteSuccess,
                                          context);
                                    }
                                  }
                                  Navigator.pop(context);
                                });
                              }) : SizedBox(),
                              // Close Button
                              AppButton.buildAppButton(
                                  context,
                                  AppButtonType.PRIMARY_OUTLINE,
                                  AppLocalization.of(context).close,
                                  Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                                Navigator.pop(context);
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ));
          });
        });
  }

  Future<void> getStatus() async {
    DnaIdentityResponse dnaIdentityResponse = new DnaIdentityResponse();
    dnaIdentityResponse =
        await sl.get<AppService>().getDnaIdentity(contact.address);
    if (dnaIdentityResponse != null && dnaIdentityResponse.error != null) {
      contact.online = null;
      contact.status = IdentityStatus.NonExistentAddress;
    } else {
      if (dnaIdentityResponse != null && dnaIdentityResponse.result != null) {
        contact.online = dnaIdentityResponse.result.online;
        contact.status = dnaIdentityResponse.result.state;
      } else {
        contact.online = false;
        contact.status = IdentityStatus.Undefined;
      }
    }
  }
}
