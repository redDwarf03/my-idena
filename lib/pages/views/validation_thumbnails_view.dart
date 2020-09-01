import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';

class ValidationThumbnailsView extends StatefulWidget {
  final List<Widget> iconList;
  final List<int> selectedIconList;
  final int nbFlips;

  const ValidationThumbnailsView(
      {Key key, this.iconList, this.nbFlips, this.selectedIconList})
      : super(key: key);

  @override
  _ValidationThumbnailsViewState createState() =>
      _ValidationThumbnailsViewState();
}

class _ValidationThumbnailsViewState extends State<ValidationThumbnailsView> {
  Widget build(BuildContext context) {
    widget.iconList.clear();
    if (widget.selectedIconList == null ||
        widget.selectedIconList.length == 0) {
      return Column(
        children: widget.iconList,
      );
    }
    for (int i = 0; i < widget.nbFlips; i++) {
      Widget icon;
      switch (widget.selectedIconList[i]) {
        case 1:
          {
            icon = Icon(
              FlevaIcons.checkmark_square_2_outline,
              color: Colors.green,
              size: 22,
            );
            break;
          }
        case 2:
          {
            icon = Icon(
              FlevaIcons.checkmark_square,
              color: Colors.blue,
              size: 22,
            );
            break;
          }
        case 3:
          {
            icon = Icon(
              FlevaIcons.close_square_outline,
              color: Colors.red,
              size: 22,
            );
            break;
          }
        default:
          {
            icon = Icon(
              FlevaIcons.copy_outline,
              color: Colors.grey[500],
              size: 22,
            );
            break;
          }
      }
      widget.iconList.add(icon);
    }

    return Column(
      children: widget.iconList,
    );
  }
}
