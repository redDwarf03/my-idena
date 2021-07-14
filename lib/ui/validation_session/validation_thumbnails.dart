// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';

// Package imports:
import 'package:idena_lib_dart/enums/answer_type.dart' as AnswerType;
import 'package:idena_lib_dart/enums/relevance_type.dart' as RelevantType;
import 'package:idena_lib_dart/model/validation_session_infos.dart';

class ValidationThumbnails extends StatefulWidget {
  final List<ValidationSessionInfoFlips> listSessionValidationFlip;

  const ValidationThumbnails({Key key, this.listSessionValidationFlip}) : super(key: key);

  @override
  _ValidationThumbnailsState createState() => _ValidationThumbnailsState();
}

class _ValidationThumbnailsState extends State<ValidationThumbnails> {

  Widget build(BuildContext context) {
    List<Widget> iconList = new List();

    if (widget.listSessionValidationFlip == null || widget.listSessionValidationFlip.length == 0) {
      return Column(
        children: iconList,
      );
    }

    for (int i = 0; i < widget.listSessionValidationFlip.length; i++) {
      Widget icon = Icon(
        Icons.content_copy,
        color: Colors.grey[500],
        size: 18,
      );

      if (widget.listSessionValidationFlip[i].relevanceType == RelevantType.RELEVANT) {
        icon = Icon(
          FontAwesome.check,
          color: Colors.blue,
          size: 18,
        );
      } else {
        if (widget.listSessionValidationFlip[i].relevanceType == RelevantType.IRRELEVANT) {
          icon = Icon(
            FontAwesome.check,
            color: Colors.red,
            size: 18,
          );
        } else {
          if (widget.listSessionValidationFlip[i].answerType == AnswerType.LEFT || widget.listSessionValidationFlip[i].answerType == AnswerType.RIGHT) {
            icon = Icon(
              FontAwesome.check,
              color: Colors.green,
              size: 18,
            );
          }
        }
      }

      iconList.add(icon);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: iconList,
    );
  }
}
