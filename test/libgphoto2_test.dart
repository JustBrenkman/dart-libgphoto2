import 'dart:io';

import 'package:libgphoto2/libgphoto2.dart';
import 'package:libgphoto2/src/dylib.dart';
import 'package:test/test.dart';
import 'dart:ffi';

String convertPointerToString(Pointer<Int8> string, {int maxLength = 100}) {
  List<int> builder = [];
  for (int i = 0; i < maxLength; i++) {
    if (string.elementAt(i).value == 0)
      break;
    else
      builder.add(string.elementAt(i).value);
  }
  return String.fromCharCodes(builder);
}

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
  // group("Test the basic library functions", () {
  //   test("Testing listing connected cameras", () {
  //     Pointer context;
  //     Pointer<Pointer<Int8>> name = allocate();
  //     Pointer<Pointer<Int8>> value = allocate();
  //     context = dylib.gp_context_new();
  //     Pointer<Pointer<CameraList>> list = allocate<Pointer<CameraList>>();
  //     int ret = dylib.gp_list_new(list);
  //     expect(ret, equals(0));
  //     dylib.gp_list_reset(list.value);
  //     int count = dylib.gp_camera_autodetect(list.value.cast(), context.cast());
  //     print("Found $count cameras");

  //     for (int i = 0; i < count; i++) {
  //       dylib.gp_list_get_name(list.value.cast(), i, name);
  //       dylib.gp_list_get_value(list.value.cast(), i, value);
  //       print(convertPointerToString(name.value));
  //       print(convertPointerToString(value.value));
  //     }
  //   });
  // });
}
