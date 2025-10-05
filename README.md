# 🎓 Aplicație Completă de Pregătire pentru Interviu - Trimble Internship

Aplicație full-stack construită cu React, TypeScript, Supabase și Google Gemini AI pentru pregătirea completă a interviului de internship la Trimble (C# / .NET / Angular).

## ✨ Funcționalități Principale

### 📚 Studiu Interactiv
- **186+ termeni tehnici** organizați în 9 categorii
- ELI5, definiții formale, răspunsuri pentru interviu
- Exemple de cod în C# și TypeScript
- Diagrame vizuale și pitfalls comune

### 🤖 AI-Powered Features
- **AI Tutor** - Asistent personal alimentat de Google Gemini
- **Quiz Practice** - Evaluare automată AI a răspunsurilor
- **AI Features** - Generare quizuri, explicații concepte, întrebări comportamentale

### 📖 BIBLIA GIGA - Ghid Interviu
- **212+ întrebări** comprehensive de interviu
- 26 categorii (OOP, C#, SQL, Angular, React, Agile, Cloud, etc.)
- Sfaturi specifice Trimble
- Pregătire completă pentru interviu tehnic + HR

### 🧪 Coding Labs
- Exerciții practice de cod
- Teste automate pentru verificare
- Algoritmi și structuri de date

### ⏱️ Productivity Tools
- Pomodoro Timer integrat
- Export notes în Markdown
- Keyboard shortcuts

## 🚀 Quick Start

### 1. Instalare Dependințe

```bash
npm install
```

### 2. ⚠️ IMPORTANT: Configurare Google Gemini API Key

**Feature-urile AI NU vor funcționa fără API key!**

1. Obține un API key **GRATUIT** de la Google:
   - Vizitează: https://aistudio.google.com/apikey
   - Autentifică-te cu contul Google
   - Click "Create API Key"
   - Copiază key-ul generat

2. Adaugă key-ul în fișierul `.env`:
   ```env
   VITE_GEMINI_API_KEY=AIzaSy...(your-key-here)
   ```

3. **Ghid Detaliat:** Vezi `GEMINI_API_KEY_SETUP.md` pentru instrucțiuni pas-cu-pas

### 3. Pornire Aplicație

```bash
npm run dev
```

Aplicația va rula la: http://localhost:5173

## 📋 Cerințe Sistem

- Node.js 18+
- npm sau yarn
- Cont Google (pentru API key gratuit)

## 🗂️ Structura Aplicației

```
src/
├── components/
│   ├── AITutor.tsx           # AI chat pentru explicații
│   ├── QuizPractice.tsx      # Quiz cu evaluare AI
│   ├── BibliaGiga.tsx        # Ghid complet interviu
│   ├── AIFeatures.tsx        # Tools AI diverse
│   ├── Labs.tsx              # Exerciții de cod
│   ├── TermDetail.tsx        # Detalii termen tehnic
│   ├── ApiKeyWarning.tsx     # Alert când lipsește API key
│   └── ...
├── lib/
│   └── supabase.ts           # Client Supabase
└── types/
    └── index.ts              # TypeScript types
```

## 🎯 Ce Acoperă Aplicația?

### Tehnologii din Job Description
✅ C# / C++ - 20+ termeni + 11 întrebări
✅ SQL - 15 termeni + 6 întrebări
✅ TypeScript - 19 termeni
✅ React - 2 întrebări
✅ Angular - 8 întrebări comprehensive
✅ OOP - 40 termeni + 11 întrebări (4 piloni, SOLID, Design Patterns)
✅ Testing - TDD, Unit Testing, Mocking
✅ AI/ML - 15 termeni + 15 întrebări
✅ Agile/Scrum - 9 întrebări complete

### Skills Tehnice Acoperite
✅ Programare Orientată pe Obiecte (OOP)
✅ .NET & EF Core
✅ Baze de date SQL
✅ HTTP & REST APIs
✅ Frontend (Angular/React)
✅ Design Patterns
✅ Testare (Unit, Integration)
✅ Git & GitHub
✅ Cloud (Azure basics)
✅ CI/CD pipelines
✅ Algoritmi & Structuri de Date

### Soft Skills & HR
✅ 22 întrebări comportamentale (format STAR)
✅ 18 întrebări Trimble-specific
✅ Sfaturi de comunicare și teamwork
✅ Cum să te pregătești cu 24h înainte

## 🔧 Comenzi Disponibile

```bash
# Development
npm run dev              # Pornește dev server

# Build
npm run build            # Build pentru producție
npm run preview          # Preview build local

# Linting
npm run lint             # Rulează ESLint

# Type checking
npm run typecheck        # Verifică TypeScript types
```

## 🛠️ Troubleshooting

### AI Features nu funcționează?

**Verifică:**
1. ✅ Ai adăugat `VITE_GEMINI_API_KEY` în `.env`?
2. ✅ API key-ul e valid (începe cu `AIza...`)?
3. ✅ Ai restartat aplicația după modificarea `.env`?
4. ✅ Vezi erori în Console (F12)?

**Citește:** `GEMINI_API_KEY_SETUP.md` pentru ghid complet

### Alte Probleme?

- **Build eșuat:** Rulează `npm install` din nou
- **Erori TypeScript:** Rulează `npm run typecheck`
- **Port ocupat:** Schimbă portul în `vite.config.ts`

## 📖 Documentație Extra

- `GEMINI_API_KEY_SETUP.md` - Ghid configurare API key
- `BUG_FIXES_SUMMARY.md` - Istoric bug fixes
- `TRIMBLE_INTERVIEW_GUIDE.md` - Ghid specific Trimble

## 🎓 Cum Să Folosești Aplicația pentru Pregătire Optimă

### Cu 1 Săptămână Înainte
1. Parcurge toate **Trimble Specific** (18 întrebări)
2. Revizuiește **HR Behavioral** (22 întrebări) - pregătește povești STAR
3. Studiază **AI & Productivity** (5 întrebări)

### Cu 3 Zile Înainte
1. **OOP & Design Patterns** - fundamentele (40 termeni + 11 întrebări)
2. **Agile/Scrum** - 9 întrebări
3. **C# / TypeScript / Angular** - stack-ul lor principal

### Cu 1 Zi Înainte
1. **Diferențe Tehnice** (13 întrebări) - "Care e diferența între..."
2. **Coding Labs** - rezolvă 2-3 probleme simple
3. **Sfaturile finale** din BIBLIA GIGA

### Dimineața Interviului
1. Citește **"Boostere finale de încredere"**
2. Revizuiește rapid **CV Experience** (10 întrebări)
3. Respiră și GO! 💪

## 🌟 Features Highlights

### AI Tutor
- Răspunde la orice întrebare despre termeni tehnici
- Context complet (ELI5, definiții, exemple de cod)
- Quick actions: Quiz Me, Deepen, Code Review, Analogy Explainer

### Quiz Practice
- Răspunzi cu propriile cuvinte
- AI evaluează înțelegerea conceptuală, nu word-by-word
- Feedback instant cu explicații

### BIBLIA GIGA
- 212 întrebări organize în 26 categorii
- Progress tracking
- Show/Hide răspunsuri
- Badge-uri pentru dificultate și categorie

## 📊 Statistici

- **186 termeni** tehnici detaliați
- **212 întrebări** de interviu
- **26 categorii** diferite
- **100% coverage** job requirements Trimble
- **AI-powered** tutoring și evaluare

## 🤝 Contributing

Aceasta este o aplicație personală de studiu. Pentru sugestii sau bug reports, deschide un issue.

## 📄 License

MIT

---

**Made with 💙 for Trimble Internship Interview Preparation**

**Mult succes la interviu!** 🚀🎯
