import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_idena/backoffice/bean/bcn_transactions_response.dart';
import 'package:my_idena/backoffice/factory/httpService.dart';
import 'package:my_idena/main.dart';

import 'package:my_idena/myIdena_app/myIdena_app_theme.dart';
import 'package:my_idena/utils/app_localizations.dart';

HttpService httpService = HttpService();

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
                  future: httpService.getTransactions(
                      idenaAddress,
                      nbTransactions),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                    BcnTransactionsResponse bcnTransactionsResponse =
                        snapshot.data;
                    if (bcnTransactionsResponse.result.transactions == null) {
                      bcnTransactionsResponse.result.transactions = new List(0);
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
                                      top: 0, left: 0, right: 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, bottom: 8, top: 14),
                                        child: transactions.length == 0
                                            ? Text(
                                                AppLocalizations.of(context)
                                                    .translate(
                                                        "No transaction"),
                                                style: TextStyle(
                                                    fontFamily: MyIdenaAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    letterSpacing: -0.1,
                                                    color: MyIdenaAppTheme
                                                        .darkText),
                                              )
                                            : Row(
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(context)
                                                        .translate("Last"),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            MyIdenaAppTheme
                                                                .fontName,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                        letterSpacing: -0.1,
                                                        color: MyIdenaAppTheme
                                                            .darkText),
                                                  ),
                                                  Text(
                                                    transactions.length
                                                            .toString() +
                                                        " ",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            MyIdenaAppTheme
                                                                .fontName,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                        letterSpacing: -0.1,
                                                        color: MyIdenaAppTheme
                                                            .darkText),
                                                  ),
                                                  Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                            "transactions"),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            MyIdenaAppTheme
                                                                .fontName,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                        letterSpacing: -0.1,
                                                        color: MyIdenaAppTheme
                                                            .darkText),
                                                  ),
                                                ],
                                              ),
                                      ),
                                      transactions.length == 0
                                          ? SizedBox(width: 1)
                                          : Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5,
                                                            right: 5,
                                                            top: 0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        new Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: 440,
                                                          child:
                                                              ListView.builder(
                                                                  physics:
                                                                      BouncingScrollPhysics(),
                                                                  itemCount:
                                                                      transactions
                                                                          .length,
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

  Widget getImageTo(Transaction transaction) {
    if (transaction.from != null &&
        transaction.from != idenaAddress) {
      return Column(children: [
        SizedBox(
          height: 10,
        ),
        Image.network(
          'https://robohash.org/${transaction.from}',
          width: 60,
          height: 60,
        ),
        SizedBox(
          height: 10,
        )
      ]);
    } else {
      return SizedBox(width: 60, height: 80);
    }
  }

  Widget getFees(Transaction transaction) {
    if (double.parse(transaction.usedFee) > 0) {
      return Text(
        transaction.usedFee == null
            ? ""
            : AppLocalizations.of(context).translate("Fees: ") +
                double.parse(transaction.usedFee).toStringAsFixed(10) +
                " iDNA",
        style: TextStyle(
          fontFamily: MyIdenaAppTheme.fontName,
          fontWeight: FontWeight.w600,
          fontSize: 16,
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
          transaction.from != idenaAddress) {
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
            fontSize: 16,
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
            fontSize: 16,
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
        transaction.from != idenaAddress) {
      return new Image.asset(
        'assets/images/Download-256.png',
        height: 32,
      );
    } else {
      return new Image.asset(
        'assets/images/upload_64x64.png',
        height: 32,
      );
    }
  }

  Widget getFrom(Transaction transaction) {
    if (transaction.from != null &&
        transaction.from != idenaAddress) {
      return Text(
        AppLocalizations.of(context).translate("From: ") +
            transaction.from.substring(0, 15) +
            "...",
        style: TextStyle(
          fontFamily: MyIdenaAppTheme.fontName,
          fontWeight: FontWeight.w600,
          fontSize: 16,
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
          child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: new Card(
                  elevation: 5.0,
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
                              DateFormat.yMEd(Localizations.localeOf(context)
                                      .languageCode)
                                  .add_Hm()
                                  .format(DateTime.fromMillisecondsSinceEpoch(
                                          transaction.timestamp * 1000)
                                      .toLocal())
                                  .toString(),
                              style: TextStyle(
                                fontFamily: MyIdenaAppTheme.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: MyIdenaAppTheme.darkText,
                              ),
                            ),
                          ]),
                      new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                              height: 0,
                            ),
                            getImageTo(transaction),
                            new Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                    color: Colors.green, size: 20.0),
                                SizedBox(
                                  width: 5,
                                  height: 10,
                                ),
                                Text(
                                  transaction.hash == null
                                      ? ""
                                      : AppLocalizations.of(context).translate(
                                              "Blockchain trans. ID: ") +
                                          transaction.hash.substring(0, 15) +
                                          "...",
                                  style: TextStyle(
                                    fontFamily: MyIdenaAppTheme.fontName,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: MyIdenaAppTheme.darkText,
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ],
                  ))));
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
          transaction.from != idenaAddress) {
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
      "   " + AppLocalizations.of(context).translate(text),
      style: TextStyle(
        fontFamily: MyIdenaAppTheme.fontName,
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: MyIdenaAppTheme.darkText,
      ),
    );
  }
}
