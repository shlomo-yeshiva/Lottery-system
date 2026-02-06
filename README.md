:root {
    --primary-gold: #D4AF37;
    --primary-gold-dark: #B8941F;
    --primary-gold-light: #F4D03F;
    --accent-gold: #FFD700;
    --cream: #F5E6D3;
    --cream-light: #FFF8DC;
    --cream-dark: #E8D5B7;
    --brown-dark: #3d2f1f;
    --brown-medium: #8B6F47;
    --brown-light: #A0826D;
    --text: #2a1f15;
    --muted: #8B6F47;
    --success: #10b981;
    --warning: #f59e0b;
    --error: #ef4444;
    --border: rgba(212, 175, 55, 0.3);
    --base-font-size: clamp(18px, 1.2vw, 24px);
    --large-font-size: clamp(24px, 1.8vw, 32px);
    --button-font-size: clamp(16px, 1.1vw, 20px);
    --nav-font-size: clamp(20px, 1.4vw, 26px);
}

body {
    font-family: 'Segoe UI', 'David', 'Arial Hebrew', sans-serif;
    background: linear-gradient(135deg, var(--cream) 0%, var(--cream-light) 50%, var(--cream-dark) 100%);
    color: var(--text);
    direction: rtl;
    font-size: var(--base-font-size);
    overflow-x: hidden;
    overflow-y: hidden;
    height: 100vh;
    -webkit-tap-highlight-color: transparent;
    -webkit-touch-callout: none;
    -webkit-user-select: none;
    user-select: none;
    touch-action: manipulation;
}

/* אפשר בחירת טקסט במקומות נחוצים */
input, textarea, select, .donor-name, .donor-details {
    -webkit-user-select: text;
    user-select: text;
}

.app-container {
    display: flex;
    height: 100vh;
    width: 100%;
}

/* תפריט ניווט בצד */
.sidebar-nav {
    max-width: clamp(260px, 18vw, 320px);
    min-width: 260px;
    background: linear-gradient(180deg, var(--cream) 0%, var(--cream-dark) 100%);
    box-shadow: 4px 0 30px rgba(212, 175, 55, 0.3);
    display: flex;
    flex-direction: column;
    z-index: 100;
    position: relative;
    height: 100%;
    overflow-y: auto;
    -webkit-overflow-scrolling: touch;
}

.logo-container {
    padding: clamp(24px, 2vw, 36px) clamp(20px, 1.5vw, 28px);
    text-align: center;
    border-bottom: 2px solid var(--border);
    background: rgba(255, 255, 255, 0.3);
}

.logo-img {
    max-width: 100%;
    height: auto;
    max-height: clamp(100px, 8vw, 140px);
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(212, 175, 55, 0.4);
    border: 2px solid var(--primary-gold);
    padding: clamp(6px, 0.5vw, 10px);
    background: white;
}

.nav-menu {
    flex: 1;
    padding: 20px 0;
    overflow-y: auto;
}

.nav-item {
    display: block;
    width: 100%;
    padding: 24px 36px;
    background: transparent;
    border: none;
    border-right: 4px solid transparent;
    color: var(--brown-dark);
    font-size: var(--nav-font-size);
    font-weight: 500;
    text-align: right;
    cursor: pointer;
    transition: all 0.3s ease;
    position: relative;
    min-height: 60px;
    display: flex;
    align-items: center;
    -webkit-tap-highlight-color: transparent;
}

.nav-item:hover,
.nav-item:focus {
    background: rgba(212, 175, 55, 0.15);
    border-right-color: var(--primary-gold);
    outline: none;
}

.nav-item:focus-visible {
    outline: 3px solid var(--primary-gold);
    outline-offset: -3px;
}

.nav-item.active {
    background: linear-gradient(135deg, rgba(245, 230, 211, 0.94) 0%, rgba(255, 248, 220, 0.94) 100%);
    border-right-color: var(--primary-gold);
    font-weight: 600;
    color: var(--brown-dark);
    box-shadow: inset 0 0 20px rgba(212, 175, 55, 0.1);
}

.nav-item.active::before {
    content: '';
    position: absolute;
    right: 0;
    top: 50%;
    transform: translateY(-50%);
    width: 0;
    height: 0;
    border-top: 8px solid transparent;
    border-bottom: 8px solid transparent;
    border-right: 8px solid var(--primary-gold);
}

/* אזור תוכן */
.content-area {
    flex: 1;
    display: flex; 
    flex-direction: column;
    overflow-x: hidden;
    overflow-y: auto;
    position: relative;
    height: 100%;
}

.content-section {
    display: none;
    flex: 1;
    overflow-y: auto;
    padding: clamp(30px, 3vw, 50px);
    position: relative;
    -webkit-overflow-scrolling: touch;
}

.content-section.active {
    display: flex;
    flex-direction: column;
}

/* דף הבית */
.home-section {
    position: relative;
    background: linear-gradient(135deg, rgba(245, 230, 211, 0.94) 0%, rgba(255, 248, 220, 0.94) 100%);
    min-height: 100%;
}

.home-section::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-image: url('http://i.postimg.cc/ZRMCLxgW/wgw-t-t-dhws.png');
    background-repeat: no-repeat;
    background-size: clamp(780px, 74vw, 1500px) auto;
    background-position: center center;
    opacity: 0.98;
    z-index: 0;
}

