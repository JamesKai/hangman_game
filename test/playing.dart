main(List<String> args) {
  String word = 'kittie';
  String input = 'i';
  String wordRepre = word.split('').map((e) => e == input ? input : '*').join();
  print(wordRepre);
  print(wordRepre.length);
}
