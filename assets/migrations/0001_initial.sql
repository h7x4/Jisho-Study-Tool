
CREATE TABLE "JST_LibraryList" (
  "name" TEXT PRIMARY KEY NOT NULL,
  "nextList" TEXT REFERENCES "JST_LibraryList"("name")
);

CREATE INDEX "JST_LibraryList_byNextList" ON "JST_LibraryList"("nextList");

CREATE TABLE "JST_LibraryListEntry" (
  "listName" TEXT NOT NULL REFERENCES "JST_LibraryList"("name") ON DELETE CASCADE,
  "entryText" TEXT NOT NULL,
  "isKanji" BOOLEAN NOT NULL DEFAULT 0,
  "lastModified" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "nextEntry" TEXT NOT NULL,
  PRIMARY KEY ("listName", "entryText", "isKanji"),
  FOREIGN KEY ("listName", "nextEntry") REFERENCES "JST_LibraryListEntry"("listName", "entryText"),
  CHECK ((NOT "isKanji") OR ("nextEntry" <> 0))
);

CREATE INDEX "JST_LibraryListEntry_byListName" ON "JST_LibraryListEntry"("listName");

-- CREATE VIEW "JST_LibraryListEntry_sortedByLists" AS
--   WITH RECURSIVE "JST_LibraryListEntry_sorted"("next") AS (
--     -- Initial SELECT 
--     UNION ALL
--     SELECT * FROM ""
--     -- Recursive Select
--   )
-- SELECT * FROM "JST_LibraryListEntry_sorted";

CREATE TABLE "JST_HistoryEntry" (
  "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT
);

CREATE TABLE "JST_HistoryEntryKanji" (
  "entryId" INTEGER NOT NULL REFERENCES "JST_HistoryEntry"("id") ON DELETE CASCADE,
  "kanji" CHAR(1) NOT NULL,
  PRIMARY KEY ("entryId", "kanji")
);

CREATE TABLE "JST_HistoryEntryWord" (
  "entryId" INTEGER NOT NULL REFERENCES "JST_HistoryEntry"("id") ON DELETE CASCADE,
  "word" TEXT NOT NULL,
  "language" CHAR(1) CHECK ("language" IN ("e", "j")),
  PRIMARY KEY ("entryId", "word")
);

CREATE TABLE "JST_HistoryEntryTimestamp" (
  "entryId" INTEGER NOT NULL REFERENCES "JST_HistoryEntry"("id") ON DELETE CASCADE,
  -- Here, I'm using INTEGER insted of TIMESTAMP or DATETIME, because it seems to be
  -- the easiest way to deal with global and local timeconversion between dart and
  -- SQLite.
  "timestamp" INTEGER NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("entryId", "timestamp")
);

CREATE INDEX "JST_HistoryEntryTimestamp_byTimestamp" ON "JST_HistoryEntryTimestamp"("timestamp");

CREATE VIEW "JST_HistoryEntry_orderedByTimestamp" AS
SELECT * FROM "JST_HistoryEntryTimestamp"
LEFT JOIN "JST_HistoryEntryWord" USING ("entryId")
LEFT JOIN "JST_HistoryEntryKanji" USING ("entryId")
GROUP BY "entryId"
ORDER BY MAX("timestamp") DESC;