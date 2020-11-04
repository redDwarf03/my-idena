import 'package:flutter/material.dart';
import 'package:my_idena/backoffice/factory/validation_session_infos.dart';
import 'package:my_idena/beans/validation_item.dart';
import 'package:my_idena/enums/answer_type.dart' as AnswerType;

class ValidationDisplayFlipView extends StatefulWidget {
  final ValidationItem validationItem;
  final ValidationSessionInfoFlips validationSessionInfoFlips;
  final Function(ValidationItem) onSelectFlip;

  const ValidationDisplayFlipView({
    Key key,
    @required this.validationItem,
    @required this.validationSessionInfoFlips,
    this.onSelectFlip,
  }) : super(key: key);

  @override
  _ValidationDisplayFlipViewState createState() => _ValidationDisplayFlipViewState();
}

class _ValidationDisplayFlipViewState extends State<ValidationDisplayFlipView> {
  ValidationItem _validationItem;

  Widget build(BuildContext context) {
    if (_validationItem == null) _validationItem = widget.validationItem;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: ((MediaQuery.of(context).size.height - 340)).toDouble(),
          decoration: _validationItem.answerType == AnswerType.LEFT
              ? new BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(10.0), border: new Border.all(color: Colors.green, width: 5))
              : new BoxDecoration(border: new Border.all(color: Color.fromRGBO(255, 255, 255, 0), width: 5)),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _validationItem.answerType = AnswerType.LEFT;
              });
              widget.onSelectFlip(_validationItem);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                    image: ResizeImage(MemoryImage(widget.validationSessionInfoFlips.listImagesLeft[0]),
                        width: (((MediaQuery.of(context).size.width) - 82) ~/ 2).toInt())),
                Image(
                    image: ResizeImage(MemoryImage(widget.validationSessionInfoFlips.listImagesLeft[1]),
                        width: (((MediaQuery.of(context).size.width) - 82) ~/ 2).toInt())),
                Image(
                    image: ResizeImage(MemoryImage(widget.validationSessionInfoFlips.listImagesLeft[2]),
                        width: (((MediaQuery.of(context).size.width) - 82) ~/ 2).toInt())),
                Image(
                    image: ResizeImage(MemoryImage(widget.validationSessionInfoFlips.listImagesLeft[3]),
                        width: (((MediaQuery.of(context).size.width) - 82) ~/ 2).toInt())),
              ],
            ),
          ),
        ),
        Container(
          height: ((MediaQuery.of(context).size.height - 340)).toDouble(),
          decoration: _validationItem.answerType == AnswerType.RIGHT
              ? new BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(10.0), border: new Border.all(color: Colors.green, width: 5))
              : new BoxDecoration(border: new Border.all(color: Color.fromRGBO(255, 255, 255, 0), width: 5)),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _validationItem.answerType = AnswerType.RIGHT;
              });
              widget.onSelectFlip(_validationItem);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                    image: ResizeImage(MemoryImage(widget.validationSessionInfoFlips.listImagesRight[0]),
                        width: (((MediaQuery.of(context).size.width) - 82) ~/ 2).toInt())),
                Image(
                    image: ResizeImage(MemoryImage(widget.validationSessionInfoFlips.listImagesRight[1]),
                        width: (((MediaQuery.of(context).size.width) - 82) ~/ 2).toInt())),
                Image(
                    image: ResizeImage(MemoryImage(widget.validationSessionInfoFlips.listImagesRight[2]),
                        width: (((MediaQuery.of(context).size.width) - 82) ~/ 2).toInt())),
                Image(
                    image: ResizeImage(MemoryImage(widget.validationSessionInfoFlips.listImagesRight[3]),
                        width: (((MediaQuery.of(context).size.width) - 82) ~/ 2).toInt())),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
