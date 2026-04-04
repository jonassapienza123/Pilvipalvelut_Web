#!/bin/bash

REPORT="analysis_report.txt"

echo "Repository analysis report" > "$REPORT"
echo "=========================" >> "$REPORT"
echo "" >> "$REPORT"

echo "Detected languages:" | tee -a "$REPORT"

found_language=false

find . -type f -name "*.py" | grep -q . && echo "- Python" | tee -a "$REPORT" && found_language=true
find . -type f -name "*.js" | grep -q . && echo "- JavaScript" | tee -a "$REPORT" && found_language=true
find . -type f -name "*.ts" | grep -q . && echo "- TypeScript" | tee -a "$REPORT" && found_language=true
find . -type f -name "*.java" | grep -q . && echo "- Java" | tee -a "$REPORT" && found_language=true
find . -type f -name "*.cpp" | grep -q . && echo "- C++" | tee -a "$REPORT" && found_language=true
find . -type f -name "*.c" | grep -q . && echo "- C" | tee -a "$REPORT" && found_language=true
find . -type f -name "*.cs" | grep -q . && echo "- C#" | tee -a "$REPORT" && found_language=true
find . -type f -name "*.php" | grep -q . && echo "- PHP" | tee -a "$REPORT" && found_language=true
find . -type f -name "*.rb" | grep -q . && echo "- Ruby" | tee -a "$REPORT" && found_language=true
find . -type f -name "*.go" | grep -q . && echo "- Go" | tee -a "$REPORT" && found_language=true
find . -type f -name "*.html" | grep -q . && echo "- HTML" | tee -a "$REPORT" && found_language=true
find . -type f -name "*.css" | grep -q . && echo "- CSS" | tee -a "$REPORT" && found_language=true
find . -type f -name "*.sh" | grep -q . && echo "- Shell" | tee -a "$REPORT" && found_language=true

if [ "$found_language" = false ]; then
  echo "- No known languages detected" | tee -a "$REPORT"
fi

echo "" | tee -a "$REPORT"
echo "Design patterns detected:" | tee -a "$REPORT"

found_pattern=false

if grep -R -E "getInstance|static[[:space:]]+.*instance" . --exclude="$REPORT" --exclude="analysoi.sh" >/dev/null 2>&1; then
  echo "- Singleton" | tee -a "$REPORT"
  found_pattern=true
fi

if grep -R -E "create[A-Z]|factory" . --exclude="$REPORT" --exclude="analysoi.sh" >/dev/null 2>&1; then
  echo "- Factory Method" | tee -a "$REPORT"
  found_pattern=true
fi

if grep -R -E "Strategy|interface" . --exclude="$REPORT" --exclude="analysoi.sh" >/dev/null 2>&1; then
  echo "- Strategy" | tee -a "$REPORT"
  found_pattern=true
fi

if grep -R -E "notify|subscribe|observer" . --exclude="$REPORT" --exclude="analysoi.sh" >/dev/null 2>&1; then
  echo "- Observer" | tee -a "$REPORT"
  found_pattern=true
fi

if grep -R -E "Decorator|wrap" . --exclude="$REPORT" --exclude="analysoi.sh" >/dev/null 2>&1; then
  echo "- Decorator" | tee -a "$REPORT"
  found_pattern=true
fi

if [ "$found_pattern" = false ]; then
  echo "- No common design patterns detected with current heuristics" | tee -a "$REPORT"
fi

echo "" | tee -a "$REPORT"
echo "Analysis complete. Report saved to $REPORT" | tee -a "$REPORT"