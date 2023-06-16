class RegExpValidator {
  static bool regexValidator({
    required String regexPattern,
    required String value,
  }) {
    final Iterable<RegExpMatch> matches =
        RegExp(regexPattern).allMatches(value);
    return matches.length == 1;
  }
}
