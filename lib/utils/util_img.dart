import 'dart:io';
import 'dart:math';
import 'package:image/image.dart' as ImageTool;
import 'package:flutter/widgets.dart';

class Img {
  final Image image;
  final String title;
  const Img(this.image, this.title);

  @override
  String toString() => 'Img{title: $title}';
}

Image resizeImg(File imgFile) {
  const int HEIGHT = 330;
  const int WIDTH = 440;
  const int WIDTH_THUMB = 130;
  ImageTool.Image imageDecoded =
      ImageTool.decodeImage(imgFile.readAsBytesSync());
  ImageTool.Image imageResized;
  ImageTool.Image finalImage;
  ImageTool.Image backgroundImage;
  if (imageDecoded.width > imageDecoded.height) {
    imageResized = ImageTool.copyResize(imageDecoded, width: WIDTH);
    if (imageResized.height < HEIGHT) {
      finalImage = ImageTool.Image(WIDTH, HEIGHT);
      backgroundImage = ImageTool.copyResize(imageDecoded, width: WIDTH*10, height: HEIGHT*10);
      ImageTool.copyInto(finalImage, backgroundImage, dstX: (WIDTH ~/ 2 + new Random().nextDouble() * 200 - 400).toInt(), dstY: (HEIGHT ~/ 2 + new Random().nextDouble() * 200 - 400).toInt());
      ImageTool.gaussianBlur(finalImage, 5);
      ImageTool.copyInto(finalImage, imageResized,
          dstY: (HEIGHT - imageResized.height) ~/ 2);
    } else {
      finalImage = imageResized;
    }
  } else {
    imageResized = ImageTool.copyResize(imageDecoded, height: HEIGHT);
    if (imageResized.width < WIDTH) {
      finalImage = ImageTool.Image(WIDTH, HEIGHT);
      backgroundImage = ImageTool.copyResize(imageDecoded, width: WIDTH*10, height: HEIGHT*10);
      ImageTool.copyInto(finalImage, backgroundImage, dstX: (WIDTH ~/ 2 + new Random().nextDouble() * 200 - 400).toInt(), dstY: (HEIGHT ~/ 2 + new Random().nextDouble() * 200 - 400).toInt());
      ImageTool.gaussianBlur(finalImage, 5);
      ImageTool.copyInto(finalImage, imageResized,
          dstX: (WIDTH - imageResized.width) ~/ 2);
    }
    else
    {
      finalImage = imageResized;
    }
  }
  ImageTool.Image thumbnail =
      ImageTool.copyResize(finalImage, width: WIDTH_THUMB);
  return Image.memory(ImageTool.encodePng(thumbnail));
}

Image addShuffleArrowsIcon(Image imgFile) {
  /*ImageTool.Image shuffleArrowsIcon = ImageTool.decodePng(File('assets/images/shuffle_arrows.png').readAsBytesSync());
  ImageTool.Image imgInput = ImageTool.decodePng(imgFile);

  ImageTool.copyInto(imgFile, shuffleArrowsIcon, dstX: imgFile.width - shuffleArrowsIcon.width - 10, dstY: imgFile.height - shuffleArrowsIcon.height - 10);*/
  return imgFile;
}
