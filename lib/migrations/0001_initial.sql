-- KANJI

CREATE TABLE Kanji_YomiExample (
  exampleID INTEGER PRIMARY KEY AUTOINCREMENT,
  example TEXT NOT NULL,
  reading TEXT NOT NULL,
  meaning TEXT NOT NULL,
  UNIQUE (example, reading, meaning)
);

CREATE TABLE Kanji_Radical (
  id INTEGER NOT NULL UNIQUE,
  symbol CHAR(1) NOT NULL PRIMARY KEY,
  strokes INTEGER NOT NULL,
  meaning TEXT NOT NULL,
  searchSymbol CHAR(1)
);

CREATE TABLE Kanji_Radical_Forms (
  form TEXT NOT NULL PRIMARY KEY,
  radical CHAR(1) NOT NULL,
  FOREIGN KEY(radical) REFERENCES Kanji_Radical(symbol)
);

CREATE TABLE Kanji_Kunyomi (
  yomi TEXT NOT NULL PRIMARY KEY
);

CREATE TABLE Kanji_Onyomi (
  yomi TEXT NOT NULL PRIMARY KEY
);

CREATE TABLE Kanji_Part (
  part TEXT NOT NULL PRIMARY KEY
);

CREATE TABLE Kanji_Result (
  kanji CHAR(1) PRIMARY KEY,
  taughtIn INTEGER,
  jlptLevel INTEGER,
  newspaperFrequencyRank INTEGER,
  strokeCount INTEGER NOT NULL,
  meaning INTEGER NOT NULL,
  radical CHAR(1) NOT NULL,
  FOREIGN KEY (radical) REFERENCES Kanji_Radical(symbol)
);

CREATE TABLE Kanji_ResultKunyomiExample_XRef (
  exampleID INTEGER NOT NULL,
  kanji TEXT NOT NULL,
  FOREIGN KEY(exampleID) REFERENCES Kanji_YomiExample(exampleID),
  FOREIGN KEY(kanji) REFERENCES Kanji_Result(kanji),
  PRIMARY KEY(exampleID, kanji)
);

CREATE TABLE Kanji_ResultOnyomiExample_XRef (
  exampleID INTEGER NOT NULL,
  kanji TEXT NOT NULL,
  FOREIGN KEY(exampleID) REFERENCES Kanji_YomiExample(exampleID),
  FOREIGN KEY(kanji) REFERENCES Kanji_Result(kanji),
  PRIMARY KEY(exampleID, kanji)
);

CREATE TABLE Kanji_ResultKunyomi_XRef (
  yomi TEXT NOT NULL,
  kanji TEXT NOT NULL,
  FOREIGN KEY(yomi) REFERENCES Kanji_Kunyomi(yomi),
  FOREIGN KEY(kanji) REFERENCES Kanji_Result(kanji),
  PRIMARY KEY(yomi, kanji)
);

CREATE TABLE Kanji_ResultOnyomi_XRef (
  yomi TEXT NOT NULL,
  kanji TEXT NOT NULL,
  FOREIGN KEY(yomi) REFERENCES Kanji_Onyomi(yomi),
  FOREIGN KEY(kanji) REFERENCES Kanji_Result(kanji),
  PRIMARY KEY(yomi, kanji)
);

CREATE TABLE Kanji_ResultPart_XRef (
  part TEXT NOT NULL,
  kanji TEXT NOT NULL,
  FOREIGN KEY(part) REFERENCES Kanji_Part(part),
  FOREIGN KEY(kanji) REFERENCES Kanji_Result(kanji),
  PRIMARY KEY(part, kanji)
);

-- Example Sentence

CREATE TABLE ExampleSentence_Result (
  resultID INTEGER PRIMARY KEY AUTOINCREMENT,
  kanji TEXT NOT NULL,
  kana TEXT NOT NULL,
  english TEXT NOT NULL
);

CREATE TABLE ExampleSentence_Piece (
  orderNum INTEGER NOT NULL,
  lifted TEXT,
  unlifted TEXT NOT NULL,
  resultID INTEGER NOT NULL,
  FOREIGN KEY(resultID) REFERENCES ExampleSentence_Result(resultID),
  PRIMARY KEY(resultID, orderNum)
);

