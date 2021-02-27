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
