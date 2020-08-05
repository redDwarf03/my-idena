import 'package:my_idena/constants/bottomNavigationBarMyIdena.dart';
import 'package:my_idena/utils/app_localizations.dart';
import 'package:my_idena/utils/util_img.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_idena/utils/orderable_stack.dart';

Image image1;
Image image2;
Image image3;
Image image4;

class FlipMix extends StatefulWidget {
  final List<Img> listImg;
  const FlipMix(this.listImg);

  @override
  _FlipMixState createState() => _FlipMixState();
}

const kItemSize = const Size.square(80.0);

class _FlipMixState extends State<FlipMix> {
  bool imgMode = true;

  ValueNotifier<String> orderNotifier = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    OrderPreview preview = OrderPreview(orderNotifier: orderNotifier);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarMyIdena(indexInit: 1),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 20,
              bottom: 0,
              left: 0,
              right: 0,
              child: ListView(
                children: <Widget>[
                  preview,
                  Center(
                      child: OrderableStack<Img>(
                          items: widget.listImg,
                          itemSize: Size(100, 120),
                          margin: 0.0,
                          direction: Direction.Vertical,
                          itemBuilder: imgItemBuilder,
                          onChange: (List<Object> orderedList) =>
                              orderNotifier.value = orderedList.toString())),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      elevation: 5.0,
                      onPressed: () async {
                        Navigator.pop(context);


                      },
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Colors.white,
                      child: Text(
                        AppLocalizations.of(context).translate("Submit"),
                        style: TextStyle(
                          color: Colors.grey,
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imgItemBuilder({Orderable<Img> data, Size itemSize}) => Container(
        color: data != null && !data.selected
            ? data.dataIndex == data.visibleIndex
                ? Colors.grey
                : Colors.grey
            : Colors.orange,
        height: 120,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              data.value.image,
            ])),
      );
}

class OrderPreview extends StatefulWidget {
  final ValueNotifier orderNotifier;

  OrderPreview({this.orderNotifier});

  @override
  State<StatefulWidget> createState() => OrderPreviewState();
}

class OrderPreviewState extends State<OrderPreview> {
  String data = '';

  OrderPreviewState();

  @override
  void initState() {
    super.initState();

    widget.orderNotifier
        .addListener(() => setState(() => data = widget.orderNotifier.value));
  }

  @override
  Widget build(BuildContext context) => Text(data);
}
