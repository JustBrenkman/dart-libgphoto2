import 'dart:io';
import 'package:libgphoto2/src/camera.dart';
import 'package:libgphoto2/src/context.dart';
import 'package:test/test.dart';

void main() {
  test("enviroment test", () {
    String camlibs = Platform.environment["CAMLIBS"].toString();
    String iolibs = Platform.environment["IOLIBS"].toString();

    if (camlibs == null || iolibs == null) {
      print(
          "Your environment is not set up. Please and the CAMLIBS(camlibs folder) and IOLIBS(iolibs folder) environmental variables");
    }

    expect(camlibs, isNotNull);
    expect(iolibs, isNotNull);
  });

  group("Camera List", () {
    test("Testing listing connected cameras", () {
      List<GPCamera> cameras = GPContext.getConnectedCameras();
      cameras.forEach((element) {
        print("Camera name:" + element.name);
        print("Camera port:" + element.port);
        element.open();
        print("Summary: " + element.getSummary());
      });
    });
  });
}
