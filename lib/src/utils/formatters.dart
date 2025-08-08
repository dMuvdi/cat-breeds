String countryCodeToEmoji(String countryCode) {
  // Convert country code to flag emoji
  // Each letter is converted to its regional indicator symbol
  final codePoints =
      countryCode
          .toUpperCase()
          .split('')
          .map((char) => 127397 + char.codeUnitAt(0))
          .toList();

  return String.fromCharCodes(codePoints);
}
