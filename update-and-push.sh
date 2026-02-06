#!/bin/bash

# סקריפט לעדכון והעלאה ל-GitHub
# מערכת הגרלות מתקדמת לקמפיין פורים

echo "🚀 מעדכן ומעלה ל-GitHub..."
echo "=========================="
echo ""

cd "$(dirname "$0")"

# בדיקת Git
if ! command -v git &> /dev/null; then
    echo "❌ שגיאה: Git לא מותקן"
    exit 1
fi

echo "📁 תיקייה: $(pwd)"
echo ""

# עדכון remote
echo "1️⃣  מעדכן remote repository..."
git remote remove origin 2>/dev/null
git remote add origin https://github.com/shlomo-yeshiva/Lottery-system.git
echo "✅ Remote עודכן: https://github.com/shlomo-yeshiva/Lottery-system.git"
echo ""

# הוספת קבצים
echo "2️⃣  מוסיף קבצים..."
git add .
echo "✅ קבצים נוספו"
echo ""

# יצירת commit (אם יש שינויים)
echo "3️⃣  בודק שינויים..."
if git diff --staged --quiet; then
    echo "ℹ️  אין שינויים חדשים להעלאה"
else
    echo "📝 יוצר commit..."
    git commit -m "Update: מערכת הגרלות מתקדמת לקמפיין פורים

- מערכת הגרלות עם אפקטים ויזואליים מרשימים
- תמיכה בטעינת שמות מקובץ Excel
- זיקוקים בסגנון Google Doodle
- עיצוב רספונסיבי ומודרני
- README והוראות העלאה"
    echo "✅ Commit נוצר"
fi
echo ""

# העלאה
echo "4️⃣  מעלה ל-GitHub..."
echo "📤 זה עלול לקחת כמה רגעים..."
echo ""

git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "✅ הפרויקט הועלה בהצלחה ל-GitHub!"
    echo "=========================================="
    echo ""
    echo "🔗 הקישור לפרויקט:"
    echo "   https://github.com/shlomo-yeshiva/Lottery-system"
    echo ""
else
    echo ""
    echo "❌ שגיאה בהעלאה"
    echo ""
    echo "💡 פתרונות אפשריים:"
    echo "   1. ודא שיש לך חיבור לאינטרנט"
    echo "   2. אם נדרש אימות, השתמש ב-Personal Access Token"
    echo "   3. נסה להריץ ידנית:"
    echo "      git push -u origin main"
    echo ""
fi
