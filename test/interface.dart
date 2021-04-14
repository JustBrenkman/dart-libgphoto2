import 'package:libgphoto2/src/camera.dart';
import 'package:libgphoto2/src/context.dart';
import 'package:test/test.dart';

void main() {
  group("Camera List", () {
    test("Testing listing connected cameras", () {
      List<GPCamera> cameras = Context.getConnectedCameras();
      cameras.forEach((element) {
        print("Camera name:" + element.name);
        print("Camera port:" + element.port);
        element.open();
      });
    });
  });
}