@media (max-width: 768px) {
    .home-section::before {
        background-size: clamp(440px, 88vw, 820px) auto;
        background-position: center center;
    }
}

.home-content {
    position: relative;
    z-index: 1;
    text-align: center;
    width: 100%;
    max-width: none;
    margin: 0;
    padding: 520px 40px 60px;
}

.home-title {
    font-size: clamp(36px, 4vw, 64px);
    color: var(--brown-dark);
    margin-bottom: clamp(20px, 2vw, 40px);
    text-shadow: 2px 2px 4px rgba(255, 255, 255, 0.8);
    font-weight: 700;
    line-height: 1.2;
}

@media (max-width: 768px) {
    .home-content {
        padding: 420px 20px 40px;
    }
}

.stats-grid {
    display: grid;
    grid-template-columns: repeat(3, minmax(240px, 1fr));
    gap: 30px;
    margin-top: 50px;
    justify-items: stretch;
}

.stats-grid .stat-card:nth-child(4) {
    grid-column: 2 / span 1;
}

@media (max-width: 920px) {
    .stats-grid {
        grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
    }
    .stats-grid .stat-card:nth-child(4) {
        grid-column: auto;
    }
}

.stat-card {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(20px);
    border: 2px solid var(--primary-gold);
    border-radius: 20px;
    padding: 30px;
    box-shadow: 0 8px 32px rgba(212, 175, 55, 0.3);
    text-align: center;
}

.stat-label {
    font-size: 16px;
    color: var(--muted);
    margin-bottom: 15px;
    font-weight: 500;
}

.stat-value {
    font-size: 36px;
    font-weight: 700;
    color: var(--primary-gold-dark);
    margin-bottom: 10px;
}

.stat-subvalue {
    font-size: 18px;
    color: var(--brown-medium);
}

/* כפתורים */
.btn {
    padding: 16px 32px;
    background: var(--primary-gold);
    color: white;
    border: none;
    border-radius: 10px;
    font-size: var(--button-font-size);
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    min-height: 52px;
    min-width: 120px;
    -webkit-tap-highlight-color: transparent;
    touch-action: manipulation;
}

.btn:hover,
.btn:focus {
    background: var(--primary-gold-dark);
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(212, 175, 55, 0.4);
    outline: none;
}

.btn:focus-visible {
    outline: 3px solid var(--primary-gold-light);
    outline-offset: 2px;
}

.btn:active {
    transform: translateY(0);
}

.btn-secondary {
    background: rgba(255, 255, 255, 0.9);
    color: var(--brown-dark);
    border: 2px solid var(--border);
    min-height: 52px;
    min-width: 120px;
}

.btn-secondary:hover,
.btn-secondary:focus {
    background: white;
    border-color: var(--primary-gold);
    outline: none;
}

.btn-secondary:focus-visible {
    outline: 3px solid var(--primary-gold-light);
    outline-offset: 2px;
}

.btn-danger {
    background: var(--error);
    min-height: 52px;
    min-width: 120px;
}

.btn-danger:hover,
.btn-danger:focus {
    background: #dc2626;
    outline: none;
}

.btn-danger:focus-visible {
    outline: 3px solid rgba(255, 255, 255, 0.5);
    outline-offset: 2px;
}

.btn-small {
    padding: 12px 20px;
    font-size: clamp(14px, 0.9vw, 16px);
    min-height: 44px;
    min-width: 100px;
}

/* סקרולבר */
::-webkit-scrollbar {
    width: 12px;
}

::-webkit-scrollbar-track {
    background: transparent;
}

::-webkit-scrollbar-thumb {
    background: var(--primary-gold);
    border-radius: 12px;
    box-shadow: inset 0 0 0 2px rgba(255, 255, 255, 0.4);
}

::-webkit-scrollbar-thumb:hover {
    background: var(--primary-gold-dark);
}

html,
body,
.content-area {
    scrollbar-width: thin;
    scrollbar-color: var(--primary-gold) transparent;
}

/* רספונסיבי */
@media (max-width: 1024px) {
    .sidebar-nav {
        width: 220px;
    }
}

@media (max-width: 768px) {
    .app-container {
        flex-direction: column;
    }

    .sidebar-nav {
        width: 100%;
        height: auto;
        flex-direction: row;
        border-left: none;
        border-bottom: 4px solid var(--primary-gold);
        max-width: 100%;
        min-width: 100%;
    }

    .nav-menu {
        display: flex;
        flex-direction: row;
        overflow-x: auto;
    }

    .nav-item {
        padding: 18px 24px;
        white-space: nowrap;
        border-right: none;
        border-bottom: 4px solid transparent;
        min-height: 56px;
    }

    .nav-item.active {
        border-bottom-color: var(--primary-gold);
        border-right: none;
    }

    .nav-item.active::before {
        display: none;
    }

    .logo-container {
        padding: 15px;
    }

    .logo-img {
        max-height: 60px;
    }

    .content-section {
        padding: 20px;
    }
}

/* מסכים גדולים */
@media (min-width: 1920px) {
    .sidebar-nav {
        width: 320px;
    }

    .content-section {
        padding: 50px 60px;
    }

    .home-title {
        font-size: 56px;
    }

    .stat-card {
        padding: 36px;
    }
}
