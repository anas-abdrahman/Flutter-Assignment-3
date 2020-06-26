import 'dart:io';
import 'package:camera/camera.dart';
import 'package:image/image.dart';
import 'package:native_device_orientation/native_device_orientation.dart';

void cropCard(String path) {

  Image image = decodeImage(File(path).readAsBytesSync());

  double frameWidth = image.width * 0.7;
  num frameWidthNum = frameWidth.toInt();

  double frameHeight = frameWidthNum / 1.6;
  num frameHeightNum = frameHeight.toInt();

  double xCoords = image.width * 0.3 / 2;
  int width = xCoords.toInt();

  double topHeight = image.height / 2 - frameHeight / 2;
  double yCoords = topHeight;
  int height = yCoords.toInt();
  
  Image croppedImage = copyCrop(image, width, height, frameWidthNum, frameHeightNum);

  File(path).writeAsBytesSync(encodePng(croppedImage));

}

void cropCircle(String path) {

  Image image = decodeImage(File(path).readAsBytesSync());

  double xCoords = image.width * 0.3 / 2;
  int width = xCoords.toInt();

  double frameWidth = image.width * 0.7;
  num frameWidthNum = frameWidth.toInt();

  double topHeight = image.height / 2 - frameWidth / 2;
  double yCoords = topHeight;
  int height = yCoords.toInt();

  Image croppedImage = copyCrop(image, width, height, frameWidthNum, frameWidthNum);

  File(path).writeAsBytesSync(encodePng(croppedImage));
}

rotateImage(String path, int degree) async {
  Image image = decodeImage(File(path).readAsBytesSync());
  File(path).writeAsBytesSync(encodePng(copyRotate(image, degree)));
}

flipImage(String path,) async {
  Image image = decodeImage(File(path).readAsBytesSync());
  File(path).writeAsBytesSync(encodePng(flipHorizontal(image)));
}

fixImageOrientation(String path, CameraLensDirection cameraLens, NativeDeviceOrientation orientation){

  Image image = decodeImage(File(path).readAsBytesSync());
  int  degree = getOrintatioDegree(orientation);

  if (image.exif.hasOrientation) {

    switch (image.exif.orientation) {
      case 1:
        image = copyRotate(image, 0);
        break;
      case 2:
        image = flip(image, Flip.horizontal);
        break;
      case 3:
        image = copyRotate(image, 180);
        break;
      case 4:
        image = flip(image, Flip.vertical);
        break;
      case 5:
        image = copyRotate(image, 90);
        image = flip(image, Flip.horizontal);
        break;
      case 6:
        image = copyRotate(image, 90);
        break;
      case 7:
        image = copyRotate(image, -90);
        image = flip(image, Flip.horizontal);
        break;
      case 8:
        image = copyRotate(image, -90);
        break;
      default:
    }    

  }

  image = copyRotate(image, degree);

  if(cameraLens == CameraLensDirection.front){

    if(degree == 90 || degree == -90){
      image = flip(image, Flip.vertical);
    }else{
      image = flip(image, Flip.horizontal);
    }

  }

  File(path).writeAsBytesSync(encodePng(image));

}

int getOrintatioDegree(NativeDeviceOrientation orientation){

  int turns;

  switch (orientation) {
    case NativeDeviceOrientation.landscapeLeft:
      turns =  90;
      break;
    case NativeDeviceOrientation.landscapeRight:
      turns = -90;
      break;
    case NativeDeviceOrientation.portraitDown:
      turns = 180;
      break;
    default:
      turns = 0;
      break;
  }

  return turns;
  
}