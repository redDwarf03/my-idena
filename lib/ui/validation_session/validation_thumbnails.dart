// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fleva_icons/fleva_icons.dart';
import 'package:idena_lib_dart/enums/answer_type.dart' as AnswerType;
import 'package:idena_lib_dart/enums/relevance_type.dart' as RelevantType;
import 'package:idena_lib_dart/model/validation_session_infos.dart';

class ValidationThumbnails extends StatefulWidget {
  final List<ValidationSessionInfoFlips> listSessionValidationFlip;

  const ValidationThumbnails({Key key, this.listSessionValidationFlip})
      : super(key: key);

  @override
  _ValidationThumbnailsState createState() => _ValidationThumbnailsState();
}

class _ValidationThumbnailsState extends State<ValidationThumbnails> {
  Widget build(BuildContext context) {
    List<Widget> iconList = new List();

    if (widget.listSessionValidationFlip == null ||
        widget.listSessionValidationFlip.length == 0) {
      return Column(
        children: iconList,
      );
    }

    for (int i = 0; i < widget.listSessionValidationFlip.length; i++) {
      Widget icon = Icon(
        FlevaIcons.copy_outline,
        color: Colors.grey[500],
        size: 22,
      );

      if (widget.listSessionValidationFlip[i].relevanceType ==
          RelevantType.RELEVANT) {
        icon = Icon(
          FlevaIcons.checkmark_square,
          color: Colors.blue,
          size: 22,
        );
      } else {
        if (widget.listSessionValidationFlip[i].relevanceType ==
            RelevantType.IRRELEVANT) {
          icon = Icon(
            FlevaIcons.close_square_outline,
            color: Colors.red,
            size: 22,
          );
        } else {
          if (widget.listSessionValidationFlip[i].answerType ==
                  AnswerType.LEFT ||
              widget.listSessionValidationFlip[i].answerType ==
                  AnswerType.RIGHT) {
            icon = Icon(
              FlevaIcons.checkmark_square_2_outline,
              color: Colors.green,
              size: 22,
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
