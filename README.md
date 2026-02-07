
<html lang="he" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>מערכת הגרלות מתקדמת - הת״ת</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <style>
@import url('https://fonts.googleapis.com/css2?family=Heebo:wght@300;400;500;700;900&display=swap');

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Heebo', -apple-system, BlinkMacSystemFont, sans-serif;
    background-color: #0a0a0a;
    color: #ffffff;
    min-height: 100vh;
    overflow-x: hidden;
    overflow-y: auto;
    position: relative;
    -webkit-overflow-scrolling: touch;
}

body::before {
    content: '';
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: url('https://i.postimg.cc/WzWk5zLg/rq\'-ltwknt-hgrlwt-sl-ht-t.png');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    background-attachment: fixed;
    z-index: 0;
    opacity: 0.8;
    transition: opacity 0.5s ease;
    pointer-events: none;
}

/* רקע חלופי אם התמונה לא נטענת */
body.no-bg-image::before {
    background-image: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 25%, #2d2d2d 50%, #1a1a1a 75%, #0a0a0a 100%);
    opacity: 1;
}

body::after {
    content: '';
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    z-index: 1;
    pointer-events: none;
}

.container {
    position: relative;
    z-index: 10;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    padding: 20px;
    padding-bottom: 60px;
    overflow-y: auto;
    overflow-x: hidden;
}

.logo-container {
    position: fixed;
    top: 20px;
    right: 20px;
    z-index: 5;
    animation: logoFloat 3s ease-in-out infinite;
}

.logo-container img {
    max-width: 200px;
    height: auto;
    filter: drop-shadow(0 0 20px rgba(255, 215, 0, 0.5));
    display: block;
    object-fit: contain;
}

.logo-container img[src=""],
.logo-container img:not([src]) {
    display: none;
}

@keyframes logoFloat {
    0%, 100% { transform: translateY(0px); }
    50% { transform: translateY(-10px); }
}

.main-panel {
    background: linear-gradient(135deg, rgba(0, 0, 0, 0.98) 0%, rgba(20, 20, 20, 0.99) 100%);
    backdrop-filter: blur(10px);
    border-radius: 30px;
    padding: 40px;
    padding-bottom: 60px;
    border: 2px solid rgba(255, 215, 0, 0.5);
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.9), 0 0 50px rgba(255, 215, 0, 0.2), inset 0 0 30px rgba(0, 0, 0, 0.5);
    max-width: 900px;
    width: 100%;
    text-align: center;
    position: relative;
    z-index: 11;
    margin: 20px 0;
    margin-bottom: 40px;
    overflow: visible;
    min-height: fit-content;
}

h1 {
    font-size: 3rem;
    font-weight: 900;
    color: #ffd700;
    text-shadow: 0 0 25px rgba(255, 215, 0, 0.7), 0 0 50px rgba(255, 215, 0, 0.4);
    margin-bottom: 10px;
    animation: titleGlow 2s ease-in-out infinite;
    will-change: text-shadow;
    transform: translateZ(0);
}

@keyframes titleGlow {
    0%, 100% { text-shadow: 0 0 30px rgba(255, 215, 0, 0.8), 0 0 60px rgba(255, 215, 0, 0.4); }
    50% { text-shadow: 0 0 50px rgba(255, 215, 0, 1), 0 0 100px rgba(255, 215, 0, 0.6); }
}

.subtitle {
    font-size: 1.2rem;
    color: rgba(255, 215, 0, 0.8);
    margin-bottom: 30px;
}

.upload-section {
    margin: 30px 0;
    padding: 30px;
    padding-bottom: 40px;
    background: rgba(255, 215, 0, 0.05);
    border-radius: 15px;
    border: 2px dashed rgba(255, 215, 0, 0.3);
    overflow: visible;
}

.file-input-wrapper {
    position: relative;
    display: inline-block;
    margin: 20px 0;
}

.file-input-wrapper input[type="file"] {
    position: absolute;
    opacity: 0;
    width: 100%;
    height: 100%;
    cursor: pointer;
}

.file-input-label {
    display: inline-block;
    padding: 15px 40px;
    background: linear-gradient(135deg, #ffd700 0%, #ffed4e 100%);
    color: #000;
    border-radius: 10px;
    font-weight: 700;
    font-size: 1.1rem;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 5px 15px rgba(255, 215, 0, 0.3);
}

.file-input-label:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(255, 215, 0, 0.5);
}

