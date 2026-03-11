#!/usr/bin/env bash

# =============================================
#   Reconix - Project Environment Setup
# =============================================

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
BOLD='\033[1m'
RESET='\033[0m'

echo -e "${CYAN}${BOLD}"
echo "======================================"
echo "   Reconix - Environment Setup"
echo "======================================"
echo -e "${RESET}"

# ── 1. Create project folder ─────────────────────────────────
PROJECT_NAME="reconix"

mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME" || exit 1
echo -e "${GREEN}[+] Created project folder: $PROJECT_NAME${RESET}"

# ── 2. Folder structure ──────────────────────────────────────
mkdir -p output logs
echo -e "${GREEN}[+] Created folder structure${RESET}"

# ── 3. .gitignore ────────────────────────────────────────────
cat > .gitignore << 'EOF'
# API Keys - NEVER commit this
.env

# Recon output files (can contain sensitive data)
output/
logs/

# Python
__pycache__/
*.pyc
*.pyo
venv/
.venv/
*.egg-info/

# OS
.DS_Store
Thumbs.db

# Editor
.vscode/
.idea/
*.swp
*.swo
EOF
echo -e "${GREEN}[+] Created .gitignore${RESET}"

# ── 4. .env template ─────────────────────────────────────────
cat > .env.example << 'EOF'
# Copy this file to .env and fill in your values
# cp .env.example .env

# Groq API Key (free at console.groq.com)
GROQ_API_KEY=your_groq_api_key_here

# Model to use
GROQ_MODEL=llama-3.3-70b-versatile

# Target (optional, can also pass via CLI)
TARGET_DOMAIN=
EOF
echo -e "${GREEN}[+] Created .env.example${RESET}"

# ── 5. README.md ─────────────────────────────────────────────
cat > README.md << 'EOF'
# 🔍 Reconix

AI-powered recon automation tool. Runs subdomain enumeration + URL discovery,
then passes results to an LLM for vulnerability analysis with actionable next steps.