-- Words

CREATE TABLE PhraseScrape_Result (
  uri TEXT NOT NULL PRIMARY KEY
);

CREATE TABLE PhraseScrape_Sentence (
  english TEXT NOT NULL,
  japanese TEXT NOT NULL,
  PRIMARY KEY (english, japanese)
);

CREATE TABLE PhraseScrape_Sentence_Piece (
  orderNum INTEGER NOT NULL,
  lifted TEXT,
  unlifted TEXT NOT NULL,
  sentenceEnglish TEXT NOT NULL,
  sentenceJapanese TEXT NOT NULL,
  FOREIGN KEY(sentenceEnglish, sentenceJapanese) REFERENCES PhraseScrape_Sentence(english, japanese) ON DELETE CASCADE,
  PRIMARY KEY (sentenceEnglish, sentenceJapanese, orderNum)
);

CREATE TABLE PhraseScrape_Meaning_SeeAlsoTerm (
  seeAlsoTerm TEXT NOT NULL,
  meaningDefinition TEXT NOT NULL,
  resultUri TEXT NOT NULL,
  FOREIGN KEY (meaningDefinition, resultUri) REFERENCES PhraseScrape_Meaning (definition, resultUri) ON DELETE CASCADE,
  PRIMARY KEY (seeAlsoTerm, meaningDefinition, resultUri)
);

CREATE TABLE PhraseScrape_Meaning_Supplemental (
  supplemental TEXT NOT NULL,
  meaningDefinition TEXT NOT NULL,
  resultUri TEXT NOT NULL,
  FOREIGN KEY (meaningDefinition, resultUri) REFERENCES PhraseScrape_Meaning (definition, resultUri) ON DELETE CASCADE,
  PRIMARY KEY (supplemental, meaningDefinition, resultUri)

);

CREATE TABLE PhraseScrape_Meaning_Tag (
  tag TEXT NOT NULL,
  meaningDefinition TEXT NOT NULL,
  resultUri TEXT NOT NULL,
  FOREIGN KEY (meaningDefinition, resultUri) REFERENCES PhraseScrape_Meaning (definition, resultUri) ON DELETE CASCADE,
  PRIMARY KEY (tag, meaningDefinition, resultUri)
);

CREATE TABLE PhraseScrape_Meaning (
  definition TEXT NOT NULL,
  definitionAbstract TEXT,
  resultUri TEXT NOT NULL,
  FOREIGN KEY(resultUri) REFERENCES PhraseScrape_Result(uri) ON DELETE CASCADE,
  PRIMARY KEY(definition,resultUri)
);

CREATE TABLE PhraseScrape_MeaningSentence_XRef (
  sentenceEnglish TEXT NOT NULL,
  sentenceJapanese TEXT NOT NULL,
  resultUri TEXT NOT NULL,
  FOREIGN KEY(resultUri) REFERENCES PhraseScrape_Result(uri) ON DELETE CASCADE,
  FOREIGN KEY(sentenceEnglish, sentenceJapanese) REFERENCES PhraseScrape_Sentence(english, japanese) ON DELETE CASCADE
);

CREATE TABLE PhraseScrape_KanjiKanaPair (
  kanji TEXT NOT NULL,
  kana TEXT,
  resultUri TEXT NOT NULL,
  FOREIGN KEY(resultUri) REFERENCES PhraseScrape_Result(uri) ON DELETE CASCADE,
  PRIMARY KEY (kanji, kana, resultUri)
);

CREATE TABLE PhraseScrape_AudioFile (
  uri TEXT NOT NULL PRIMARY KEY,
  mimetype TEXT NOT NULL,
  resultUri TEXT NOT NULL,
  FOREIGN KEY(resultUri) REFERENCES PhraseScrape_Result(uri) ON DELETE CASCADE
);

CREATE TABLE PhraseScrape_Note (
  note TEXT NOT NULL,
  resultUri TEXT NOT NULL,
  FOREIGN KEY(resultUri) REFERENCES PhraseScrape_Result(uri) ON DELETE CASCADE,
  PRIMARY KEY (note, resultUri)
);

