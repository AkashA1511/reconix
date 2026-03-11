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
