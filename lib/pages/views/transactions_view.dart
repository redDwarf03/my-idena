import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_idena/backoffice/bean/bcn_transactions_response.dart';
import 'package:my_idena/backoffice/bean/dna_all.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';

import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/utils/app_localizations.dart';

HttpService httpService = HttpService();
DnaAll dnaAll;

class TransactionsView extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;

  const TransactionsView({Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  _TransactionsViewState createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView> {
  int nbTransactions = 30;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: httpService.getDnaAll(),
        builder: (BuildContext context, AsyncSnapshot<DnaAll> snapshot) {
          if (snapshot.hasData) {
            dnaAll = snapshot.data;
            if (dnaAll == null || dnaAll.dnaIdentityResponse == null) {
              return Text("");
            } else {
              return FutureBuilder(
                  future: httpService.getTransactions(
                      dnaAll.dnaIdentityResponse.result.address,
                      nbTransactions),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Container();
                    BcnTransactionsResponse bcnTransactionsResponse =
                        snapshot.data;
                    if (bcnTransactionsResponse.result.transactions == null) {
                      return Container();
                    }
                    List<Transaction> transactions =
                        bcnTransactionsResponse.result.transactions;
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
                                    color:
                                        MyIdenaAppTheme.grey.withOpacity(0.2),
                                    offset: Offset(1.1, 1.1),
                                    blurRadius: 10.0),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 16, right: 24),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, bottom: 8, top: 16),
                                        child: Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate("Last"),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily:
                                                      MyIdenaAppTheme.fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  letterSpacing: -0.1,
                                                  color:
                                                      MyIdenaAppTheme.darkText),
                                            ),
                                            Text(
                                              " " +
                                                  transactions.length.toString() +
                                                  " ",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily:
                                                      MyIdenaAppTheme.fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  letterSpacing: -0.1,
                                                  color:
                                                      MyIdenaAppTheme.darkText),
                                            ),
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate("transactions"),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily:
                                                      MyIdenaAppTheme.fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  letterSpacing: -0.1,
                                                  color:
                                                      MyIdenaAppTheme.darkText),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0, right: 0, top: 4),
                                              child: Column(
                                                children: <Widget>[
                                                  new Container(
                                                    height: 440,
                                                    child: ListView.builder(
                                                        physics:
                                                            BouncingScrollPhysics(),
                                                        itemCount:
                                                            transactions.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          Transaction
                                                              transaction =
                                                              transactions[
                                                                  index];
                                                          return getTransactionDisplay(
                                                              transaction);
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
                  });
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget getImageTo(Transaction transaction) {
    if (transaction.from != null &&
        transaction.from != dnaAll.dnaIdentityResponse.result.address) {
      return Image.network(
        'https://robohash.org/${transaction.from}',
        width: 30,
        height: 30,
      );
    } else {
      return SizedBox(width: 30, height: 0);
    }
  }

  Widget getFees(Transaction transaction) {
    if (double.parse(transaction.usedFee) > 0) {
      return Text(
        transaction.usedFee == null
            ? ""
            : AppLocalizations.of(context).translate("Fees: ") +
                transaction.usedFee +
                " iDNA",
        style: TextStyle(
          fontFamily: MyIdenaAppTheme.fontName,
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: MyIdenaAppTheme.darkText,
        ),
      );
    } else {
      return SizedBox(width: 0, height: 0);
    }
  }

  Widget getAmount(Transaction transaction) {
    if (double.parse(transaction.amount) > 0) {
      if (transaction.from != null &&
          transaction.from != dnaAll.dnaIdentityResponse.result.address) {
        return Text(
          transaction.amount == null
              ? ""
              : AppLocalizations.of(context).translate("Amount: ") +
                  "+" +
                  transaction.amount +
                  " iDNA",
          style: TextStyle(
            fontFamily: MyIdenaAppTheme.fontName,
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: MyIdenaAppTheme.darkText,
          ),
        );
      } else {
        return Text(
          transaction.amount == null
              ? ""
              : AppLocalizations.of(context).translate("Amount: ") +
                  "-" +
                  transaction.amount +
                  " iDNA",
          style: TextStyle(
            fontFamily: MyIdenaAppTheme.fontName,
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: MyIdenaAppTheme.darkText,
          ),
        );
      }
    } else {
      return SizedBox(width: 0, height: 0);
    }
  }

  Widget getDirection(Transaction transaction) {
    if (transaction.from != null &&
        transaction.from != dnaAll.dnaIdentityResponse.result.address) {
      return new Icon(Icons.vertical_align_bottom,
          color: Colors.blue[600], size: 22.0);
    } else {
      return new Icon(Icons.vertical_align_top,
          color: Colors.red[600], size: 22.0);
    }
  }

  Widget getFrom(Transaction transaction) {
    if (transaction.from != null &&
        transaction.from != dnaAll.dnaIdentityResponse.result.address) {
      return Text(
        AppLocalizations.of(context).translate("From: ") +
            transaction.from.substring(0, 15) +
            "...",
        style: TextStyle(
          fontFamily: MyIdenaAppTheme.fontName,
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: MyIdenaAppTheme.darkText,
        ),
      );
    } else {
      return SizedBox(width: 0, height: 0);
    }
  }

  Widget getTransactionDisplay(Transaction transaction) {
    var typeAccepted = [
      "send",
      "activation",
      "invite",
      "killInvitee",
      "kill",
      "submitFlip",
      "online",
    ];
    if (typeAccepted.contains(transaction.type)) {
      return Container(
          child: new Card(
              child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    Row(
                      children: [
                        getDirection(transaction),
                        getTransactionType(transaction),
                      ],
                    ),
                  ],
                ),
                Text(
                  DateFormat.yMEd(Localizations.localeOf(context).languageCode)
                      .add_Hm()
                      .format(DateTime.fromMillisecondsSinceEpoch(
                              transaction.timestamp * 1000)
                          .toLocal())
                      .toString(),
                  style: TextStyle(
                    fontFamily: MyIdenaAppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: MyIdenaAppTheme.darkText,
                  ),
                ),
              ]),
          new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 30,
                  height: 0,
                ),
                getImageTo(transaction),
                new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      getFrom(transaction),
                      getAmount(transaction),
                      getFees(transaction),
                    ]),
              ]),
          Column(
            children: [
              new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Icon(Icons.check_circle_outline,
                        color: Colors.green, size: 15.0),
                    SizedBox(
                      width: 5,
                      height: 10,
                    ),
                    Text(
                      transaction.hash == null
                          ? ""
                          : AppLocalizations.of(context)
                                  .translate("Blockchain transaction ID: ") +
                              transaction.hash.substring(0, 15) +
                              "...",
                      style: TextStyle(
                        fontFamily: MyIdenaAppTheme.fontName,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: MyIdenaAppTheme.darkText,
                      ),
                    ),
                  ]),
            ],
          ),
        ],
      )));
    } else {
      return Container(width: 0, height: 0);
    }
  }

  Widget getTransactionType(Transaction transaction) {
    String type = transaction.type;
    String payload = transaction.payload;
    String text;
    if (type == 'send') {
      if (transaction.from != null &&
          transaction.from != dnaAll.dnaIdentityResponse.result.address) {
        text = "Received";
      } else {
        text = "Sent";
      }
    } else {
      if (type == 'activation') {
        text = "Invitation activated";
      } else {
        if (type == 'invite') {
          text = "Invitation issued";
        } else {
          if (type == 'killInvitee') {
            text = "Invitation terminated";
          } else {
            if (type == 'kill') {
              text = "Identity terminated";
            } else {
              if (type == 'submitFlip') {
                text = "Flip submitted";
              } else {
                if (type == 'online') {
                  if (payload == '0x') {
                    text = "Mining status Off";
                  } else {
                    text = "Mining status On";
                  }
                }
              }
            }
          }
        }
      }
    }
    if (text == null) {
      text = "Transaction type unknown";
    }
    return Text(
      AppLocalizations.of(context).translate(text),
      style: TextStyle(
        fontFamily: MyIdenaAppTheme.fontName,
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: MyIdenaAppTheme.darkText,
      ),
    );
  }
}
