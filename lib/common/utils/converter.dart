

class Converter{

static int letterToIndex(String letters) => 
    letters.codeUnits.fold(0, (v, e) => v * 26 + (e & 0x1f) - 1);

static String indexToLetter(int index) {
  index += 1;
  var letters = '';
  do {
    final r = index % 26;
    letters = '${String.fromCharCode(64 + r)}$letters';
    index = (index - r) ~/ 26;
  } while (index > 0);
  return letters;
}


} 
