CREATE TABLE "JST_LibraryList" (
  "name" TEXT PRIMARY KEY NOT NULL,
  "prevList" TEXT
    UNIQUE
    REFERENCES "JST_LibraryList"("name"),
    -- The list can't link to itself
    CHECK("prevList" != "name"),
  -- 'favourites' should always be the first list
  CHECK (NOT (("name" = 'favourites') <> ("prevList" IS NULL)))
);

-- This entry should always exist
INSERT INTO "JST_LibraryList"("name") VALUES ('favourites');

-- Useful for the view below
CREATE INDEX "JST_LibraryList_byPrevList" ON "JST_LibraryList"("prevList");

-- A view that sorts the LibraryLists in their custom order.
CREATE VIEW "JST_LibraryListOrdered" AS
  WITH RECURSIVE "RecursionTable"("name") AS (
    SELECT "name"
    FROM "JST_LibraryList" "I"
    WHERE "I"."prevList" IS NULL
  
    UNION ALL
  
    SELECT "R"."name"
    FROM "JST_LibraryList" "R"
    JOIN "RecursionTable" ON
      ("R"."prevList" = "RecursionTable"."name")
  )
  SELECT * FROM "RecursionTable";

CREATE TABLE "JST_LibraryListEntry" (
  "listName" TEXT NOT NULL REFERENCES "JST_LibraryList"("name") ON DELETE CASCADE,
  "entryText" TEXT NOT NULL,
  "isKanji" BOOLEAN NOT NULL DEFAULT 0,
  -- Defaults to unix timestamp in milliseconds
  "lastModified" INTEGER NOT NULL DEFAULT (strftime('%s', 'now') * 1000),
  "prevEntryText" TEXT,
  "prevEntryIsKanji" BOOLEAN NOT NULL DEFAULT 0,
  PRIMARY KEY ("listName", "entryText", "isKanji"),
  FOREIGN KEY ("listName", "prevEntryText", "prevEntryIsKanji")
    REFERENCES "JST_LibraryListEntry"("listName", "entryText", "isKanji"),
  -- Two entries can not appear directly after the same entry
  UNIQUE("listName", "prevEntryText", "prevEntryIsKanji"),
  -- The entry can't link to itself
  CHECK(NOT ("prevEntryText" == "entryText" AND "prevEntryIsKanji" == "isKanji")),
  -- Kanji entries should only have a length of 1
  CHECK ((NOT "isKanji") OR ("isKanji" AND length("entryText") = 1))
);

-- Useful when doing the recursive ordering statement
CREATE INDEX "JST_LibraryListEntry_byListNameAndPrevEntry"
  ON "JST_LibraryListEntry"("listName", "prevEntryText", "prevEntryIsKanji");

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
  -- Defaults to unix timestamp in milliseconds
  "timestamp" INTEGER NOT NULL DEFAULT (strftime('%s', 'now') * 1000),
  PRIMARY KEY ("entryId", "timestamp")
);

-- Useful when ordering entries by the timestamps
CREATE INDEX "JST_HistoryEntryTimestamp_byTimestamp" ON "JST_HistoryEntryTimestamp"("timestamp");

CREATE VIEW "JST_HistoryEntry_orderedByTimestamp" AS
  SELECT * FROM "JST_HistoryEntryTimestamp"
  LEFT JOIN "JST_HistoryEntryWord" USING ("entryId")
  LEFT JOIN "JST_HistoryEntryKanji" USING ("entryId")
  GROUP BY "entryId"
  ORDER BY MAX("timestamp") DESC;