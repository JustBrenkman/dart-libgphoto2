import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:libgphoto2/src/generated_bindings.dart';

libgphoto2? _dylib;
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

  static String get platformPrefix => Platform.isWindows ? '' : 'lib';

  static String get platformSuffix {
    return Platform.isWindows
        ? '.dll'
        : Platform.isMacOS || Platform.isIOS
            ? '.dylib'
            : '.so';
  }

  static String fixupName(String baseName) {
    return baseName.prefixWith(platformPrefix).suffixWith(platformSuffix);
  }

  static bool isFile(String path) {
    return path.isNotEmpty && Directory(path).statSync().type == FileSystemEntityType.file;
  }

  static String resolvePath() {
    return fixupName('gphoto2');
  }

  static ffi.DynamicLibrary load() => ffi.DynamicLibrary.open(resolvePath());
}
