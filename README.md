# SRT-Word-Extractor-
SRT Word Extractor for Language Learners (bat)

# SRT Word Extractor for Language Learners

A Windows batch tool that converts `.srt` subtitle files into filtered word lists (CSV),  
helping English learners **prepare vocabulary before watching a movie or TV series**.

By extracting the unique words from subtitles, removing those you already know, and then translating the rest with an AI tool, you can dramatically improve comprehension and enjoyment.

---

## Features

- Converts `.srt` files to plain text (removing timestamps and line numbers)
- Extracts words from the subtitle text with smart filtering:
  - Minimum word length (default: 3 characters)
  - Removes numbers, email addresses, URLs, and punctuation
  - Converts all words to lowercase
- Multiple output modes:
  1. **All words** (with duplicates kept)
  2. **Unique words** (no duplicates)
  3. **Unique words + frequency count** (two columns: word, count)
  4. **Separate files by first letter** (A_words.csv, B_words.csv, …)
- Works on all `.srt` and `.txt` files in the same folder
- Output is UTF-8 encoded CSV, ready for Excel, Google Sheets, or AI tools
- No installation required – just a Windows computer with PowerShell

---

## Requirements

- Windows 7 or later
- PowerShell (included by default in Windows)
- The script must be placed in a folder that also contains your `.srt` (or `.txt`) subtitle files

---

## Installation

1. **Download** the script file (e.g., `SRT_Word_Extractor.bat`) from this repository.
2. Save it to a folder on your computer (e.g., `C:\Subtitles`).
3. Place the subtitle files you want to process (`.srt`) into the **same folder**.
4. Double‑click the `.bat` file to run it.

> **Note:** If Windows SmartScreen blocks the file, click “More info” → “Run anyway”.  
> The script **does not** modify your original subtitle files; it only reads them.

---

## Detailed Usage Guide

### 1. Get the subtitle file (.srt)
Download the English subtitles for the movie or episode you plan to watch.  
Sites like [opensubtitles.org](https://www.opensubtitles.org) offer many subtitle files.

### 2. Place the `.srt` in the script folder
Put the downloaded file(s) into the same directory as the batch script.  
You can process **multiple files at once** – the script handles each one separately.

### 3. Run the script
Double‑click the `.bat` file.  
A command‑line window opens. The script first converts any `.srt` files to plain text,  
then asks you to choose an extraction mode.

### 4. Choose the extraction mode
Select **mode 2** or **mode 3** for vocabulary study:

- **Mode 2 (`Unique words`)** – gives you a CSV with **one column** (each unique word once).
- **Mode 3 (`Unique words + word count`)** – gives you a CSV with **two columns**:  
  `Name` (the word) and `Count` (how many times it appears). This helps you prioritise frequent words.

(Other modes are explained below.)

### 5. Pick your preferred mode by entering `1`, `2`, `3`, or `4`
After selection, the script processes all `.txt` files (created from `.srt`) and saves the result  
inside a new folder named `output`.

### 6. Open the CSV file
Navigate to the `output` folder. You will see files like:

- `MovieName_unique_words_filtered.csv` (mode 2)
- `MovieName_count_filtered.csv` (mode 3)

Open the file with **Microsoft Excel**, **Google Sheets**, or any text editor.

### 7. Remove words you already know
- In the spreadsheet, delete all rows that contain words you are confident you understand.
- Leave only the **unknown** words.
- If using mode 3, you may also sort by the `Count` column to keep the most common unknown words.

### 8. Translate the remaining words
- **Option A – AI tool:** Upload the cleaned CSV (or copy the word column) to an AI like ChatGPT, Claude, or DeepL.  
  Ask it to: *“Add a translation column next to each English word”*.  
  You’ll get back a two‑column list: English word and its translation (which you can place in **column B**).
- **Option B – Manual:** Use a dictionary or Google Translate and fill translations yourself.

### 9. Study before you watch
Review the vocabulary list. Knowing key words in advance will make the movie much more understandable and enjoyable.

---

## Workflow Summary (for English learners)
Download SRT file

Put SRT + script together

Run script → choose mode 2 or 3

Open output CSV

Delete known words

Use AI tool to get translations

Study the list

Watch the film!


---

## Extraction Modes Explained

| Mode | Description | Best for |
|------|-------------|----------|
| 1 – **All words** | Every word from the subtitles (duplicates kept) | Full‑text analysis, not recommended for vocab study |
| 2 – **Unique words** | Each distinct word appears only once | Simple unknown‑word list |
| 3 – **Unique + count** | Two columns: Word, Frequency | Prioritising high‑frequency unknown words |
| 4 – **Separate by letter** | One CSV per letter (A_words.csv, B_words.csv, …) | Organising vocabulary alphabetically |

### Default filter settings
- Minimum word length: **3 characters** – words shorter than this are ignored (you can change it, see Customization).
- All words are converted to **lowercase**.
- Words containing **digits or special symbols** (like emails, URLs, `@`, `#`, `$`, etc.) are excluded – keeping only real words.

---

## Output Files

All results are placed in a subfolder named `output`.  
File naming convention:

- `*_all_words_filtered.csv`
- `*_unique_words_filtered.csv`
- `*_count_filtered.csv`
- `*_[letter]_filtered.csv` (for mode 4)

The `*` is the original `.srt`/`.txt` filename without extension.  
All CSV files use **UTF-8 encoding**, which works correctly with Excel, Google Sheets, and international characters (e.g., accents, ç, ñ).

---

## Customization

You can change the **minimum word length** by editing the line near the top of the script:

```batch
set MIN_LENGTH=3
For example, to keep words with at least 2 letters:
set MIN_LENGTH=2

You can also turn off the lowercase conversion or digit‑removal by changing the 1 to 0 in:


set TO_LOWERCASE=1
set REMOVE_WITH_DIGITS=1

(Note: the current version uses hard‑coded lowercase and digit removal in PowerShell; if you need those switches, you’ll need to adjust the PowerShell commands accordingly – but the defaults are ideal for vocabulary study.)


Advanced Tips
If you already have cleaned .txt files (one word per line or raw text), you can skip the SRT conversion; just place the .txt files in the folder and run the script – it will still extract words.

Mode 3 gives a frequency count. You can sort by count descending in Excel to see the most common words first – often the most essential.

For long movies or series, consider processing one episode at a time to keep the word list manageable.

The script works on any language that uses letters (e.g., French, Spanish, Italian) – just replace the English subtitles with the desired language. The filtering removes digits and symbols but keeps accented characters.

Troubleshooting
“No .srt files found”
→ Make sure the .srt files are in the same folder as the script, not in a subfolder.

Script opens and closes immediately
→ Run it from a command prompt manually or check for any error by adding pause at the end.
If the problem persists, ensure PowerShell execution policy allows scripts (usually fine for local batch files).

CSV looks garbled in Excel
→ The file is UTF‑8 without BOM. In Excel, use “Data” → “From Text/CSV” and choose UTF‑8 encoding.
Google Sheets handles UTF‑8 natively.

Words like “I’m”, “don’t” appear as separate parts
→ The script removes apostrophes as punctuation. To keep contractions like “don’t”, you would need to modify the PowerShell regular expression. For vocabulary study, the base word (e.g., “don”) can still be useful.

Contributing
Feel free to open issues or pull requests if you have ideas for improvements.
Keep the tool simple and beginner‑friendly.

