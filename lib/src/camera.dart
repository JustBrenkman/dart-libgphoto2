import 'dart:ffi';

import 'package:libgphoto2/src/allocation.dart';
import 'package:libgphoto2/src/utils.dart';

import '../libgphoto2.dart';

class GPCamera {
  final Pointer<Int8> _nameP;
  final Pointer<Int8> _portP;
  Pointer<Camera> _cameraP;

  String get name => convertPointerToString(_nameP);
  String get port => convertPointerToString(_portP);

  GPCamera(this._nameP, this._portP);

  void open() {
    if (_cameraP != null) return;
    _cameraP = allocate();
    Pointer<CameraAbilities> _list = allocate();
    Pointer _portInfo = allocate();
    int m = dylib.gp_abilities_list_lookup_model(
        GPContext.abilitiesPointer, _cameraP.cast());
    dylib.gp_abilities_list_get_abilities(GPContext.abilitiesPointer, m, _list);
    dylib.gp_camera_set_abilities(_cameraP, _list.address);
    int p = dylib.gp_port_info_list_lookup_path(
        GPContext.gpPortInfoListPointer, _portP);
    dylib.gp_port_info_list_get_info(
        GPContext.gpPortInfoListPointer, p, _portInfo.cast());
    dylib.gp_camera_set_port_info(_cameraP, _portInfo);
  }

  String getSummary() {
    Pointer text = allocate();
    dylib.gp_camera_get_summary(_cameraP, text, GPContext.gpcontext);
    return convertPointerToString(text);
  }
}
