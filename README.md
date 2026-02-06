<!DOCTYPE html>
<html lang="he" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>מערכת הגרלות מתקדמת - הת״ת</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="logo-container">
        <img src="https://i.postimg.cc/mLbCBdyy/lwgw-t-t-dhws.png" alt="לוגו המוסד">
    </div>

    <div class="container">
        <div class="main-panel">
            <h1>🎲 מערכת הגרלות מתקדמת</h1>
            <p class="subtitle">הגרלה הוגנת ומרשימה עם אפקטים מיוחדים</p>

            <div class="upload-section">
                <h3 style="color: #ffd700; margin-bottom: 20px;">📁 העלאת קובץ Excel</h3>
                <div class="file-input-wrapper">
                    <input type="file" id="excelFile" accept=".xlsx,.xls" onchange="handleFileUpload(event)">
                    <label for="excelFile" class="file-input-label">📤 בחר קובץ Excel</label>
                </div>
                <div style="margin-top: 15px;">
                    <small style="color: rgba(255,215,0,0.7);">💡 טיפ: השמות צריכים להיות בעמודה הראשונה של הקובץ</small>
                </div>
                <div id="namesPreview" class="names-preview" style="display: none;"></div>
            </div>
            
            <div class="upload-section" style="margin-top: 20px; opacity: 0.7;">
                <h3 style="color: #ffd700; margin-bottom: 20px;">🖼️ העלאת תמונות מותאמות אישית</h3>
                <p style="color: rgba(255,215,0,0.7); font-size: 0.9rem; margin-bottom: 15px;">
                    💡 הרקע והלוגו כבר מובנים בתוכנה. אם הרקע לא מופיע, ניתן להעלות אותו כאן.
                </p>
                <div id="bgStatus" style="display: none; padding: 10px; margin: 10px 0; background: rgba(255,215,0,0.1); border-radius: 8px; border: 1px solid rgba(255,215,0,0.3);">
                    <small style="color: rgba(255,215,0,0.8);">⚠️ הרקע לא נטען מהשרת. ניתן להעלות רקע מקומי.</small>
                </div>
                <div style="display: flex; gap: 15px; justify-content: center; flex-wrap: wrap;">
                    <div class="file-input-wrapper">
                        <input type="file" id="backgroundFile" accept="image/*" onchange="handleBackgroundUpload(event)">
                        <label for="backgroundFile" class="file-input-label" style="font-size: 0.9rem; padding: 10px 25px;">🖼️ החלף רקע</label>
                    </div>
                    <div class="file-input-wrapper">
                        <input type="file" id="logoFile" accept="image/*" onchange="handleLogoUpload(event)">
                        <label for="logoFile" class="file-input-label" style="font-size: 0.9rem; padding: 10px 25px;">🏛️ החלף לוגו</label>
                    </div>
                </div>
            </div>

            <div class="stats">
                <div class="stat-item">
                    <div class="stat-value" id="totalNames">0</div>
                    <div class="stat-label">סה״כ שמות</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value" id="remainingNames">0</div>
                    <div class="stat-label">שמות נותרים</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value" id="winnersCount">0</div>
                    <div class="stat-label">זוכים</div>
                </div>
            </div>

            <div class="lottery-controls">
                <button class="btn btn-primary" id="startBtn" onclick="startLottery()" disabled>🎯 התחל הגרלה</button>
                <button class="btn btn-primary" id="nextWinnerBtn" onclick="startLottery()" disabled style="display: none;">🎲 הגרל זוכה נוסף</button>
                <button class="btn btn-secondary" onclick="resetLottery()">🔄 איפוס</button>
                <button class="btn btn-secondary" onclick="clearWinners()">🗑️ נקה זוכים</button>
            </div>

            <div class="winners-list" id="winnersList" style="display: none;">
                <h3 style="color: #ffd700; margin-bottom: 15px;">🏆 רשימת זוכים</h3>
                <div id="winnersContainer"></div>
            </div>
        </div>
    </div>

    <!-- אזור ההגרלה -->
    <div class="lottery-display" id="lotteryDisplay">
        <div class="fireworks-container" id="fireworksContainer"></div>
        <div class="names-scrolling" id="namesScrolling"></div>
        <div class="countdown-container" id="countdownContainer"></div>
        <div class="winner-display" id="winnerDisplay" style="display: none;">
            <div class="winner-title">🎉 הזוכה הוא:</div>
            <div class="winner-name" id="winnerName"></div>
            <div style="display: flex; gap: 15px; justify-content: center; margin-top: 30px; flex-wrap: wrap;">
                <button class="btn btn-primary" id="nextWinnerInDisplayBtn" onclick="startNextLottery()" style="display: none;">🎲 הגרל זוכה נוסף</button>
                <button class="btn btn-secondary" onclick="closeLotteryDisplay()">✅ סגור</button>
            </div>
        </div>
    </div>

    <script>
        let names = [];
        let remainingNames = [];
        let winners = [];
        let isLotteryRunning = false;
        let scrollInterval = null;
        let countdownInterval = null;
        let lotteryTimeout = null;
        let selectedWinner = null;

        // טעינת קובץ Excel
        function handleFileUpload(event) {
            const file = event.target.files[0];
            if (!file) return;

            const reader = new FileReader();
            reader.onload = function(e) {
                try {
                    const data = new Uint8Array(e.target.result);
                    const workbook = XLSX.read(data, { type: 'array' });
                    const firstSheet = workbook.Sheets[workbook.SheetNames[0]];
                    const jsonData = XLSX.utils.sheet_to_json(firstSheet, { header: 1 });

                    // חילוץ שמות מהעמודה הראשונה
                    names = [];
                    jsonData.forEach(row => {
                        if (row[0] && typeof row[0] === 'string' && row[0].trim()) {
                            names.push(row[0].trim());
                        }
                    });

                    if (names.length === 0) {
                        alert('לא נמצאו שמות בקובץ!');
                        return;
                    }

                    remainingNames = [...names];
                    // איפוס טקסט הכפתור
                    const startBtn = document.getElementById('startBtn');
                    if (startBtn) {
                        startBtn.textContent = '🎯 התחל הגרלה';
                    }
                    updateDisplay();
                    showNotification(`נטענו ${names.length} שמות בהצלחה!`, 'success');
                } catch (error) {
                    alert('שגיאה בקריאת הקובץ: ' + error.message);
                }
            };
            reader.readAsArrayBuffer(file);
        }

        function updateDisplay() {
            document.getElementById('totalNames').textContent = names.length;
            document.getElementById('remainingNames').textContent = remainingNames.length;
            document.getElementById('winnersCount').textContent = winners.length;

            // הצגת תצוגה מקדימה של שמות
            const preview = document.getElementById('namesPreview');
            if (names.length > 0) {
                preview.style.display = 'block';
                preview.innerHTML = names.slice(0, 20).map(name => `<span>${name}</span>`).join('') + 
                    (names.length > 20 ? `<span>... ועוד ${names.length - 20}</span>` : '');
            }

            // הצגת רשימת זוכים
            const winnersList = document.getElementById('winnersList');
            if (winners.length > 0) {
                winnersList.style.display = 'block';
                const container = document.getElementById('winnersContainer');
                container.innerHTML = winners.map((winner, index) => `
                    <div class="winner-item">
                        <div>
                            <span style="color: #ffd700; font-weight: 700;">#${index + 1}</span>
                            <span class="name">${winner.name}</span>
                        </div>
                        <div class="time">${winner.time}</div>
                    </div>
                `).join('');
            }

            // עדכון כפתורי הגרלה נוספת
            const startBtn = document.getElementById('startBtn');
            const nextWinnerBtn = document.getElementById('nextWinnerBtn');
            const nextWinnerInDisplayBtn = document.getElementById('nextWinnerInDisplayBtn');
            
            if (remainingNames.length > 0) {
                // יש שמות נותרים - אפשר להגריל
                if (winners.length === 0) {
                    // עדיין לא היה זוכה - הצג כפתור התחלה רגיל
                    startBtn.style.display = 'inline-block';
                    startBtn.disabled = false;
                    nextWinnerBtn.style.display = 'none';
                } else {
                    // כבר יש זוכים - הצג כפתור הגרלה נוספת
                    startBtn.style.display = 'none';
                    nextWinnerBtn.style.display = 'inline-block';
                    nextWinnerBtn.disabled = false;
                }
                
                // כפתור בתצוגת הזוכה
                if (nextWinnerInDisplayBtn) {
                    nextWinnerInDisplayBtn.style.display = 'inline-block';
                }
            } else {
                // אין שמות נותרים
                startBtn.disabled = true;
                startBtn.style.display = 'inline-block';
                startBtn.textContent = '✅ כל השמות נבחרו';
                nextWinnerBtn.style.display = 'none';
                if (nextWinnerInDisplayBtn) {
                    nextWinnerInDisplayBtn.style.display = 'none';
                }
                
                // הודעה אם יש זוכים אבל אין שמות נותרים
                if (winners.length > 0 && names.length > 0) {
                    console.log('כל השמות נבחרו בהגרלה');
                }
            }
        }

        // התחלת הגרלה
        function startLottery() {
            if (remainingNames.length === 0) {
                alert('אין עוד שמות להגרלה!');
                return;
            }

            if (isLotteryRunning) return;
            isLotteryRunning = true;

            // בחירת זוכה מראש (לבטיחות)
            const randomIndex = Math.floor(Math.random() * remainingNames.length);
            selectedWinner = remainingNames[randomIndex];

            const lotteryDisplay = document.getElementById('lotteryDisplay');
            const countdownContainer = document.getElementById('countdownContainer');
            const namesScrolling = document.getElementById('namesScrolling');
            const winnerDisplay = document.getElementById('winnerDisplay');

            lotteryDisplay.classList.add('active');
            winnerDisplay.style.display = 'none';
            countdownContainer.style.display = 'block';
            namesScrolling.style.display = 'flex';

            // ספירה לאחור
            let countdown = 5;
            countdownContainer.innerHTML = `<div class="countdown-number">${countdown}</div>`;

            countdownInterval = setInterval(() => {
                countdown--;
                if (countdown > 0) {
                    countdownContainer.innerHTML = `<div class="countdown-number">${countdown}</div>`;
                    createFirework();
                } else {
                    clearInterval(countdownInterval);
                    countdownContainer.style.display = 'none';
                    startScrollingNames();
                }
            }, 1000);

            // Timeout בטוח - תמיד מסיים את ההגרלה אחרי 10 שניות מקסימום
            if (lotteryTimeout) clearTimeout(lotteryTimeout);
            lotteryTimeout = setTimeout(() => {
                if (isLotteryRunning && selectedWinner) {
                    console.log('Timeout - מסיים הגרלה עם זוכה:', selectedWinner);
                    clearInterval(scrollInterval);
                    clearInterval(countdownInterval);
                    revealWinner(selectedWinner);
                }
            }, 10000);
        }

        // שמות רצים
        function startScrollingNames() {
            const namesScrolling = document.getElementById('namesScrolling');
            const totalDuration = 4000; // 4 שניות כולל האטה
            const fastDuration = 2500; // 2.5 שניות מהירות
            const slowDuration = 1500; // 1.5 שניות האטה
            const startTime = Date.now();
            const randomIndex = Math.floor(Math.random() * remainingNames.length);
            const winner = remainingNames[randomIndex];
            
            let iteration = 0;
            let lastDisplayedName = '';

            scrollInterval = setInterval(() => {
                const elapsed = Date.now() - startTime;
                iteration++;

                // שלב מהיר - שמות רצים מהר
                if (elapsed < fastDuration) {
                    const randomName = remainingNames[Math.floor(Math.random() * remainingNames.length)];
                    const nameElement = document.createElement('div');
                    nameElement.className = 'scrolling-name';
                    nameElement.textContent = randomName;
                    nameElement.style.animation = 'scrollName 0.08s linear';
                    nameElement.style.fontSize = '4rem';
                    namesScrolling.appendChild(nameElement);
                    lastDisplayedName = randomName;
                }
                // שלב האטה - שמות רצים לאט יותר
                else if (elapsed < fastDuration + slowDuration) {
                    const progress = (elapsed - fastDuration) / slowDuration;
                    const slowDown = 1 + (progress * 3); // האטה הדרגתית
                    
                    // הצגת שמות עם האטה
                    if (iteration % Math.floor(slowDown * 2) === 0) {
                        const randomName = remainingNames[Math.floor(Math.random() * remainingNames.length)];
                        const nameElement = document.createElement('div');
                        nameElement.className = 'scrolling-name';
                        nameElement.textContent = randomName;
                        nameElement.style.animation = `scrollName ${0.1 * slowDown}s linear`;
                        nameElement.style.fontSize = (4 + progress * 2) + 'rem';
                        namesScrolling.appendChild(nameElement);
                        lastDisplayedName = randomName;
                    }
                }
                // סיום - הצגת הזוכה
                else {
                    clearInterval(scrollInterval);
                    scrollInterval = null;
                    // ניקוי כל השמות
                    namesScrolling.innerHTML = '';
                    // הצגת הזוכה עם אפקט
                    setTimeout(() => {
                        if (selectedWinner) {
                            revealWinner(selectedWinner);
                        } else {
                            revealWinner(winner);
                        }
                    }, 300);
                    return;
                }

                // הסרת שמות ישנים
                const oldNames = namesScrolling.querySelectorAll('.scrolling-name');
                if (oldNames.length > 8) {
                    oldNames[0].remove();
                }
            }, 50);
        }

        // חשיפת הזוכה
        function revealWinner(name) {
            if (!name) {
                console.error('שגיאה: לא הועבר שם זוכה');
                if (remainingNames.length > 0) {
                    name = remainingNames[Math.floor(Math.random() * remainingNames.length)];
                } else {
                    alert('שגיאה בהגרלה - אין שמות זמינים');
                    closeLotteryDisplay();
                    return;
                }
            }

            console.log('חשיפת זוכה:', name);
            
            // ניקוי כל ה-intervals
            if (scrollInterval) {
                clearInterval(scrollInterval);
                scrollInterval = null;
            }
            if (countdownInterval) {
                clearInterval(countdownInterval);
                countdownInterval = null;
            }
            if (lotteryTimeout) {
                clearTimeout(lotteryTimeout);
                lotteryTimeout = null;
            }

            const namesScrolling = document.getElementById('namesScrolling');
            const winnerDisplay = document.getElementById('winnerDisplay');
            const winnerName = document.getElementById('winnerName');
            const countdownContainer = document.getElementById('countdownContainer');

            // וידוא שכל האלמנטים מוכנים
            if (namesScrolling) namesScrolling.innerHTML = '';
            if (countdownContainer) countdownContainer.style.display = 'none';
            if (namesScrolling) namesScrolling.style.display = 'none';
            
            if (winnerName) winnerName.textContent = name;
            if (winnerDisplay) winnerDisplay.style.display = 'block';

            // הוספת הזוכה לרשימה
            const now = new Date();
            winners.push({
                name: name,
                time: now.toLocaleTimeString('he-IL')
            });

            // הסרת השם מהרשימה
            remainingNames = remainingNames.filter(n => n !== name);

            // זיקוקים מרשימים בסגנון Google Doodle
            // זיקוקים ראשונים - מרוכזים במרכז
            for (let i = 0; i < 5; i++) {
                setTimeout(() => {
                    createFirework();
                }, i * 200);
            }
            
            // זיקוקים נוספים - מפוזרים על המסך
            setTimeout(() => {
                for (let i = 0; i < 10; i++) {
                    setTimeout(() => {
                        createFirework();
                        // זיקוק נוסף קצת אחרי (אפקט כפול)
                        setTimeout(() => createFirework(), 150);
                    }, i * 250);
                }
            }, 1000);

            // קונפטי
            createConfetti();
            
            // הודעה אם נגמרו השמות
            if (remainingNames.length === 0 && names.length > 0) {
                setTimeout(() => {
                    showNotification('🎊 כל השמות נבחרו בהגרלה!', 'success');
                }, 2000);
            }

            // עדכון תצוגה
            updateDisplay();
            isLotteryRunning = false;
            selectedWinner = null;
            
            // הצגת כפתור הגרלה נוספת אם יש שמות נותרים
            const nextWinnerInDisplayBtn = document.getElementById('nextWinnerInDisplayBtn');
            if (nextWinnerInDisplayBtn) {
                if (remainingNames.length > 0) {
                    nextWinnerInDisplayBtn.style.display = 'inline-block';
                } else {
                    nextWinnerInDisplayBtn.style.display = 'none';
                }
            }
            
            console.log('הזוכה הוא:', name);
            console.log('שמות נותרים:', remainingNames.length);
            showNotification(`🎉 הזוכה הוא: ${name}`, 'success');
        }

        // יצירת זיקוקים בסגנון Google Doodle
        function createFirework() {
            const container = document.getElementById('fireworksContainer');
            const colors = [
                '#ffd700', '#ff6b6b', '#4ecdc4', '#45b7d1', '#f9ca24', '#6c5ce7',
                '#ff4757', '#2ed573', '#ffa502', '#5f27cd', '#00d2d3', '#ff6348'
            ];
            
            // מיקום אקראי על המסך
            const x = Math.random() * window.innerWidth;
            const y = Math.random() * window.innerHeight;
            
            // צבע ראשי לזיקוק
            const mainColor = colors[Math.floor(Math.random() * colors.length)];
            
            // יצירת זיקוק מרכזי עם אפקט פולס
            const centerFirework = document.createElement('div');
            centerFirework.className = 'firework';
            centerFirework.style.left = x + 'px';
            centerFirework.style.top = y + 'px';
            centerFirework.style.background = mainColor;
            centerFirework.style.width = '12px';
            centerFirework.style.height = '12px';
            centerFirework.style.boxShadow = `0 0 20px ${mainColor}, 0 0 40px ${mainColor}, 0 0 60px ${mainColor}`;
            centerFirework.style.animation = 'fireworkPulse 0.4s ease-out forwards';
            container.appendChild(centerFirework);
            
            // יצירת חלקיקים שמתפוצצים בצורה מעגלית (כמו Google Doodle)
            const particleCount = 30 + Math.floor(Math.random() * 20);
            for (let i = 0; i < particleCount; i++) {
                const particle = document.createElement('div');
                particle.className = 'firework-particle';
                
                // זווית מעגלית אחידה
                const angle = (Math.PI * 2 * i) / particleCount;
                const distance = 80 + Math.random() * 120;
                const tx = Math.cos(angle) * distance;
                const ty = Math.sin(angle) * distance;
                
                // צבע אקראי או צבע ראשי
                const particleColor = Math.random() > 0.3 ? mainColor : colors[Math.floor(Math.random() * colors.length)];
                
                particle.style.left = x + 'px';
                particle.style.top = y + 'px';
                particle.style.background = particleColor;
                particle.style.boxShadow = `0 0 8px ${particleColor}, 0 0 16px ${particleColor}, 0 0 24px ${particleColor}`;
                particle.style.setProperty('--tx', tx + 'px');
                particle.style.setProperty('--ty', ty + 'px');
                const duration = 0.8 + Math.random() * 0.4;
                particle.style.animation = `particleMove ${duration}s cubic-bezier(0.4, 0, 0.2, 1) forwards`;
                particle.style.animationDelay = Math.random() * 0.05 + 's';
                
                // אפקט זוהר נוסף לחלקיקים גדולים יותר
                if (Math.random() > 0.7) {
                    particle.style.width = '6px';
                    particle.style.height = '6px';
                }
                
                container.appendChild(particle);
                
                // הסרת החלקיק אחרי האנימציה
                setTimeout(() => {
                    if (particle.parentNode) {
                        particle.remove();
                    }
                }, 1200);
            }
            
            // הסרת הזיקוק המרכזי
            setTimeout(() => {
                if (centerFirework.parentNode) {
                    centerFirework.remove();
                }
            }, 600);
        }

        // יצירת קונפטי
        function createConfetti() {
            const colors = ['#ffd700', '#ff6b6b', '#4ecdc4', '#45b7d1', '#f9ca24', '#6c5ce7'];
            
            for (let i = 0; i < 100; i++) {
                setTimeout(() => {
                    const confetti = document.createElement('div');
                    confetti.className = 'confetti';
                    confetti.style.left = Math.random() * 100 + '%';
                    confetti.style.background = colors[Math.floor(Math.random() * colors.length)];
                    confetti.style.width = (5 + Math.random() * 10) + 'px';
                    confetti.style.height = (5 + Math.random() * 10) + 'px';
                    confetti.style.animationDelay = Math.random() * 2 + 's';
                    confetti.style.animationDuration = (2 + Math.random() * 2) + 's';
                    document.body.appendChild(confetti);
                    
                    setTimeout(() => confetti.remove(), 5000);
                }, i * 20);
            }
        }

        // התחלת הגרלה נוספת (מהתצוגה)
        function startNextLottery() {
            closeLotteryDisplay();
            setTimeout(() => {
                startLottery();
            }, 500);
        }

        // סגירת תצוגת הגרלה
        function closeLotteryDisplay() {
            const lotteryDisplay = document.getElementById('lotteryDisplay');
            lotteryDisplay.classList.remove('active');
            
            if (scrollInterval) {
                clearInterval(scrollInterval);
                scrollInterval = null;
            }
            if (countdownInterval) {
                clearInterval(countdownInterval);
                countdownInterval = null;
            }
            if (lotteryTimeout) {
                clearTimeout(lotteryTimeout);
                lotteryTimeout = null;
            }
            
            document.getElementById('namesScrolling').innerHTML = '';
            document.getElementById('fireworksContainer').innerHTML = '';
            document.getElementById('winnerDisplay').style.display = 'none';
            document.getElementById('countdownContainer').style.display = 'none';
            
            isLotteryRunning = false;
            selectedWinner = null;
            
            // עדכון תצוגה אחרי סגירה
            updateDisplay();
        }

        // איפוס הגרלה
        function resetLottery() {
            if (confirm('האם אתה בטוח שברצונך לאפס את ההגרלה? כל הזוכים יישמרו, אבל כל השמות יהיו זמינים שוב להגרלה.')) {
                remainingNames = [...names];
                // איפוס טקסט הכפתור
                const startBtn = document.getElementById('startBtn');
                if (startBtn) {
                    startBtn.textContent = '🎯 התחל הגרלה';
                }
                updateDisplay();
                showNotification('ההגרלה אופסה - כל השמות זמינים שוב', 'success');
            }
        }

        // ניקוי זוכים
        function clearWinners() {
            if (confirm('האם אתה בטוח שברצונך למחוק את כל הזוכים? השמות יישארו זמינים להגרלה.')) {
                winners = [];
                updateDisplay();
                showNotification('רשימת הזוכים נוקתה', 'success');
            }
        }

        // הצגת התראה
        function showNotification(message, type = 'info') {
            const notification = document.createElement('div');
            notification.style.cssText = `
                position: fixed;
                top: 20px;
                left: 50%;
                transform: translateX(-50%);
                padding: 20px 40px;
                background: ${type === 'success' ? 'linear-gradient(135deg, #2ecc71, #27ae60)' : 'linear-gradient(135deg, #ffd700, #ffed4e)'};
                color: ${type === 'success' ? '#fff' : '#000'};
                border-radius: 10px;
                font-weight: 700;
                font-size: 1.1rem;
                z-index: 10000;
                box-shadow: 0 10px 30px rgba(0,0,0,0.5);
                animation: slideDown 0.3s ease-out;
            `;
            notification.textContent = message;
            document.body.appendChild(notification);
            
            setTimeout(() => {
                notification.style.animation = 'slideUp 0.3s ease-out';
                setTimeout(() => notification.remove(), 300);
            }, 3000);
        }

        // טעינת רקע מקומי
        function handleBackgroundUpload(event) {
            const file = event.target.files[0];
            if (!file) return;
            
            const reader = new FileReader();
            reader.onload = function(e) {
                // עדכון הרקע ב-::before
                const style = document.createElement('style');
                style.textContent = `
                    body::before {
                        background-image: url(${e.target.result}) !important;
                        opacity: 0.8 !important;
                    }
                `;
                document.head.appendChild(style);
                document.body.classList.remove('no-bg-image');
                showNotification('רקע עודכן בהצלחה!', 'success');
            };
            reader.readAsDataURL(file);
        }

        // טעינת לוגו מקומי
        function handleLogoUpload(event) {
            const file = event.target.files[0];
            if (!file) return;
            
            const reader = new FileReader();
            reader.onload = function(e) {
                const logoImg = document.querySelector('.logo-container img');
                if (logoImg) {
                    logoImg.src = e.target.result;
                    logoImg.style.display = 'block';
                    showNotification('לוגו עודכן בהצלחה!', 'success');
                }
            };
            reader.readAsDataURL(file);
        }

        // טעינה ראשונית
        window.addEventListener('load', function() {
            console.log('🎲 מערכת הגרלות מתקדמת נטענה בהצלחה!');
            console.log('🖼️ רקע: https://i.postimg.cc/WzWk5zLg/rq\'-ltwknt-hgrlwt-sl-ht-t.png');
            console.log('🏛️ לוגו: https://i.postimg.cc/mLbCBdyy/lwgw-t-t-dhws.png');
            
            // בדיקת טעינת רקע
            const bgImg = new Image();
            let bgLoaded = false;
            const bgStatusEl = document.getElementById('bgStatus');
            
            bgImg.onload = function() {
                console.log('✅ רקע נטען בהצלחה');
                bgLoaded = true;
                document.body.classList.remove('no-bg-image');
                if (bgStatusEl) bgStatusEl.style.display = 'none';
            };
            
            bgImg.onerror = function() {
                console.warn('⚠️ רקע לא נטען מהקישור המקורי - משתמש ברקע חלופי');
                document.body.classList.add('no-bg-image');
                if (bgStatusEl) bgStatusEl.style.display = 'block';
            };
            
            // נסה לטעון את הרקע
            bgImg.src = 'https://i.postimg.cc/WzWk5zLg/rq\'-ltwknt-hgrlwt-sl-ht-t.png';
            
            // בדיקה נוספת אחרי 2 שניות
            setTimeout(() => {
                if (!bgLoaded && (!bgImg.complete || bgImg.naturalWidth === 0)) {
                    document.body.classList.add('no-bg-image');
                    if (bgStatusEl) bgStatusEl.style.display = 'block';
                    console.log('💡 טיפ: ניתן להעלות רקע מקומי דרך הכפתור "החלף רקע"');
                }
            }, 2000);
            
            // בדיקת טעינת לוגו
            const logoImg = document.querySelector('.logo-container img');
            if (logoImg) {
                logoImg.onload = function() {
                    console.log('✅ לוגו נטען בהצלחה');
                    this.style.display = 'block';
                };
                logoImg.onerror = function() {
                    console.warn('⚠️ לוגו לא נטען - ניתן להעלות לוגו מקומי');
                };
            }
        });
    </script>
</body>
</html>
