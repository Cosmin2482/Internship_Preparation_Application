# 🔑 Cum Obții un API Key Gratuit pentru Google Gemini

## De Ce Ai Nevoie de API Key?

Aplicația folosește Google Gemini AI pentru:
- ✨ **AI Tutor** - Răspunde la întrebări despre termeni tehnici
- 📝 **Quiz Practice** - Evaluează răspunsurile tale cu AI
- 🤖 **AI Features** - Generează quizuri, explică concepte, simulează întrebări comportamentale

**Fără API key, aceste funcționalități NU vor funcționa!**

---

## 📋 Pași pentru Obținerea API Key (100% GRATUIT)

### Pasul 1: Accesează Google AI Studio

Deschide în browser: **https://aistudio.google.com/apikey**

### Pasul 2: Autentifică-te cu Contul Google

- Folosește orice cont Google (Gmail)
- Dacă nu ai cont Google, creează unul gratuit

### Pasul 3: Creează API Key

1. Click pe butonul **"Create API Key"** sau **"Get API Key"**
2. Selectează un proiect Google Cloud (sau creează unul nou - e gratuit)
3. Click **"Create API key in existing project"** sau **"Create API key in new project"**

### Pasul 4: Copiază API Key-ul

- Vei vedea un API key care arată așa: `AIzaSyD...` (un șir lung de caractere)
- Click pe iconița **Copy** pentru a copia key-ul
- **IMPORTANT:** Salvează key-ul undeva sigur!

### Pasul 5: Adaugă API Key în Aplicație

1. Deschide fișierul **`.env`** din rădăcina proiectului
2. Găsește linia:
   ```
   VITE_GEMINI_API_KEY=YOUR_API_KEY_HERE
   ```
3. Înlocuiește `YOUR_API_KEY_HERE` cu key-ul tău:
   ```
   VITE_GEMINI_API_KEY=AIzaSyD-voTrUcOpIaTkEyDeExEmpLu123456789
   ```
4. Salvează fișierul `.env`

### Pasul 6: Restart Aplicația

Dacă aplicația rulează deja:
```bash
# Oprește aplicația (Ctrl+C)
# Apoi pornește-o din nou
npm run dev
```

---

## ✅ Verificare că Funcționează

După ce ai adăugat API key-ul:

1. **Testează AI Tutor:**
   - Click pe butonul Sparkles (bottom-left) ✨
   - Selectează un termen
   - Pune o întrebare (ex: "Explică-mi mai detaliat")
   - Ar trebui să primești răspuns de la AI

2. **Testează Quiz Practice:**
   - Navighează la "Quiz Practice"
   - Răspunde la o întrebare
   - Click "Check Answer"
   - AI ar trebui să evalueze răspunsul

3. **Testează AI Features:**
   - Tab "Quiz Generator" - generează 3 întrebări
   - Tab "Concept Explainer" - explică un concept
   - Tab "Behavioral Practice" - generează întrebare STAR

---

## 🆓 Este Gratuit?

**DA! Google Gemini API este 100% GRATUIT** pentru uz personal și dezvoltare.

**Limita gratuită:**
- 15 requests/minut
- 1,500 requests/zi
- 1 milion tokens/lună

Pentru această aplicație de studiu, aceste limite sunt **MAI MULT DECÂT SUFICIENTE!**

---

## ⚠️ Mesaje de Eroare Comune

### "API key not valid"
**Cauză:** API key-ul e greșit sau nu există în `.env`
**Soluție:**
1. Verifică că ai copiat ÎNTREG key-ul (nu lipsește niciun caracter)
2. Verifică că nu ai spații înainte/după key
3. Asigură-te că ai salvat fișierul `.env`
4. Restart aplicația

### "Failed to get response from Gemini"
**Cauză:** Posibil problema de rețea sau API key invalid
**Soluție:**
1. Verifică conexiunea la internet
2. Verifică că API key-ul e corect în `.env`
3. Încearcă să regenerezi un API key nou din Google AI Studio

### "Quota exceeded"
**Cauză:** Ai depășit limita gratuită (rar pentru uz personal)
**Soluție:**
1. Așteaptă 1 minut (se resetează limita de 15 req/min)
2. Sau așteaptă până a doua zi (limita zilnică)

---

## 🔒 Securitate

### ⚠️ NU Partaja API Key-ul!

- **NU** posta API key-ul pe GitHub, Discord, forumuri
- **NU** trimite key-ul altora
- **NU** commit-ui fișierul `.env` în Git (e deja în `.gitignore`)

### 🛡️ Ce faci dacă cineva îți vede key-ul?

1. Mergi la: https://aistudio.google.com/apikey
2. Click pe "..." lângă key-ul vechi
3. Click **"Delete"**
4. Creează un key nou
5. Actualizează `.env` cu noul key

---

## 📞 Ajutor

Dacă întâmpini probleme:

1. **Verifică pașii din nou** - citește cu atenție fiecare pas
2. **Restart aplicația** după modificarea `.env`
3. **Verifică consola browser-ului** (F12 → Console) pentru erori detaliate
4. **Regenerează API key** dacă cel vechi nu funcționează

---

## 🎯 Rezumat Rapid

```bash
# 1. Obține API key de la:
#    https://aistudio.google.com/apikey

# 2. Adaugă în .env:
VITE_GEMINI_API_KEY=TauApiKeyAici

# 3. Restart:
npm run dev

# 4. Testează AI features!
```

---

## 🚀 Success!

Odată configurat corect, vei avea acces la:
- AI Tutor inteligent care răspunde la întrebări
- Evaluare automată a răspunsurilor cu feedback personalizat
- Generare de quizuri custom pe orice topic
- Explicații clare pentru orice concept tehnic
- Simulări de întrebări comportamentale cu structură STAR

**Mult succes la pregătirea pentru interviu!** 💪🎓
