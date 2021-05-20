const int MAX_TITLE_STRING_LENGTH = 30;

String longTitleStringToShort(String long) {
  if (long.length <= MAX_TITLE_STRING_LENGTH)
    return long;
  return long.substring(0, MAX_TITLE_STRING_LENGTH - 3) + "...";
}

String toQuotation(String text) {
  if (text == null) {
    return null;
  }
  return "\"$text\"";
}