> Built by [@AkashA1511](https://github.com/AkashA1511)

## Stack
- **Recon**: subfinder, sublist3r, assetfinder, httpx, waybackurls, gau, paramspider, gf
- **AI Analysis**: Groq API (Llama 3.3 70b) — free tier
- **Output**: Colored terminal report with vuln findings + next steps

## Setup

### 1. Clone & enter project
```bash
git clone https://github.com/AkashA1511/reconix.git
cd reconix
```

### 2. Set up Python env
```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### 3. Configure API key
```bash
cp .env.example .env
nano .env   # paste your Groq API key
```
Get free key at: https://console.groq.com

### 4. Run
```bash
# Full pipeline (recon + AI analysis)
./recon.sh

# AI analysis only (if output/ already exists)
python3 analyzer.py --target example.com
```

## Output Files
| File | Contents |
|------|----------|
| `output/subdomains.txt` | All unique subdomains |
| `output/alive.txt` | Live domains with status/title |
| `output/urls.txt` | All discovered URLs |
| `output/params.txt` | URLs with parameters |
| `output/js_files.txt` | JavaScript files found |

## Project Structure
```
reconix/
├── recon.sh          ← main recon script (bash)
├── analyzer.py       ← AI vulnerability analyzer
├── parser.py         ← parses recon output files
├── reporter.py       ← colored CLI report
├── config.py         ← settings & config
├── requirements.txt  ← python dependencies
├── .env              ← your API keys (gitignored)
├── .env.example      ← template for .env
├── NOTES.md          ← research notes
└── output/           ← recon results (gitignored)
```
EOF
echo -e "${GREEN}[+] Created README.md${RESET}"

# ── 6. NOTES.md ──────────────────────────────────────────────
cat > NOTES.md << 'EOF'
# 📓 Reconix - Research Notes

## Project Goal
Build an AI-powered recon pipeline that:
1. Discovers subdomains + URLs automatically
2. Passes findings to an LLM for vuln analysis
3. Outputs colored CLI report with next steps

---

## Tools Research

### Subdomain Enumeration
- **subfinder** - passive, fast, API-based
- **sublist3r** - uses search engines
- **assetfinder** - Facebook & other sources

### URL Discovery
- **waybackurls** - Wayback Machine historical URLs
- **gau** - GetAllUrls, multiple sources
- **paramspider** - finds URLs with parameters

### Vuln Pattern Matching
- **gf** (tomnomnom) - grep patterns for sqli, xss, idor, ssrf, redirect etc.

---

## AI / LLM Research

### Groq (chosen)
- Free API at console.groq.com
- Model: llama-3.3-70b-versatile
- Very fast inference
- Great for security analysis

### Alternatives
- Ollama (local, fully private)
- OpenRouter (many free models)
- Gemini API (free tier)

---

## Vulnerability Patterns to Detect

### IDOR
- Parameters: `id=`, `user_id=`, `account=`, `uid=`
- Try: increment/decrement the value
- Look for: `/api/user/1`, `/profile/123`

### SQLi
- Parameters: any input, search, login fields
- GF pattern: `gf sqli urls.txt`

### Open Redirect
- Parameters: `redirect=`, `url=`, `next=`, `return=`

### XSS
- Parameters: `q=`, `search=`, `input=`, `name=`

### Exposed Panels
- Paths: `/admin`, `/dashboard`, `/.git`, `/api/docs`

---

## Bugs / Issues Log
| Date | Bug | Status |
|------|-----|--------|
| - | - | - |

---

## Todo
- [ ] Upgrade recon.sh with waybackurls + gau + paramspider + gf
- [ ] Build parser.py
- [ ] Build analyzer.py with Groq
- [ ] Build reporter.py with rich colors
- [ ] Test on a bug bounty target
EOF
echo -e "${GREEN}[+] Created NOTES.md${RESET}"

# ── 7. requirements.txt ──────────────────────────────────────
cat > requirements.txt << 'EOF'
# HTTP & API
requests==2.31.0
groq==0.9.0

# CLI Colors & Output
rich==13.7.0
colorama==0.4.6

# Environment
python-dotenv==1.0.0
EOF
echo -e "${GREEN}[+] Created requirements.txt${RESET}"

# ── 8. config.py ─────────────────────────────────────────────
cat > config.py << 'EOF'
# config.py - Reconix Settings
import os
from dotenv import load_dotenv

load_dotenv()

GROQ_API_KEY = os.getenv("GROQ_API_KEY", "")
GROQ_MODEL   = os.getenv("GROQ_MODEL", "llama-3.3-70b-versatile")

OUTPUT_DIR   = "output"

SUBDOMAINS_FILE = f"{OUTPUT_DIR}/subdomains.txt"
URLS_FILE       = f"{OUTPUT_DIR}/urls.txt"
ALIVE_FILE      = f"{OUTPUT_DIR}/alive.txt"
PARAMS_FILE     = f"{OUTPUT_DIR}/params.txt"
JS_FILE         = f"{OUTPUT_DIR}/js_files.txt"
EOF
echo -e "${GREEN}[+] Created config.py${RESET}"

# ── 9. Placeholder Python files ──────────────────────────────
cat > parser.py << 'EOF'
# parser.py - Reads recon output files
# TODO: implement in next step
print("Parser - coming soon")
EOF

cat > analyzer.py << 'EOF'
# analyzer.py - AI vulnerability analyzer
# TODO: implement in next step
print("Analyzer - coming soon")
EOF

cat > reporter.py << 'EOF'
# reporter.py - Colored CLI report
# TODO: implement in next step
print("Reporter - coming soon")
EOF

echo -e "${GREEN}[+] Created placeholder Python files${RESET}"

# ── 10. recon.sh placeholder ─────────────────────────────────
cat > recon.sh << 'EOF'
#!/usr/bin/env bash
# recon.sh - Reconix main recon script
# TODO: upgraded version coming next
echo "[reconix] recon.sh placeholder - upgrade coming soon"
EOF
chmod +x recon.sh
echo -e "${GREEN}[+] Created recon.sh placeholder${RESET}"

# ── 11. Git init + remote + push ─────────────────────────────
git init -q
git add .
git commit -q -m "🚀 initial project setup - reconix"
git branch -M main
git remote add origin https://github.com/AkashA1511/reconix.git
echo -e "${GREEN}[+] Git initialized, remote set to: https://github.com/AkashA1511/reconix.git${RESET}"

echo ""
echo -e "${YELLOW}[~] Pushing to GitHub...${RESET}"
git push -u origin main

if [ $? -eq 0 ]; then
    echo -e "${GREEN}[✓] Successfully pushed to GitHub!${RESET}"
else
    echo -e "${RED}[!] Push failed — you may need to authenticate first.${RESET}"
    echo -e "${YELLOW}    If asked for password, use a GitHub Personal Access Token (not your password)"
    echo -e "    Generate one at: https://github.com/settings/tokens${RESET}"
    echo ""
    echo -e "${YELLOW}    Then run manually:${RESET}"
    echo -e "${CYAN}    git push -u origin main${RESET}"
fi

# ── 12. Done ─────────────────────────────────────────────────
echo ""
echo -e "${CYAN}${BOLD}======================================"
echo "   ✅ Reconix Setup Complete!"
echo -e "======================================${RESET}"
echo ""
echo -e "${BOLD}Repo:${RESET}    ${CYAN}https://github.com/AkashA1511/reconix${RESET}"
echo -e "${BOLD}Folder:${RESET}  ${CYAN}$(pwd)${RESET}"
echo ""
echo -e "${YELLOW}${BOLD}Next Steps:${RESET}"
echo ""
echo -e "${BOLD}1. Set up Python environment:${RESET}"
echo -e "   ${CYAN}python3 -m venv venv"
echo -e "   source venv/bin/activate"
echo -e "   pip install -r requirements.txt${RESET}"
echo ""
echo -e "${BOLD}2. Get your free Groq API key:${RESET}"
echo -e "   ${CYAN}https://console.groq.com${RESET}"
echo ""
echo -e "${BOLD}3. Configure it:${RESET}"
echo -e "   ${CYAN}cp .env.example .env"
echo -e "   nano .env${RESET}   ← paste your Groq key here"
echo ""
echo -e "${GREEN}${BOLD}Then come back and we'll build recon.sh + analyzer.py! 🚀${RESET}"
echo ""
