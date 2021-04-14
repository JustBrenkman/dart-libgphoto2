import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:libgphoto2/src/utils.dart';

import '../libgphoto2.dart';
import '../libgphoto2.dart';
import '../libgphoto2.dart';
import '../libgphoto2.dart';
import '../libgphoto2.dart';
import '../libgphoto2.dart';
import '../libgphoto2.dart';

class GPCamera {
  final Pointer<Utf8> _nameP;
  final Pointer<Utf8> _portP;
  Pointer<Pointer<Camera>> _cameraP = malloc();

  String get name => _nameP.toDartString();
  String get port => _portP.toDartString();

  GPCamera(this._nameP, this._portP);

  void open() {
    // dylib.gp_camera_new(_cameraP);
    // Pointer<Pointer<CameraAbilitiesList>> abilities = malloc();
    // Pointer<CameraAbilities> a = malloc();
    // dylib.gp_abilities_list_new(abilities);
    // dylib.gp_abilities_list_load(abilities.value, Context.gpcontext);
    // int m =
    //     dylib.gp_abilities_list_lookup_model(abilities.value, _nameP.cast());
    // dylib.gp_abilities_list_get_abilities(abilities.value, m, a);
    // dylib.gp_camera_set_abilities(_cameraP.value, a.ref);

    // Pointer<Pointer<GPPortInfoList>> portInfoList = malloc();
    // Pointer<Pointer<GPPortInfo>> pi = malloc();
    // dylib.gp_port_info_list_new(portInfoList);
    // dylib.gp_port_info_list_load(portInfoList.value);
    // dylib.gp_port_info_list_count(portInfoList.value);

    // int p =
    //     dylib.gp_port_info_list_lookup_path(portInfoList.value, _portP.cast());
    // dylib.gp_port_info_list_get_info(portInfoList.value, p, pi);
    // dylib.gp_camera_set_port_info(_cameraP.value, pi.value);
  }

  String getSummary() {
    var buffer = new StringBuffer();
    return buffer.toString();
  }
}
