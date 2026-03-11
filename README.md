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