.names-preview {
    margin: 20px 0;
    max-height: 200px;
    overflow-y: auto;
    padding: 15px;
    background: rgba(0, 0, 0, 0.5);
    border-radius: 10px;
    text-align: right;
}

.names-preview span {
    display: inline-block;
    margin: 5px 10px;
    padding: 5px 15px;
    background: rgba(255, 215, 0, 0.1);
    border-radius: 20px;
    color: #ffd700;
}

.lottery-controls {
    margin: 30px 0;
}

.btn {
    padding: 18px 40px;
    border: none;
    border-radius: 15px;
    font-size: 1.2rem;
    font-weight: 700;
    cursor: pointer;
    transition: all 0.3s ease;
    margin: 10px;
    text-transform: uppercase;
    letter-spacing: 1px;
    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.3);
}

.btn-primary {
    background: linear-gradient(135deg, #ffd700 0%, #ffed4e 100%);
    color: #000;
}

.btn-primary:hover {
    transform: translateY(-3px) scale(1.05);
    box-shadow: 0 10px 30px rgba(255, 215, 0, 0.5);
}

.btn-secondary {
    background: linear-gradient(135deg, rgba(255, 215, 0, 0.2) 0%, rgba(255, 215, 0, 0.1) 100%);
    color: #ffd700;
    border: 2px solid rgba(255, 215, 0, 0.3);
}

.btn-secondary:hover {
    background: rgba(255, 215, 0, 0.3);
    transform: translateY(-2px);
}

.btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
    transform: none !important;
}

/* אזור ההגרלה */
.lottery-display {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.95);
    z-index: 5000;
    display: none;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    will-change: contents;
    transform: translateZ(0);
    backface-visibility: hidden;
}

.lottery-display.active {
    display: flex;
}

.countdown-container {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 5001;
}

.countdown-number {
    font-size: 15rem;
    font-weight: 900;
    color: #ffd700;
    text-shadow: 0 0 40px rgba(255, 215, 0, 0.7), 0 0 80px rgba(255, 215, 0, 0.5);
    animation: countdownPulse 0.5s ease-out;
    will-change: transform, opacity;
    transform: translateZ(0);
    backface-visibility: hidden;
}

@keyframes countdownPulse {
    0% { transform: scale(0.5); opacity: 0; }
    50% { transform: scale(1.2); }
    100% { transform: scale(1); opacity: 1; }
}

.names-scrolling {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    will-change: contents;
    transform: translateZ(0);
    backface-visibility: hidden;
    perspective: 1000px;
}

.scrolling-name {
    font-size: 4rem;
    font-weight: 900;
    color: #ffd700;
    text-shadow: 0 0 20px rgba(255, 215, 0, 0.6);
    white-space: nowrap;
    animation: scrollName 0.15s linear;
    position: absolute;
    will-change: transform;
    transform: translateZ(0);
    backface-visibility: hidden;
}

@keyframes scrollName {
    from { transform: translate3d(100%, 0, 0); }
    to { transform: translate3d(-100%, 0, 0); }
}

.winner-display {
    position: relative;
    z-index: 5002;
    text-align: center;
    animation: winnerReveal 1s ease-out;
}

@keyframes winnerReveal {
    0% { transform: scale(0); opacity: 0; }
    50% { transform: scale(1.2); }
    100% { transform: scale(1); opacity: 1; }
}

.winner-title {
    font-size: 3rem;
    color: #ffd700;
    margin-bottom: 30px;
    text-shadow: 0 0 30px rgba(255, 215, 0, 0.8);
    animation: titlePulse 2s ease-in-out infinite;
}

@keyframes titlePulse {
    0%, 100% { transform: scale(1); }
    50% { transform: scale(1.05); }
}

