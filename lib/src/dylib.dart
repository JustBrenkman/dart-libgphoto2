import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:libgphoto2/src/generated_bindings.dart';

libgphoto2 _dylib;
libgphoto2 get dylib => _dylib ??= libgphoto2(LibraryLoader.load());

extension StringWith on String {
  String prefixWith(String prefix) {
    if (isEmpty || startsWith(prefix)) return this;
    return prefix + this;
  }

  String suffixWith(String suffix) {
    if (isEmpty || endsWith(suffix)) return this;
    return this + suffix;
  }
}

abstract class LibraryLoader {
  LibraryLoader._();

  static String get platformSuffix {
    return Platform.isWindows
        ? '.dll'
        : Platform.isMacOS || Platform.isIOS
            ? '.dylib'
            : '.so';
  }

  static String fixupName(String baseName) {
    return baseName.suffixWith(platformSuffix);
  }

  static String resolvePath() {
    return fixupName(
        Directory.current.absolute.path + '\\libraries\\windows\\libgphoto2');
  }

  static ffi.DynamicLibrary load() {
    String path = resolvePath();
    print("Opening library at $path");
    return ffi.DynamicLibrary.open(path);
  }
}
