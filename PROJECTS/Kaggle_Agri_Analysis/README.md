# 🌾 India Agriculture Yield Analysis (1966-2017)

A professional data audit focusing on regional crop productivity trends in Andhra Pradesh, specifically comparing **Srikakulam** and **East Godavari** districts.

## 📊 Project Scope (Milestone 1)
- **Objective:** Analyze 50 years of historical data to identify yield gaps and production trends.
- **Region of Focus:** Andhra Pradesh, India.
- **Key Metrics:** Production (1000 tons) and Yield (Kg per ha).

## 🛠️ Technical Highlights
- **Dynamic Data Pipeline:** Developed a modular Python function `analyze_crop_portfolio()` to handle multi-crop audits without hardcoding.
- **Environment Management:** Project structured for local development (VS Code) and cloud environments (Kaggle).
- **Visualization:** Interactive time-series analysis using Plotly for high-resolution trend spotting.

## 📂 Repository Structure
- `notebooks/`: Exploratory Data Analysis (EDA) and visualization logic.
- `scripts/`: Production-ready `.py` scripts for automated data processing.
- `docs/`: Technical PDF reports for non-technical stakeholders.
- `data_raw/`: (Ignored via .gitignore) Contains the source ICRISAT dataset.

## 📉 Key Insight: The Yield Gap
Initial findings show a significant **Rice Yield Gap** between Srikakulam and East Godavari. Despite similar climates, East Godavari shows higher efficiency, indicating potential differences in irrigation infrastructure or modern farming adoption.

## 🚀 Getting Started
1. Install dependencies: `pip install -r requirements.txt`
2. Run the analysis: Open `notebooks/indian-agriculture-analysis.ipynb` in VS Code or Jupyter.

## 🔗 Data Credit
Dataset provided by [ICRISAT](https://www.kaggle.com/datasets/thedevastator/india-agriculture-crop-production-1966-2017) via Kaggle.