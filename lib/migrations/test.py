import sqlite3
import json

# returns id
def insert_radical(cursor, item) -> str:
  if 'radical' in item:
    dataId = cursor.execute(
      'INSERT OR IGNORE INTO Kanji_Radical(symbol, meaning) VALUES (?, ?)',
      (item['radical']['symbol'], item['radical']['meaning'])
    )
    if 'forms' in item['radical']:
      for form in item['radical']['forms']:
        cursor.execute(
          'INSERT OR IGNORE INTO Kanji_Radical_Forms(form, radical) VALUES (?, ?)',
          (form, item['radical']['symbol'])
        )
    return item['radical']['symbol']
  return None

def insert_kanji(cursor, item):
  cursor.execute(
    """
    INSERT OR IGNORE INTO Kanji_Result(
      kanji,
      strokeCount,
      meaning,
      radical
    )
    VALUES (?,?,?,?)
    """,
    (
      item['query'],
      item['strokeCount'],
      item['meaning'],
      item['radical']['symbol'],
    )
  )

  for column in ['jlptLevel', 'newspaperFrequencyRank', 'taughtIn']:
    if (column in item):
      cursor.execute(
        f'UPDATE Kanji_Result SET {column} = ? WHERE kanji = ?',
        (item[column], item['query'])
      )

def insert_yomi(cursor, item, on=True):
  yomiName = 'Onyomi' if on else 'Kunyomi'
  for yomi in item[yomiName.lower()]:
    cursor.execute(
      f"""
      INSERT OR IGNORE INTO Kanji_{yomiName}(yomi)
      VALUES (?)
      """,
      (yomi,)
    )

    cursor.execute(
      f"""
      INSERT OR IGNORE INTO Kanji_Result{yomiName}_XRef(yomi, kanji)
      VALUES (?, ?)
      """,
      (yomi, item['query'])
    )

def insert_yomi_examples(cursor, item, on=True):
  yomiName = 'Onyomi' if on else 'Kunyomi'
  for yomiExample in item[yomiName.lower() + 'Examples']:
    cursor.execute(
      f"""
      INSERT OR IGNORE INTO Kanji_YomiExample(example, reading, meaning)
      VALUES (?, ?, ?)
      """,
      (yomiExample['example'], yomiExample['reading'], yomiExample['meaning'])
    )

    cursor.execute(
      f"""
      INSERT OR IGNORE INTO Kanji_Result{yomiName}Example_XRef(exampleID, kanji)
      VALUES (?, ?)
      """,
      (cursor.lastrowid, item['query'])
    )

def insert_parts(cursor, item):
  for part in item['parts']:
    cursor.execute(
      """
      INSERT OR IGNORE INTO Kanji_Part(part)
      VALUES (?)
      """,
      (part,)
    )

    cursor.execute(
      """
      INSERT OR IGNORE INTO Kanji_ResultPart_XRef(part, kanji)
      VALUES (?, ?)
      """,
      (part, item['query'])
    )

def insertYomiExamples(cursor, item, on=True):
  yomiName = 'Onyomi' if on else 'Kunyomi'
  for yomi in item[yomiName.lower()]:
    cursor.execute(
      f"""
      INSERT OR IGNORE INTO Kanji_{yomiName}(yomi)
      VALUES (?)
      """,
      (yomi,)
    )

    cursor.execute(
      f"""
      INSERT OR IGNORE INTO Kanji_Result{yomiName}_XRef(yomi, kanji)
      VALUES (?, ?)
      """,
      (yomi, item['query'])
    )

with sqlite3.connect("test.db") as connection:
  cursor = connection.cursor()
  for grade in range(1, 8):
    with open(f'data/jisho/grade{grade}.json') as file:
      data = json.loads(file.read())
      for item in data:
        rad = insert_radical(cursor, item)
        insert_kanji(cursor, item)
        insert_yomi(cursor, item, on=True)
        insert_yomi(cursor, item, on=False)
        insert_yomi_examples(cursor, item, on=True)
        insert_yomi_examples(cursor, item, on=False)
        insert_parts(cursor, item)
