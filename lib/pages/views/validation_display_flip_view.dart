import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/factory/validation_session_infos.dart';
import 'package:my_idena/enums/answer_type.dart' as AnswerType;

class ValidationDisplayFlipView extends StatefulWidget {
  final int index;
  final ValidationSessionInfoFlips validationSessionInfoFlips;
  final Function(ValidationSessionInfoFlips) onSelectFlip;

  const ValidationDisplayFlipView({
    Key key,
    this.index,
    this.validationSessionInfoFlips,
    this.onSelectFlip,
  }) : super(key: key);

  @override
  _ValidationDisplayFlipViewState createState() =>
      _ValidationDisplayFlipViewState();
}

class _ValidationDisplayFlipViewState extends State<ValidationDisplayFlipView> {
  Widget build(BuildContext context) {
    ValidationSessionInfoFlips _validationSessionInfoFlips =
        widget.validationSessionInfoFlips;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              height: ((((MediaQuery.of(context).size.width) - 72) ~/ 2) /
                      (4 / 3) *
                      4)
                  .toDouble(),
              decoration: widget.validationSessionInfoFlips.answerType ==
                      AnswerType.LEFT
                  ? new BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10.0),
                      border: new Border.all(color: Colors.green, width: 5))
                  : new BoxDecoration(
                      border: new Border.all(
                          color: Color.fromRGBO(255, 255, 255, 0), width: 5)),
              child: GestureDetector(
                onTap: () {
                  if (_validationSessionInfoFlips.answerType !=
                      AnswerType.LEFT) {
                    setState(() {
                      _validationSessionInfoFlips.answerType = AnswerType.LEFT;
                    });
                    widget.onSelectFlip(_validationSessionInfoFlips);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                        image: ResizeImage(
                            MemoryImage(widget
                                .validationSessionInfoFlips.listImagesLeft[0]),
                            width:
                                (((MediaQuery.of(context).size.width) - 82) ~/
                                        2)
                                    .toInt())),
                    Image(
                        image: ResizeImage(
                            MemoryImage(widget
                                .validationSessionInfoFlips.listImagesLeft[1]),
                            width:
                                (((MediaQuery.of(context).size.width) - 82) ~/
                                        2)
                                    .toInt())),
                    Image(
                        image: ResizeImage(
                            MemoryImage(widget
                                .validationSessionInfoFlips.listImagesLeft[2]),
                            width:
                                (((MediaQuery.of(context).size.width) - 82) ~/
                                        2)
                                    .toInt())),
                    Image(
                        image: ResizeImage(
                            MemoryImage(widget
                                .validationSessionInfoFlips.listImagesLeft[3]),
                            width:
                                (((MediaQuery.of(context).size.width) - 82) ~/
                                        2)
                                    .toInt())),
                  ],
                ),
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Container(
            height: ((((MediaQuery.of(context).size.width) - 72) ~/ 2) /
                    (4 / 3) *
                    4)
                .toDouble(),
            decoration:
                widget.validationSessionInfoFlips.answerType == AnswerType.RIGHT
                    ? new BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10.0),
                        border: new Border.all(color: Colors.green, width: 5))
                    : new BoxDecoration(
                        border: new Border.all(
                            color: Color.fromRGBO(255, 255, 255, 0), width: 5)),
            child: GestureDetector(
              onTap: () {
                if (_validationSessionInfoFlips.answerType !=
                    AnswerType.RIGHT) {
                  setState(() {
                    _validationSessionInfoFlips.answerType = AnswerType.RIGHT;
                  });
                  widget.onSelectFlip(_validationSessionInfoFlips);
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                      image: ResizeImage(
                          MemoryImage(widget
                              .validationSessionInfoFlips.listImagesRight[0]),
                          width:
                              (((MediaQuery.of(context).size.width) - 82) ~/ 2)
                                  .toInt())),
                  Image(
                      image: ResizeImage(
                          MemoryImage(widget
                              .validationSessionInfoFlips.listImagesRight[1]),
                          width:
                              (((MediaQuery.of(context).size.width) - 82) ~/ 2)
                                  .toInt())),
                  Image(
                      image: ResizeImage(
                          MemoryImage(widget
                              .validationSessionInfoFlips.listImagesRight[2]),
                          width:
                              (((MediaQuery.of(context).size.width) - 82) ~/ 2)
                                  .toInt())),
                  Image(
                      image: ResizeImage(
                          MemoryImage(widget
                              .validationSessionInfoFlips.listImagesRight[3]),
                          width:
                              (((MediaQuery.of(context).size.width) - 82) ~/ 2)
                                  .toInt())),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
