const int NB_MAX_FLIPKEYWORDPAIRS = 9;

class UtilFlip {
  int getFirstFlipKeyWordPairsNotUsed(List flipKeyWordPairs) {
    int first = 0;
    for (var i = 0; i < flipKeyWordPairs.length; i++) {
      if (!flipKeyWordPairs.elementAt(i).used) {
        first = i;
        break;
      }
    }
    return first;
  }

  int findNextFlipKeyWordPairsNotUsed(
      List flipKeyWordPairs, int flipKeyWordPairsNotUsedNumber) {
    int start = flipKeyWordPairsNotUsedNumber;
    if (flipKeyWordPairsNotUsedNumber == NB_MAX_FLIPKEYWORDPAIRS) {
      start = 0;
    }
    for (var i = start;
        i < flipKeyWordPairs.length;
        i++) {
      if (!flipKeyWordPairs
          .elementAt(i)
          .used) {
        return i;
      }
    }
    return 0;
  }
}
