# Sentinel AI — Cleaning Plan v1

## 1. Very Empty Columns (id_07, id_08, id_21–id_27) — ~96% missing
Instead of deleting these columns, I checked if being empty or filled means 
something. Result: when these columns ARE filled, fraud rate is 8.2%+. When 
empty, fraud rate is only 3.4%. So being filled is actually a strong fraud 
signal — likely some kind of extra verification step that only runs on 
certain transactions.

**Action:** Create one flag — "was this extra check triggered?" (Yes/No) — 
then remove the original messy columns, since the flag captures the useful 
part.

## 2. Medium Empty Columns (40-70% missing)
Not empty enough to ignore, not full enough to fully trust.

**Action:** Fill numeric columns with the median value. Fill category columns 
with "unknown."

## 3. Slightly Empty Columns (under 20% missing)
Examples: email domain fields, device type.

**Action:** Fill with "unknown" as its own category. Don't guess a real value, 
don't delete the row.

## 4. D-Columns (time-gap features, D1–D15)
Some of these had a few negative values, which seemed odd at first (time gaps 
shouldn't be negative). I checked if these negative values were linked to 
fraud — they weren't; only 2 to 15 rows had this issue out of 590,540, too 
small to mean anything.

**Action:** Leave these columns as they are. Not worth changing anything over 
such a tiny number of rows.

## 5. Date/Time Column Fix
TransactionDT isn't a real date — it's a countdown of seconds from some 
starting point. So there's no "date format" to fix.

**Action:** Convert it into "hour of day" so I can check things like late-night 
transaction patterns later.

## 6. Category Spelling Check
Checked ProductCD and DeviceType for typos or inconsistent spelling (like 
"Mobile" vs "mobile"). Both were clean — no issues found.

**Action:** No changes needed.

## 7. Duplicate Check
Checked if any transaction ID repeats. None found in either table.

**Action:** No changes needed.

## Summary
Every decision above was tested with real numbers, not assumed. The biggest 
finding: columns that looked "too empty to matter" (id_07, id_08, id_21–id_27) 
actually contain one of the strongest fraud signals in the whole dataset.