-- API

CREATE TABLE PhraseSearch_JishoResult (
  slug TEXT NOT NULL PRIMARY KEY,
  isCommon BOOLEAN
);

CREATE TABLE PhraseScrape_JishoResult_Tag (
  tag TEXT NOT NULL,
  resultSlug TEXT NOT NULl,
  FOREIGN KEY(resultSlug) REFERENCES PhraseSearch_JishoResult(slug) ON DELETE CASCADE,
  PRIMARY KEY (tag, resultSlug)
);

CREATE TABLE PhraseScrape_JishoResult_Jlpt (
  jlpt TEXT NOT NULL,
  resultSlug TEXT NOT NULl,
  FOREIGN KEY(resultSlug) REFERENCES PhraseSearch_JishoResult(slug) ON DELETE CASCADE,
  PRIMARY KEY (jlpt, resultSlug)
);

CREATE TABLE PhraseSearch_JapaneseWord (
  word TEXT,
  reading TEXT,
  resultSlug TEXT NOT NULl,
  FOREIGN KEY(resultSlug) REFERENCES PhraseSearch_JishoResult(slug) ON DELETE CASCADE,
  PRIMARY KEY (word, reading, resultSlug),
  CHECK (word NOT NULL OR reading NOT NULL)
);

CREATE TABLE PhraseSearch_WordSense (
  id INTEGER PRIMARY KEY AUTOINCREMENT
);

CREATE TABLE PhraseSearch_WordSense_Link (
  text TEXT NOT NULL,
  url TEXT NOT NULL,
  senseID INTEGER NOT NULL,
  FOREIGN KEY(senseID) REFERENCES PhraseSearch_WordSense(id) ON DELETE CASCADE,
  PRIMARY KEY(url, senseID)
);

CREATE TABLE PhraseSearch_WordSense_Tag (
  tag TEXT NOT NULL,
  senseID INTEGER NOT NULL,
  FOREIGN KEY(senseID) REFERENCES PhraseSearch_WordSense(id) ON DELETE CASCADE,
  PRIMARY KEY (tag, senseID)
);

CREATE TABLE PhraseSearch_WordSense_SeeAlso (
  seeAlso TEXT NOT NULL,
  senseID INTEGER NOT NULL,
  FOREIGN KEY(senseID) REFERENCES PhraseSearch_WordSense(id) ON DELETE CASCADE,
  PRIMARY KEY (seeAlso, senseID)
);

CREATE TABLE PhraseSearch_WordSense_Antonym (
  antonym TEXT NOT NULL,
  senseID INTEGER NOT NULL,
  FOREIGN KEY(senseID) REFERENCES PhraseSearch_WordSense(id) ON DELETE CASCADE,
  PRIMARY KEY (antonym, senseID)
);

CREATE TABLE PhraseSearch_WordSense_Source (
  language TEXT NOT NULL,
  word TEXT,
  senseID INTEGER NOT NULL,
  FOREIGN KEY(senseID) REFERENCES PhraseSearch_WordSense(id) ON DELETE CASCADE,
  PRIMARY KEY (language, senseID)
);

CREATE TABLE PhraseSearch_WordSense_Info (
  info TEXT NOT NULL,
  senseID INTEGER NOT NULL,
  FOREIGN KEY(senseID) REFERENCES PhraseSearch_WordSense(id) ON DELETE CASCADE,
  PRIMARY KEY (info, senseID)
);

CREATE TABLE PhraseSearch_WordSense_Restriction (
  restriction TEXT NOT NULL,
  senseID INTEGER NOT NULL,
  FOREIGN KEY(senseID) REFERENCES PhraseSearch_WordSense(id) ON DELETE CASCADE,
  PRIMARY KEY (restriction, senseID)
);

CREATE TABLE PhraseSearch_Attribution (
  jmdict BOOLEAN NOT NULL,
  jmnedict BOOLEAN NOT NULL,
  dbpedia TEXT,
  resultSlug TEXT NOT NULl PRIMARY KEY,
  FOREIGN KEY(resultSlug) REFERENCES PhraseSearch_JishoResult(slug) ON DELETE CASCADE
);