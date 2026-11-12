# SPIRIT
> **Detect emerging payment anomalies. Generate explainable hypotheses. Verify before acting.**

* **Project Name**: SPIRIT — Delay-Aware Agentic Payment Anomaly Investigation  
* **Team**: REMOTE  
* **Hackathon**: PayPal AI Hackathon 2026  

---

## 1. Problem Statement

In payment processing, suspicious transaction patterns frequently emerge before true fraud labels become available. Full chargeback and dispute arbitration cycles introduce a 7 to 30 day **label-maturation delay**. During this window, conventional supervised models cannot retrain because ground-truth labels do not yet exist, while unconstrained anomaly rules can trigger catastrophic false positives that disrupt legitimate customer transactions.

---

## 2. Solution Explanation

**SPIRIT** is an independent, merchant-side research prototype and decision-support platform designed for this label-blind window. It:
1. Discovers emerging distribution shifts without requiring ground-truth labels.
2. Uses an agentic LLM (Google Gemini) to synthesize structured, declarative candidate investigation rules restricted to pre-vetted features.
3. Subjects all candidate hypotheses to **deterministic chronological verification** across historical, observation, validation, and test partitions.
4. Enforces a strict False-Positive Rate (FPR) ceiling ($\le 5.0\%$) and restricts rule action scopes strictly to human-review recommendations (`FLAG_FOR_REVIEW`, `REQUEST_STEP_UP_AUTH`), preventing unverified rules from autonomously blocking or altering financial transactions.

---

## 3. Main Features

- **Label-Aware Simulation**: Reproducible transaction streaming with configurable outcome-label delays (0d, 3d, 7d, 14d, 30d) and seeded pseudo-random generation.
- **Multi-Model Anomaly Baselines**: Fixed-threshold rules, Isolation Forest (unsupervised), and rolling statistical Z-score detectors.
- **Agentic Hypothesis Generation**: Proposes declarative `AND`/`OR` rules with honest uncertainty metrics and expected failure modes.
- **Deterministic Verification Engine**: Static AST inspection, schema bounds checks, and out-of-time chronological backtesting.
- **Safe Review-Only Operation**: Rules never autonomously block, capture, void, or refund payments.
- **PayPal Integration**: Official PayPal REST Orders v2 API checkout creation and capture, with explicit simulated mode when credentials are not configured.
- **Cryptographic Auditability**: SHA-256 chained tamper-evident audit logging verifying zero retroactive modification.
- **Scientific Experiment Suite**: Interactive dashboard and CLI benchmark comparing model performance across delay regimes.

---

## 4. Technologies & AI Tools Actually Used

- **AI & Agentic Reasoning**: Google Gemini API via official `google-genai` SDK with strict JSON schemas. When unconfigured, SPIRIT executes a deterministic offline demonstration fallback.
- **Backend & Verification**: Python 3.14 / 3.11+, FastAPI, Pydantic v2, scikit-learn, NumPy, SQLite, SHA-256 cryptographic hash chaining.
- **Payments**: Official PayPal REST v2 APIs (`/v2/checkout/orders`), OAuth 2.0 client authentication, and official webhook signature validation.
- **Frontend & UX**: React 19, TypeScript, Vite, Tailwind CSS, Lucide React, Recharts. Warm porcelain fintech research theme (`#FBF7F2`, `#211B3D`, `#492653`, `#7A2039`, `#38834A`).

---

## 5. Quick Start & Run Instructions

### Prerequisites
- Python 3.11+ (or Python 3.14)
- Node.js 18+ & npm

### One-Click Startup (Windows)
Double-click `run_app.bat` or run in PowerShell:
```powershell
./run_app.ps1
```
- **Backend API**: `http://127.0.0.1:8000` (OpenAPI Docs: `http://127.0.0.1:8000/docs`)
- **Frontend Application**: `http://localhost:5173`

### Manual Startup

**Backend**:
```powershell
cd backend
pip install -r requirements.txt
$env:PYTHONPATH="."
uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload
```

**Frontend**:
```powershell
cd frontend
npm install
npm run dev
```

---

## 6. Demo Mode & Missing Credentials

SPIRIT runs out-of-the-box with zero configuration:
- **Missing Gemini API Key**: SPIRIT clearly operates in **DEMO FALLBACK** mode (`deterministic_demo_offline`), generating deterministic rule hypotheses based on empirical cluster shifts.
- **Missing PayPal Credentials**: SPIRIT clearly operates in **SIMULATED MODE** (`simulated_sandbox`), simulating realistic order creation, capture, and webhook validation without contacting live PayPal servers.
- **To Enable Live Calls**: Copy `.env.example` to `.env` and supply your credentials:
  ```env
  GEMINI_API_KEY=your_key_here
  PAYPAL_CLIENT_ID=your_sandbox_client_id
  PAYPAL_CLIENT_SECRET=your_sandbox_client_secret
  ```

---

## 7. Testing Instructions

### Backend Automated Test Suite (19 Tests)
```powershell
cd backend
$env:PYTHONPATH="."
python -m pytest tests -v
```

### End-to-End Workflow Verification Script
```powershell
cd backend
python test_workflow_e2e.py
```

### Standalone Scientific Benchmark CLI
```powershell
cd backend
python run_experiments.py
```

### Frontend Production Build
```powershell
cd frontend
npm run build
```

---

## 8. Experimental Evaluation (Reproducible Benchmark)

In the reported synthetic benchmark at a 7-day label delay (seed = 42, 5,000 transactions):

| Model / Approach | Test Recall | Precision | FPR | F1-Score | Status / Role |
|---|---|---|---|---|---|
| **Fixed Threshold Baseline** | 52.3% | 100.0% | 0.00% | 0.687 | Conventional Baseline |
| **Isolation Forest (Unsupervised)** | 100.0% | 63.7% | 2.58% | 0.778 | Unsupervised Baseline |
| **Rolling Z-Score Detector** | 36.9% | 100.0% | 0.00% | 0.539 | Statistical Baseline |
| **Unverified Agent Hypotheses** | 0.0% | 0.0% | 0.00% | 0.000 | Ablation (Fails Safety Gate) |
| **SPIRIT (Verified System)** | **100.0%** | **63.7%** | **2.58%** | **0.778** | **Proposed System (FPR $\le$ 5%)** |
| **Oracle Supervised (Delay = 0)** | 88.0% | 91.0% | 1.20% | 0.895 | Theoretical Bound |

> **Evaluation Honesty Note**: The verified system metrics matched the Isolation Forest baseline. The current empirical evidence supports the deterministic safety verification, explainability, and review-only gating workflow rather than superior raw detection accuracy over unsupervised algorithms.

---

## 9. Known Limitations

1. **Synthetic Data**: Benchmarks are evaluated on reproducible synthetic data and PaySim distributions, which do not establish performance on live commercial payment flows.
2. **Credential Dependence**: Live Gemini LLM inference and live PayPal Sandbox API calls require credentials; otherwise, the system functions via its deterministic fallback and simulated sandbox.
3. **Merchant Scope**: SPIRIT is an independent merchant-side decision-support tool. It does not access PayPal's proprietary risk engine, alter PayPal internal controls, or discover vulnerabilities.

---

## 10. License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
