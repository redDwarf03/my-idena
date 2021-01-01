import 'package:flutter/material.dart';
import 'package:my_idena/appstate_container.dart';
import 'package:my_idena/network/model/validation_session_infos.dart';
import 'package:my_idena/service/validation_service.dart';
import 'package:my_idena/util/enums/answer_type.dart' as AnswerType;

class FlipDetail extends StatefulWidget {
  final ValidationSessionInfoFlips validationSessionInfoFlips;
  final Function(ValidationSessionInfoFlips) onSelectFlip;

  FlipDetail({this.validationSessionInfoFlips, this.onSelectFlip});

  _FlipDetailState createState() => _FlipDetailState();
}

class _FlipDetailState extends State<FlipDetail> {
  ValidationSessionInfoFlips _validationSessionInfoFlips;

  @override
  void initState() {
    super.initState();

    _validationSessionInfoFlips = widget.validationSessionInfoFlips;
    loadValidationSessionFlipDetail(false);
  }

  Future<void> loadValidationSessionFlipDetail(bool force) async {
    if (force ||
        (_validationSessionInfoFlips == null ||
            _validationSessionInfoFlips.listImagesLeft == null ||
            _validationSessionInfoFlips.listImagesLeft.length != 4 ||
            _validationSessionInfoFlips.listImagesRight == null ||
            _validationSessionInfoFlips.listImagesRight.length != 4)) {
      _validationSessionInfoFlips = await ValidationService()
          .getValidationSessionFlipDetail(_validationSessionInfoFlips, true);
      print("listImagesLeft length : " +
          _validationSessionInfoFlips.listImagesLeft.length.toString());
      setState(() {});
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.all(0.0),
      child: Column(children: <Widget>[
        Divider(
          height: 2,
          color: StateContainer.of(context).curTheme.text15,
        ),
        // Main Container
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          margin: new EdgeInsetsDirectional.only(start: 12.0, end: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  height:  (((((MediaQuery.of(context).size.width) - 72) ~/ 2) / (4 / 3) * 4) + 100)
                .toDouble(),
                  margin: EdgeInsetsDirectional.only(start: 2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _validationSessionInfoFlips.listImagesLeft == null
                              ? SizedBox()
                              : getFlipColumn(context, AnswerType.LEFT,
                                  _validationSessionInfoFlips),
                          _validationSessionInfoFlips.listImagesRight == null
                              ? SizedBox()
                              : getFlipColumn(context, AnswerType.RIGHT,
                                  _validationSessionInfoFlips),
                        ],
                      ),
                      Center(
                          child: IconButton(
                        icon: Icon(Icons.refresh),
                        color: StateContainer.of(context).curTheme.primary60,
                        onPressed: () {
                          loadValidationSessionFlipDetail(true);
                          setState(() {});
                        },
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget getFlipColumn(
      BuildContext context, int side, ValidationSessionInfoFlips flip) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        height:
            ((((MediaQuery.of(context).size.width) - 72) ~/ 2) / (4 / 3) * 4)
                .toDouble(),
        decoration: flip.answerType == side
            ? new BoxDecoration(
                color: Color(0xFF5890FF),
                borderRadius: BorderRadius.circular(10.0),
                border: new Border.all(color: Color(0xFF5890FF), width: 5))
            : new BoxDecoration(
                border: new Border.all(
                    color: Color.fromRGBO(255, 255, 255, 0), width: 5)),
        child: GestureDetector(
          onTap: () {
            if (flip.answerType != side) {
              setState(() {
                flip.answerType = side;
              });
              widget.onSelectFlip(flip);
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  image: ResizeImage(
                      MemoryImage(side == AnswerType.RIGHT
                          ? flip.listImagesRight[0]
                          : flip.listImagesLeft[0]),
                      width: (((MediaQuery.of(context).size.width) - 82) ~/ 2)
                          .toInt())),
              Image(
                  image: ResizeImage(
                      MemoryImage(side == AnswerType.RIGHT
                          ? flip.listImagesRight[1]
                          : flip.listImagesLeft[1]),
                      width: (((MediaQuery.of(context).size.width) - 82) ~/ 2)
                          .toInt())),
              Image(
                  image: ResizeImage(
                      MemoryImage(side == AnswerType.RIGHT
                          ? flip.listImagesRight[2]
                          : flip.listImagesLeft[2]),
                      width: (((MediaQuery.of(context).size.width) - 82) ~/ 2)
                          .toInt())),
              Image(
                  image: ResizeImage(
                      MemoryImage(side == AnswerType.RIGHT
                          ? flip.listImagesRight[3]
                          : flip.listImagesLeft[3]),
                      width: (((MediaQuery.of(context).size.width) - 82) ~/ 2)
                          .toInt())),
            ],
          ),
        ),
      ),
    );
  }
}
