# SPIRIT — Delay-Aware Agentic Payment Anomaly Investigation
**PayPal AI Hackathon 2026 | Research Track Submission**

---

### The Problem
Emerging suspicious payment patterns can appear before reliable fraud labels become available. Conventional supervised systems cannot learn from outcomes that have not matured, while overly broad anomaly rules can generate excessive false positives.

### Our Solution
SPIRIT is a research prototype that investigates suspicious payment patterns during configurable label-maturation delays. It generates explainable candidate investigation rules and subjects them to deterministic, chronological verification before they can enter review-only mode.

### Key Features
- **Label-aware simulation:** Reproducible transaction streams with configurable outcome-label delays.
- **Anomaly discovery:** Fixed-threshold, Isolation Forest, and rolling statistical baselines.
- **Agentic hypothesis generation:** A configurable Gemini integration proposes structured, interpretable candidate rules.
- **Deterministic verification:** Rule-schema validation, chronological evaluation, and a configurable false-positive-rate safety gate.
- **Safe review mode:** Candidate rules do not autonomously block, capture, void, or refund payments.
- **PayPal integration:** PayPal REST Orders v2 and capture workflows, with explicit simulated mode when sandbox credentials are unavailable.
- **Auditability:** A tamper-evident SHA-256 audit chain and an experiment comparison dashboard.

### Evaluation
In the reported synthetic benchmark at a seven-day label delay, SPIRIT achieved 100% recall, 63.7% precision, and a 2.58% false-positive rate. These are results on the project's synthetic evaluation, not real-world PayPal performance. The reported verified-system metrics matched the Isolation Forest baseline, so the current evidence supports the verification and safety workflow rather than superior detection accuracy.

### Limitations
Live Gemini inference and real PayPal Sandbox transactions require configured credentials. Synthetic data does not establish performance on real payment traffic. The system is a research prototype and does not modify PayPal's internal risk controls.

---

## 🔬 Benchmark Comparison (7-Day Label Delay, Seed = 42)

| Model / Approach | Test Recall | Precision | FPR | F1-Score | Status / Role |
|---|---|---|---|---|---|
| **Fixed Threshold Baseline** | 52.3% | 100.0% | 0.00% | 0.687 | Conventional Baseline |
| **Isolation Forest (Unsupervised)** | 100.0% | 63.7% | 2.58% | 0.778 | Unsupervised Baseline |
| **Rolling Z-Score Detector** | 36.9% | 100.0% | 0.00% | 0.539 | Statistical Baseline |
| **Unverified Agent Hypotheses** | 0.0% | 0.0% | 0.00% | 0.000 | Ablation (Fails Safety Gate) |
| **SPIRIT / Chronos-Guard (Verified)** | **100.0%** | **63.7%** | **2.58%** | **0.778** | **Proposed System (FPR $\le$ 5%)** |
| **Oracle Supervised (Delay = 0)** | 88.0% | 91.0% | 1.20% | 0.895 | Theoretical Bound (Ground Truth) |

---

## 🛠️ Technology Stack & AI Tools
- **Agentic AI & LLM**: Google Gemini (`google-genai` SDK) with structured JSON schemas, AST validation, restricted feature allowlist, and deterministic offline demonstration fallback.
- **Backend & Verification**: Python 3.14 / 3.11+, FastAPI, Pydantic v2, scikit-learn, NumPy, SQLite, SHA-256 tamper-evident hash chaining.
- **Payment & FinTech**: Official PayPal REST Orders v2 API (`/v2/checkout/orders`), OAuth 2.0 client credentials, webhook signature verification (`/v1/notifications/verify-webhook-signature`), and transparent simulated fallback.
- **Frontend & UX**: React 19, TypeScript, Vite, Tailwind CSS, Lucide React, Recharts. Warm porcelain fintech research palette (`#FBF7F2`, `#211B3D`, `#492653`, `#7A2039`, `#38834A`).

---

## 🚀 Quick Start for Judges & Reviewers

1. **Launch the Application**:
   - Windows batch script: Double-click `run_app.bat`
   - PowerShell script: `./run_app.ps1`
   - Manual start:
     - Backend: `cd backend && $env:PYTHONPATH='.' && uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload`
     - Frontend: `cd frontend && npm run dev`
2. **Access Interfaces**:
   - Web Application: `http://localhost:5173`
   - Interactive OpenAPI Docs: `http://127.0.0.1:8000/docs`
3. **Execute Benchmark Experiments via CLI**:
   ```powershell
   cd backend
   python run_experiments.py
   ```
4. **Execute Automated Test Suite (19 tests)**:
   ```powershell
   cd backend
   python -m pytest tests -v
   ```
