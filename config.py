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
