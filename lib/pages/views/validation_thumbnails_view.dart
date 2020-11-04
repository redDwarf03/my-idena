import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:my_idena/beans/validation_item.dart';
import 'package:my_idena/enums/relevance_type.dart' as RelevantType;
import 'package:my_idena/enums/answer_type.dart' as AnswerType;

class ValidationThumbnailsView extends StatefulWidget {
  final List<ValidationItem> validationItemList;

  const ValidationThumbnailsView({Key key, this.validationItemList}) : super(key: key);

  @override
  _ValidationThumbnailsViewState createState() => _ValidationThumbnailsViewState();
}

class _ValidationThumbnailsViewState extends State<ValidationThumbnailsView> {
  Widget build(BuildContext context) {
    List<Widget> iconList = new List();

    if (widget.validationItemList == null || widget.validationItemList.length == 0) {
      return Column(
        children: iconList,
      );
    }

    for (int i = 0; i < widget.validationItemList.length; i++) {
      Widget icon = Icon(
        FlevaIcons.copy_outline,
        color: Colors.grey[500],
        size: 22,
      );

      if (widget.validationItemList[i].relevanceType == RelevantType.RELEVANT) {
        icon = Icon(
          FlevaIcons.checkmark_square,
          color: Colors.blue,
          size: 22,
        );
      } else {
        if (widget.validationItemList[i].relevanceType == RelevantType.IRRELEVANT) {
          icon = Icon(
            FlevaIcons.close_square_outline,
            color: Colors.red,
            size: 22,
          );
        } else {
          if (widget.validationItemList[i].answerType == AnswerType.LEFT || widget.validationItemList[i].answerType == AnswerType.RIGHT) {
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
      children: iconList,
    );
  }
}