.winner-name {
    font-size: 6rem;
    font-weight: 900;
    color: #ffffff;
    text-shadow: 0 0 50px rgba(255, 215, 0, 1), 0 0 100px rgba(255, 215, 0, 0.8);
    margin: 30px 0;
    animation: nameGlow 1.5s ease-in-out infinite;
    background: linear-gradient(45deg, #ffd700, #ffffff, #ffd700);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    background-size: 200% 200%;
    animation: nameGlow 2s ease infinite;
}

@keyframes nameGlow {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
}

/* זיקוקים בסגנון Google Doodle */
.fireworks-container {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    pointer-events: none;
    z-index: 5003;
    overflow: hidden;
    will-change: contents;
    contain: layout style paint;
    transform: translateZ(0);
}

.firework {
    position: absolute;
    width: 6px;
    height: 6px;
    border-radius: 50%;
    pointer-events: none;
    will-change: transform, opacity;
    transform: translateZ(0);
    backface-visibility: hidden;
}

.firework-particle {
    position: absolute;
    width: 4px;
    height: 4px;
    border-radius: 50%;
    pointer-events: none;
    will-change: transform, opacity;
    transform: translateZ(0);
    backface-visibility: hidden;
}

@keyframes fireworkExplode {
    0% {
        opacity: 1;
        transform: scale(1);
    }
    100% {
        opacity: 0;
        transform: scale(0);
    }
}

@keyframes particleMove {
    0% {
        opacity: 1;
        transform: translate3d(0, 0, 0) scale(1);
    }
    50% {
        opacity: 0.8;
        transform: translate3d(calc(var(--tx) * 0.5), calc(var(--ty) * 0.5), 0) scale(0.7);
    }
    100% {
        opacity: 0;
        transform: translate3d(var(--tx), var(--ty), 0) scale(0.2);
    }
}

@keyframes fireworkPulse {
    0%, 100% {
        transform: scale(1);
        opacity: 1;
    }
    50% {
        transform: scale(1.5);
        opacity: 0.7;
    }
}

.confetti {
    position: fixed;
    width: 10px;
    height: 10px;
    background: #ffd700;
    position: absolute;
    animation: confettiFall 3s linear forwards;
    will-change: transform, opacity;
    transform: translateZ(0);
    backface-visibility: hidden;
}

@keyframes confettiFall {
    0% {
        transform: translate3d(0, -100vh, 0) rotate(0deg);
        opacity: 1;
    }
    100% {
        transform: translate3d(0, 100vh, 0) rotate(720deg);
        opacity: 0;
    }
}

.stats {
    display: flex;
    justify-content: space-around;
    margin: 30px 0;
    flex-wrap: wrap;
}

.stat-item {
    background: rgba(255, 215, 0, 0.1);
    padding: 15px 30px;
    border-radius: 10px;
    margin: 10px;
    border: 1px solid rgba(255, 215, 0, 0.3);
}

.stat-value {
    font-size: 2rem;
    font-weight: 700;
    color: #ffd700;
}

.stat-label {
    font-size: 0.9rem;
    color: rgba(255, 215, 0, 0.7);
    margin-top: 5px;
}

.winners-list {
    margin: 30px 0;
    max-height: 300px;
    overflow-y: auto;
    padding: 20px;
    padding-bottom: 30px;
    background: rgba(0, 0, 0, 0.5);
    border-radius: 15px;
    margin-bottom: 20px;
}

.winner-item {
    padding: 15px;
    margin: 10px 0;
    background: rgba(255, 215, 0, 0.1);
    border-radius: 10px;
    border-right: 4px solid #ffd700;
    display: flex;
    justify-content: space-between;
    align-items: center;
    animation: slideInRight 0.5s ease-out;
}

@keyframes slideInRight {
    from {
        transform: translateX(100%);
        opacity: 0;
    }
    to {
        transform: translateX(0);
        opacity: 1;
    }
}

.winner-item .name {
    font-size: 1.3rem;
    font-weight: 700;
    color: #ffd700;
}

.winner-item .time {
    color: rgba(255, 215, 0, 0.7);
    font-size: 0.9rem;
}

@keyframes slideDown {
    from {
        transform: translateX(-50%) translateY(-100%);
        opacity: 0;
    }
    to {
        transform: translateX(-50%) translateY(0);
        opacity: 1;
    }
}

@keyframes slideUp {
    from {
        transform: translateX(-50%) translateY(0);
        opacity: 1;
    }
    to {
        transform: translateX(-50%) translateY(-100%);
        opacity: 0;
    }
}

@media (max-width: 768px) {
    h1 {
        font-size: 2rem;
    }

    .winner-name {
        font-size: 3rem;
    }

    .countdown-number {
        font-size: 8rem;
    }

    .main-panel {
        padding: 20px;
    }
}
    </style>
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

        // שמות רצים - מותאם לביצועים
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
            let animationFrameId = null;
            const maxVisibleNames = 5; // הגבלת מספר שמות גלויים

            function animate() {
                const elapsed = Date.now() - startTime;
                iteration++;

                // שלב מהיר - שמות רצים מהר
                if (elapsed < fastDuration) {
                    if (iteration % 3 === 0) { // האטה - כל 3 frames במקום כל frame
                        const randomName = remainingNames[Math.floor(Math.random() * remainingNames.length)];
                        const nameElement = document.createElement('div');
                        nameElement.className = 'scrolling-name';
                        nameElement.textContent = randomName;
                        nameElement.style.animation = 'scrollName 0.15s linear';
                        nameElement.style.fontSize = '4rem';
                        nameElement.style.willChange = 'transform';
                        nameElement.style.transform = 'translateZ(0)'; // האצת GPU
                        namesScrolling.appendChild(nameElement);
                        lastDisplayedName = randomName;
                        
                        // הסרת שמות ישנים - רק אם יש יותר מדי
                        const oldNames = namesScrolling.querySelectorAll('.scrolling-name');
                        if (oldNames.length > maxVisibleNames) {
                            oldNames[0].remove();
                        }
                    }
                }
                // שלב האטה - שמות רצים לאט יותר
                else if (elapsed < fastDuration + slowDuration) {
                    const progress = (elapsed - fastDuration) / slowDuration;
                    const slowDown = 1 + (progress * 3); // האטה הדרגתית
                    
                    // הצגת שמות עם האטה
                    if (iteration % Math.floor(slowDown * 4) === 0) {
                        const randomName = remainingNames[Math.floor(Math.random() * remainingNames.length)];
                        const nameElement = document.createElement('div');
                        nameElement.className = 'scrolling-name';
                        nameElement.textContent = randomName;
                        nameElement.style.animation = `scrollName ${0.15 * slowDown}s linear`;
                        nameElement.style.fontSize = (4 + progress * 2) + 'rem';
                        nameElement.style.willChange = 'transform';
                        nameElement.style.transform = 'translateZ(0)';
                        namesScrolling.appendChild(nameElement);
                        lastDisplayedName = randomName;
                        
                        // הסרת שמות ישנים
                        const oldNames = namesScrolling.querySelectorAll('.scrolling-name');
                        if (oldNames.length > maxVisibleNames) {
                            oldNames[0].remove();
                        }
                    }
                }
                // סיום - הצגת הזוכה
                else {
                    if (animationFrameId) {
                        cancelAnimationFrame(animationFrameId);
                        animationFrameId = null;
                        window.scrollAnimationFrame = null;
                    }
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

                animationFrameId = requestAnimationFrame(animate);
                window.scrollAnimationFrame = animationFrameId;
            }
            
            animationFrameId = requestAnimationFrame(animate);
            window.scrollAnimationFrame = animationFrameId;
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
            // ביטול requestAnimationFrame אם קיים
            if (window.scrollAnimationFrame) {
                cancelAnimationFrame(window.scrollAnimationFrame);
                window.scrollAnimationFrame = null;
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

            // זיקוקים מרשימים בסגנון Google Doodle - מותאם לביצועים
            // זיקוקים ראשונים - מרוכזים במרכז (פחות זיקוקים)
            for (let i = 0; i < 3; i++) { // הורדנו מ-5 ל-3
                setTimeout(() => {
                    createFirework();
                }, i * 300); // האטה קצת
            }
            
            // זיקוקים נוספים - מפוזרים על המסך (פחות זיקוקים)
            setTimeout(() => {
                for (let i = 0; i < 6; i++) { // הורדנו מ-10 ל-6
                    setTimeout(() => {
                        createFirework();
                    }, i * 350); // האטה והסרת אפקט כפול
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

        // יצירת זיקוקים בסגנון Google Doodle - מותאם לביצועים
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
            centerFirework.style.boxShadow = `0 0 20px ${mainColor}, 0 0 40px ${mainColor}`;
            centerFirework.style.animation = 'fireworkPulse 0.4s ease-out forwards';
            centerFirework.style.willChange = 'transform, opacity';
            centerFirework.style.transform = 'translateZ(0)';
            container.appendChild(centerFirework);
            
            // יצירת חלקיקים שמתפוצצים בצורה מעגלית - פחות חלקיקים לביצועים טובים יותר
            const particleCount = 20 + Math.floor(Math.random() * 15); // הורדנו מ-30-50 ל-20-35
            
            // שימוש ב-DocumentFragment לביצועים טובים יותר
            const fragment = document.createDocumentFragment();
            
            for (let i = 0; i < particleCount; i++) {
                const particle = document.createElement('div');
                particle.className = 'firework-particle';
                
                // זווית מעגלית אחידה
                const angle = (Math.PI * 2 * i) / particleCount;
                const distance = 80 + Math.random() * 100; // קצת פחות מרחק
                const tx = Math.cos(angle) * distance;
                const ty = Math.sin(angle) * distance;
                
                // צבע אקראי או צבע ראשי
                const particleColor = Math.random() > 0.3 ? mainColor : colors[Math.floor(Math.random() * colors.length)];
                
                particle.style.left = x + 'px';
                particle.style.top = y + 'px';
                particle.style.background = particleColor;
                particle.style.boxShadow = `0 0 8px ${particleColor}, 0 0 16px ${particleColor}`;
                particle.style.setProperty('--tx', tx + 'px');
                particle.style.setProperty('--ty', ty + 'px');
                particle.style.willChange = 'transform, opacity';
                particle.style.transform = 'translateZ(0)';
                const duration = 0.8 + Math.random() * 0.4;
                particle.style.animation = `particleMove ${duration}s cubic-bezier(0.4, 0, 0.2, 1) forwards`;
                particle.style.animationDelay = Math.random() * 0.05 + 's';
                
                fragment.appendChild(particle);
                
                // הסרת החלקיק אחרי האנימציה
                setTimeout(() => {
                    if (particle.parentNode) {
                        particle.remove();
                    }
                }, 1200);
            }
            
            container.appendChild(fragment);
            
            // הסרת הזיקוק המרכזי
            setTimeout(() => {
                if (centerFirework.parentNode) {
                    centerFirework.remove();
                }
            }, 600);
        }

        // יצירת קונפטי - מותאם לביצועים
        function createConfetti() {
            const colors = ['#ffd700', '#ff6b6b', '#4ecdc4', '#45b7d1', '#f9ca24', '#6c5ce7'];
            const confettiCount = 50; // הורדנו מ-100 ל-50
            
            // שימוש ב-DocumentFragment לביצועים טובים יותר
            const fragment = document.createDocumentFragment();
            
            for (let i = 0; i < confettiCount; i++) {
                setTimeout(() => {
                    const confetti = document.createElement('div');
                    confetti.className = 'confetti';
                    confetti.style.left = Math.random() * 100 + '%';
                    confetti.style.background = colors[Math.floor(Math.random() * colors.length)];
                    confetti.style.width = (5 + Math.random() * 10) + 'px';
                    confetti.style.height = (5 + Math.random() * 10) + 'px';
                    confetti.style.animationDelay = Math.random() * 2 + 's';
                    confetti.style.animationDuration = (2 + Math.random() * 2) + 's';
                    confetti.style.willChange = 'transform, opacity';
                    confetti.style.transform = 'translateZ(0)';
                    fragment.appendChild(confetti);
                    
                    setTimeout(() => {
                        if (confetti.parentNode) {
                            confetti.remove();
                        }
                    }, 5000);
                }, i * 30); // האטה קצת - מ-20ms ל-30ms
            }
            
            document.body.appendChild(fragment);
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
            // ביטול requestAnimationFrame אם קיים
            if (window.scrollAnimationFrame) {
                cancelAnimationFrame(window.scrollAnimationFrame);
                window.scrollAnimationFrame = null;
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

        // טעינה ראשונית
        window.addEventListener('load', function() {
            console.log('🎲 מערכת הגרלות מתקדמת נטענה בהצלחה!');
            
            // בדיקת טעינת לוגו
            const logoImg = document.querySelector('.logo-container img');
            if (logoImg) {
                logoImg.onload = function() {
                    console.log('✅ לוגו נטען בהצלחה');
                    this.style.display = 'block';
                };
                logoImg.onerror = function() {
                    console.warn('⚠️ לוגו לא נטען');
                };
            }
        });
    </script>
</body>
</html>
