package com.papauschek.puzzle

object PuzzleWords {

  /** @return sort the given words, such that the words with the most common characters are first.
   *          this is the most efficient way of incrementally adding words to a puzzle. */
  def sortByBest(words: Seq[String]): Seq[String] =

    val hindiMatras = Array(
      "\u093E", // ा (Devanagari Vowel Sign Aa)
      "\u093F", // ि (Devanagari Vowel Sign I)
      "\u0940", // ी (Devanagari Vowel Sign Ii)
      "\u0941", // ु (Devanagari Vowel Sign U)
      "\u0942", // ू (Devanagari Vowel Sign Uu)
      "\u0943", // ृ (Devanagari Vowel Sign Vocalic R)
      "\u0944", // ॄ (Devanagari Vowel Sign Vocalic Rr)
      "\u0947", // े (Devanagari Vowel Sign E)
      "\u0948", // ै (Devanagari Vowel Sign Ai)
      "\u094B", // ो (Devanagari Vowel Sign O)
      "\u094C", // ौ (Devanagari Vowel Sign Au)
      "\u0902", // ं (Devanagari Sign Anusvara)
      "\u0903" // ः (Devanagari Sign Visarga)
    )
    val allChars1 = words.flatten.toVector
    var allChars = Vector[String]();
    for (i <- 0 to (allChars1.length - 1)) {
      if (hindiMatras contains allChars1(i).toString()) {
        val s = allChars.last;
        allChars = allChars.dropRight(1);
        allChars = allChars :+ (s+allChars1(i).toString());
      } else {
        allChars = allChars :+ allChars1(i).toString();
      }
    }
    val allCharCount = allChars.length
    
    val frequency = allChars.groupBy(c => c).map { case (c, list) => (c, list.length / allCharCount.toDouble) }

    def rateWord(word: String): Double = {
      var allChars = Vector[String]();
       for (i <- 0 to (word.length - 1)) {
        if (hindiMatras contains word(i).toString()) {
          val s = allChars.last;
          allChars = allChars.dropRight(1);
          allChars = allChars :+ (s+word(i).toString());
        } else {
          allChars = allChars :+ word(i).toString();
        }
      }

      allChars.map(frequency).sum
    }

    words.sortBy(rateWord).reverse

}
