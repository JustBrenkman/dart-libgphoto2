import 'dart:ffi';
import 'package:libgphoto2/libgphoto2.dart';
import 'package:libgphoto2/src/dylib.dart';

import 'allocation.dart';
import 'camera.dart';

class GPContext {
  static Pointer _gpContext;
  static Pointer get gpcontext {
    if (_gpContext == null) _gpContext = dylib.gp_context_new();
    return _gpContext;
  }

  static Pointer<Pointer<CameraAbilitiesList>> _abilitiesPointer;
  static Pointer get abilitiesPointer {
    if (_abilitiesPointer == null) {
      _abilitiesPointer = allocate();
      int ret;
      ret = dylib.gp_abilities_list_new(_abilitiesPointer);
      if (ret < 0) {
        free(_abilitiesPointer);
        _abilitiesPointer = null;
        return null;
      }
      ret = dylib.gp_abilities_list_load(
          _abilitiesPointer.value, gpcontext.cast());
      if (ret < 0) {
        free(_abilitiesPointer);
        _abilitiesPointer = null;
        return null;
      }
    }

    return _abilitiesPointer.value;
  }

  static Pointer<Pointer> _gpPortInfoListPointer;
  static Pointer get gpPortInfoListPointer {
    print("got here 3.1");
    if (_gpPortInfoListPointer == null) {
      print("got here 3.2");
      _gpPortInfoListPointer = allocate();
      print("got here 3.3");
      int ret;
      print("got here 3.4");
      ret = dylib.gp_port_info_list_new(_gpPortInfoListPointer);
      if (ret < 0) {
        free(_gpPortInfoListPointer);
        _gpPortInfoListPointer = null;
        return null;
      }
      print("got here 3.5");
      ret = dylib.gp_port_info_list_load(_gpPortInfoListPointer.value);
      if (ret < 0) {
        free(_gpPortInfoListPointer);
        _gpPortInfoListPointer = null;
        return null;
      }
      print("got here 3.6");
      ret = dylib.gp_port_info_list_count(_gpPortInfoListPointer.value);
      if (ret < 0) {
        free(_gpPortInfoListPointer);
        _gpPortInfoListPointer = null;
        return null;
      }
    }

    return _gpPortInfoListPointer.value;
  }

  static List<GPCamera> getConnectedCameras() {
    List<GPCamera> cameras = [];
    Pointer<Pointer<Int8>> name = allocate();
    Pointer<Pointer<Int8>> value = allocate();
    Pointer<Pointer<CameraList>> list = allocate<Pointer<CameraList>>();
    int ret = dylib.gp_list_new(list);
    dylib.gp_list_reset(list.value);
    int count = dylib.gp_camera_autodetect(list.value.cast(), gpcontext.cast());

    for (int i = 0; i < count; i++) {
      dylib.gp_list_get_name(list.value.cast(), i, name);
      dylib.gp_list_get_value(list.value.cast(), i, value);
      cameras.add(GPCamera(name.value, value.value));
    }

    return cameras;
  }
}
