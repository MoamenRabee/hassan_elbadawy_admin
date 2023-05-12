bool isNumeric(String str) {
  try{
    var value = double.parse(str);
    return false;
  } on FormatException {
    return true;
  }
}