import 'dart:async';
import 'package:assignment_3/utils/app_camera_crop.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class AppCamera extends StatefulWidget {
  @override
  AppCameraState createState() => AppCameraState();
}

class AppCameraState extends State<AppCamera> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  List<CameraDescription> cameras;
  CameraDescription camera;

  getCamera() async {
    cameras = await availableCameras();

    camera = cameras.length > 1 ? cameras[1] : cameras[0];

    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
    );

    setState(() {
      _initializeControllerFuture = _controller.initialize();
    });
  }

  @override
  void initState() {
    getCamera();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NativeDeviceOrientationReader(
        useSensor: true,
        builder: (context) {
          final orientation =
              NativeDeviceOrientationReader.orientation(context);

          return Scaffold(
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FutureBuilder<void>(
                    future: _initializeControllerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        final size = MediaQuery.of(context).size;
                        final ratioDevice = size.width / size.height;
                        final ratioCamera = _controller.value.aspectRatio;

                        return AspectRatio(
                            aspectRatio: 3.0 / 4.0,
                            child: OverflowBox(
                              alignment: Alignment.center,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Container(
                                  width: ratioCamera == ratioDevice
                                      ? size.width
                                      : size.width,
                                  height: size.width / ratioCamera,
                                  child: CameraPreview(_controller),
                                ),
                              ),
                            ));
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  SizedBox(height: 30),
                  FloatingActionButton(
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      try {
                        await _initializeControllerFuture;

                        final path = join(
                          (await getTemporaryDirectory()).path,
                          '${DateTime.now()}.png',
                        );

                        await _controller.takePicture(path);

                        fixImageOrientation(path, camera.lensDirection, orientation);
                        cropCircle(path);

                        Navigator.pop(context, path);
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
