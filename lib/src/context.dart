import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:libgphoto2/libgphoto2.dart';
import 'package:libgphoto2/src/dylib.dart';

import 'camera.dart';

class Context {
  static Pointer<GPContext> _gpContext = dylib.gp_context_new();
  static Pointer<GPContext> get gpcontext {
    return _gpContext;
  }

  static List<GPCamera> getConnectedCameras() {
    List<GPCamera> cameras = [];
    Pointer<Pointer<Int8>> name = malloc();
    Pointer<Pointer<Int8>> value = malloc();
    Pointer<Pointer<CameraList>> list = malloc();
    int ret = dylib.gp_list_new(list);
    dylib.gp_list_reset(list.value);
    int count = dylib.gp_camera_autodetect(list.value, gpcontext);
    for (int i = 0; i < count; i++) {
      dylib.gp_list_get_name(list.value.cast(), i, name);
      dylib.gp_list_get_value(list.value.cast(), i, value);
      cameras.add(GPCamera(name.value.cast(), value.value.cast()));
    }

    return cameras;
  }
}
