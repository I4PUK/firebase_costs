class RegExpConstants {
  static const String onlyAlphabet = '[А-Яа-я]';
  static const String onlyNumbersAndPlus = r'\+?(\d+)?';
  static const String emailRegExp =
      r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$';
}
