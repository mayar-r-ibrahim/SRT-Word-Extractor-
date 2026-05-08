@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ============================================================
echo SRT to CSV Word Extractor
echo ============================================================
echo.

:: =================== SRT to TXT Conversion ===================
if exist "*.srt" (
    echo Converting SRT files to TXT...
    echo.
    for %%f in (*.srt) do (
        echo Processing: %%f
        findstr /v /r "^[0-9][0-9]*$" "%%f" | findstr /v /c:"-->" | findstr /v /r "^$" > "%%~nf.txt"
        echo Created: %%~nf.txt
    )
    echo.
) else (
    echo No SRT files found. Skipping conversion.
    echo.
)

:: =================== TXT to CSV Word Extraction ===================
:: Check if any TXT files exist after conversion
if not exist "*.txt" (
    echo No TXT files found to process. Please place some .txt or .srt files.
    pause
    exit /b
)

:: Create output folder for CSV files
set "OUTDIR=output"
if not exist "%OUTDIR%" mkdir "%OUTDIR%"

:: Default filter settings
set MIN_LENGTH=3
set TO_LOWERCASE=1
set REMOVE_WITH_DIGITS=1

echo Current filters:
echo   - Minimum word length: %MIN_LENGTH% characters (words shorter will be ignored)
echo   - Convert to lowercase: YES
echo   - Remove words containing digits/symbols (like emails, URLs): YES
echo.
echo Choose an option:
echo 1. Extract all words (with duplicates, after filtering)
echo 2. Extract unique words (no duplicates, after filtering)
echo 3. Unique words + word count per file
echo 4. Create separate CSV files for each letter (A_words.csv, B_words.csv...)
echo.
set /p choice="Enter number (1-4): "

if "%choice%"=="1" goto mode1
if "%choice%"=="2" goto mode2
if "%choice%"=="3" goto mode3
if "%choice%"=="4" goto mode4
echo Invalid choice. Exiting.
pause
exit /b

:mode1
echo Processing: extracting all words with filters...
for %%f in (*.txt) do (
    echo Processing: %%f
    powershell -Command "$minLen = %MIN_LENGTH%; $text = Get-Content '%%f' -Raw -Encoding UTF8; $words = $text -replace '\d+',' ' -replace '[^\p{L}\s]',' ' -replace '\s+',' ' -split ' ' | Where-Object { $_ -match '^\p{L}{%MIN_LENGTH%,}$' -and $_ -notmatch '[\d@#\$%%\^&*()+=<>?/\\|]' } | ForEach-Object { $_.ToLower() }; $outPath = '%OUTDIR%\%%~nf_all_words_filtered.csv'; $words | Set-Content -Path $outPath -Encoding UTF8"
)
echo Done. Files saved in "%OUTDIR%" folder: *_all_words_filtered.csv
pause
exit /b

:mode2
echo Processing: extracting UNIQUE words with filters...
for %%f in (*.txt) do (
    echo Processing: %%f
    powershell -Command "$minLen = %MIN_LENGTH%; $text = Get-Content '%%f' -Raw -Encoding UTF8; $words = $text -replace '\d+',' ' -replace '[^\p{L}\s]',' ' -replace '\s+',' ' -split ' ' | Where-Object { $_ -match '^\p{L}{%MIN_LENGTH%,}$' -and $_ -notmatch '[\d@#\$%%\^&*()+=<>?/\\|]' } | ForEach-Object { $_.ToLower() } | Sort-Object | Get-Unique; $outPath = '%OUTDIR%\%%~nf_unique_words_filtered.csv'; $words | Set-Content -Path $outPath -Encoding UTF8"
)
echo Done. Files saved in "%OUTDIR%" folder: *_unique_words_filtered.csv
pause
exit /b

:mode3
echo Processing: unique words with frequency count...
for %%f in (*.txt) do (
    echo Processing: %%f
    powershell -Command "$minLen = %MIN_LENGTH%; $text = Get-Content '%%f' -Raw -Encoding UTF8; $words = $text -replace '\d+',' ' -replace '[^\p{L}\s]',' ' -replace '\s+',' ' -split ' ' | Where-Object { $_ -match '^\p{L}{%MIN_LENGTH%,}$' -and $_ -notmatch '[\d@#\$%%\^&*()+=<>?/\\|]' } | ForEach-Object { $_.ToLower() }; $grouped = $words | Group-Object | Select-Object Name, Count; $outPath = '%OUTDIR%\%%~nf_count_filtered.csv'; $grouped | Export-Csv -Path $outPath -NoTypeInformation -Encoding UTF8"
)
echo Done. Files saved in "%OUTDIR%" folder: *_count_filtered.csv
pause
exit /b

:mode4
echo Processing: separate CSV files for each letter (filtered)...
for %%f in (*.txt) do (
    echo Processing: %%f
    powershell -Command "$minLen = %MIN_LENGTH%; $text = Get-Content '%%f' -Raw -Encoding UTF8; $words = $text -replace '\d+',' ' -replace '[^\p{L}\s]',' ' -replace '\s+',' ' -split ' ' | Where-Object { $_ -match '^\p{L}{%MIN_LENGTH%,}$' -and $_ -notmatch '[\d@#\$%%\^&*()+=<>?/\\|]' } | ForEach-Object { $_.ToLower() }; $groups = $words | Group-Object { $_[0].ToString().ToUpper() }; foreach($g in $groups){ $outFile = '%OUTDIR%\%%~nf_' + $g.Name + '_filtered.csv'; $g.Group | Set-Content -Path $outFile -Encoding UTF8 }"
)
echo Done. Files saved in "%OUTDIR%" folder: *_filtered.csv
pause
exit /b

