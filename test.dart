String createItemId(String itemName) {
  // Get a clean item id from itemName
  // Only alpanumberic, spaces changed to -
  String s = itemName.replaceAll('.', '-');                 // change all . to -
  s = itemName.replaceAll(RegExp('[^A-Za-z0-9 \-]'), "");   // allow only alphanumeric and -
  print(s);
  var index1 = s.indexOf(' ');
  print(index1);
  var index2 = s.lastIndexOf(' ');
  print(index2);
  String result = s.substring(index1, index2);
  print(result);
  s = s.replaceAll(RegExp("/-+"), '-');                      // replace multiple - with just one -
  return s;
}

void main() {
  print(createItemId("test,,,.....   one"));
}
