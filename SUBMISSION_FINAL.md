# SPIRIT — Delay-Aware Agentic Payment Anomaly Investigation
**PayPal AI Hackathon 2026 Submission Document**

---

### Project Title
**SPIRIT — Delay-Aware Agentic Payment Anomaly Investigation**

### Team
**REMOTE**

### Project Summary & Elevator Pitch
SPIRIT explores how AI-generated, explainable investigation rules can help identify emerging payment anomalies before outcome labels become available. It combines transaction simulation, anomaly-detection baselines, deterministic chronological verification, and review-only safety controls.

The project includes a research dashboard, candidate-rule generation, experiment comparisons, and an audit trail. Evaluation currently uses synthetic data, and live AI and PayPal Sandbox operations depend on configured credentials.

---

### Tools & Technologies Used
* **AI & Agent Services**: 
  * Google Gemini API (`google-genai` Python SDK, `gemini-2.5-flash`) for structured rule synthesis from unlabeled statistical clusters.
  * Deterministic Demo Fallback: Offline rule generator based on feature deviations used when `GEMINI_API_KEY` is unconfigured or unavailable.
* **Backend Framework**: Python 3.14 / 3.11+, FastAPI, Pydantic v2, scikit-learn, NumPy.
* **Security & Storage**: SQLite, SHA-256 cryptographic hash-chain audit logging.
* **Payment Infrastructure**: Official PayPal REST Orders v2 API (`/v2/checkout/orders`), OAuth 2.0 client authentication, and official webhook signature verification (`/v1/notifications/verify-webhook-signature`), paired with an explicit simulated sandbox fallback.
* **Frontend**: React 19, TypeScript, Vite, Tailwind CSS, Lucide React, Recharts.

---

### Repository
* **Status**: Local Git repository initialized on branch `main`.
* **Remote URL**: **Not yet configured.** (The repository must be published manually to your team's GitHub account; no remote URL has been fabricated).
* **Manual Publishing Commands**:
  ```powershell
  cd C:\Users\GANESH_PIRINTI\Downloads\CHRONOS_GUARD
  git add .
  git commit -m "Initial commit: SPIRIT by Team REMOTE for PayPal AI Hackathon 2026"
  git remote add origin https://github.com/<YOUR_ORGANIZATION>/<YOUR_REPO>.git
  git branch -M main
  git push -u origin main
  ```

---

### 3-Minute Demo Sequence (Working Application Flow)

* **0:00–0:30 | Problem & Identity**:
  * Navigate to `/` (Landing Page).
  * Introduce SPIRIT by Team REMOTE. Explain the real-world 7 to 30 day label-maturation delay blind spot where supervised retraining is impossible.
* **0:30–1:00 | Label-Aware Stream & Anomaly Discovery**:
  * Navigate to `/simulation`.
  * Advance 5 steps, then click `Inject Anomaly Burst` at step 40.
  * Show that online transactions have masked fraud labels (`isFraud = None`). Point out the sudden balance drain spike.
* **1:00–1:40 | Agentic Hypothesis Generation**:
  * Navigate to `/anomalies` and `/investigation`.
  * Scan recent window to identify the unsupervised cluster.
  * Click `Synthesize Candidate Rule`. Observe the structured `AND`/`OR` predicate, uncertainty rating, expected failure modes, and review-only action scope (`FLAG_FOR_REVIEW`).
  * Note the status pill: clearly shows **DEMO FALLBACK** (or Live Gemini if credentials are set).
* **1:40–2:15 | Deterministic Multi-Partition Verification**:
  * Navigate to `/verification`.
  * Click `Run Deterministic Backtest`.
  * Show AST safety validation and the out-of-time chronological partition test.
  * Verify that the False Positive Rate is $2.58\%$, well below the mandatory $5.0\%$ safety ceiling, admitting the rule to `SHADOW` review mode.
* **2:15–2:40 | PayPal Sandbox Workflow**:
  * Navigate to `/paypal`.
  * Create a $49.99 order and execute capture.
  * Point out the banner displaying **SIMULATED MODE** (or Live Sandbox if credentials are set).
* **2:40–3:00 | Cryptographic Audit Trail**:
  * Navigate to `/audit`.
  * Click `Verify Cryptographic Chain`. Confirm all 50+ simulation, detection, backtesting, and payment events are sealed with unbroken SHA-256 hash chaining.

---

### Evaluation Findings
In the reported synthetic benchmark at a seven-day label delay (seed = 42, 5,000 transactions):
* **Fixed Threshold**: Recall 52.3%, Precision 100.0%, FPR 0.00%, F1 0.687
* **Isolation Forest**: Recall 100.0%, Precision 63.7%, FPR 2.58%, F1 0.778
* **Rolling Z-Score**: Recall 36.9%, Precision 100.0%, FPR 0.00%, F1 0.539
* **Unverified Agent (Ablation)**: Fails safety gate (0% recall / 0% FPR)
* **SPIRIT (Verified System)**: **Recall 100.0%, Precision 63.7%, FPR 2.58%, F1 0.778**

*Note on Evaluation*: The verified system metrics matched the Isolation Forest baseline. The current evidence supports the deterministic safety verification, explainability, and review-only gating workflow rather than superior raw detection accuracy over unsupervised algorithms.

---

### Known Limitations
1. **Synthetic Data**: Benchmarks are evaluated on reproducible synthetic data and PaySim distributions; this does not establish performance on live commercial payment flows.
2. **Credential Dependence**: Live Gemini LLM inference and live PayPal Sandbox API calls require user-provided credentials in `.env`; without them, the application runs honestly in deterministic demo fallback and simulated sandbox modes.
3. **Research Scope**: SPIRIT is an independent merchant-side decision-support tool. It does not access PayPal's proprietary risk engine, alter PayPal internal controls, or discover vulnerabilities.
