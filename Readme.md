# IPL Analytics Platform — End-to-End Data Analysis (Python, SQL, Power BI)

This project presents a complete end-to-end analytics pipeline built using Indian Premier League (IPL) match data.
It combines Python-based data analysis, statistical testing, SQL analytics, and an interactive Power BI dashboard to explore team strategies, player performance, and venue impact across IPL seasons.

The objective of this project is to demonstrate a real-world analytics workflow from raw data to actionable insights.

---

# Dashboard Preview

## Overview Dashboard

![Overview Dashboard](assets/ipl_overview.png)

## Team Performance Analysis

![Team Analysis](assets/team_analysis.png)

## Batting Performance Analysis

![Batting Analysis](assets/batting_analysis.png)

## Bowling Performance Analysis

![Bowling Analysis](assets/bowling_analysis.png)

## Venue Insights

![Venue Analysis](assets/venue_insights.png)

---

# Dataset Information

The dataset contains detailed ball-by-ball IPL match data including:

* Match metadata (date, venue, season)
* Ball-by-ball delivery information
* Batting and bowling statistics
* Toss decisions and outcomes
* Player-level performance metrics

Dataset scale:

| Metric               | Value   |
| -------------------- | ------- |
| Total Matches        | 1169    |
| Ball-by-Ball Records | 278,205 |
| Seasons Covered      | 18      |
| Total Runs           | 374,283 |
| Total Wickets        | 12,650  |
| Total Sixes          | 14,353  |


The dataset used for this project is IPL ball-by-ball match data.

Due to GitHub file size limits, the dataset is not included in the repository.

You can download the dataset from:
Kaggle IPL Dataset

Place the file inside:

data/IPL.csv
---

# Project Pipeline

```
Raw IPL Dataset
       ↓
Python Data Cleaning
       ↓
Exploratory Data Analysis
       ↓
Statistical Testing
       ↓
Feature Engineering
       ↓
SQL Analytics
       ↓
Power BI Dashboard
```

---

# Project Structure

```
ipl-analytics-end-to-end/

data/
└── IPL.csv
└── ipl_cleaned.csv
└── ipl_deliveries_clean.csv
└── ipl_matches_clean.csv
└── ipl_team_season_summary.csv



notebooks/
├── 01_data_understanding.ipynb
├── 02_data_cleaning.ipynb
├── 03_exploratory_data_analysis.ipynb
├── 04_statistical_analysis.ipynb
└── 05_feature_engineering.ipynb

sql/
└── ipl_queries.sql

powerbi/
└── ipl_dashboard.pbix

reports/
└── dashboard_preview.pdf

assets/
├── overview_dashboard.png
├── team_analysis.png
├── batting_analysis.png
├── bowling_analysis.png
└── venue_analysis.png

README.md
```

---

# Python Analysis

## Data Understanding

Initial inspection of the dataset including structure, columns, and match vs delivery level analysis.

## Data Cleaning

Data preparation steps include:

* fixing inconsistent team names
* handling missing values
* correcting data types
* removing redundant columns
* standardizing team and venue information

## Exploratory Data Analysis

EDA explores trends across teams, players, and venues including:

* team win percentages
* chasing vs defending success
* venue scoring patterns
* top run scorers and wicket takers
* scoring trends across seasons
* phase-wise scoring analysis

---

# Statistical Analysis

Hypothesis testing was performed to validate strategic assumptions.

Example test:

**Do chasing teams have a statistical advantage in IPL matches?**

Method used:

Proportion Z-Test

Result:

Chasing teams win approximately **52.6% of matches**, and the statistical test confirms this advantage is significant.

---

# Feature Engineering

Match-level analytical features were created from ball-by-ball data.

Engineered features include:

* first_innings_score
* first_innings_wickets
* target_runs
* win_margin
* win_type
* match_phase classification

These features enable deeper analysis in SQL and Power BI.

---

# SQL Analytics

SQL queries perform advanced aggregations such as:

Team analytics

* total wins by team
* team win percentage

Batting analytics

* top run scorers
* strike rate leaders
* boundary hitters

Bowling analytics

* top wicket takers
* economy rate leaders

Venue analytics

* highest scoring venues
* toss decision influence
* venue match outcomes

---

# Power BI Dashboard

An interactive dashboard was built with five analytical views.

## Overview

Tournament-level insights including:

* matches played
* total runs scored
* total wickets
* scoring trends
* top players

## Team Performance

Analysis of team strategies including:

* win percentages
* toss decisions
* chasing vs defending success

## Batting Analysis

Player performance insights including:

* top run scorers
* strike rate comparisons
* phase-wise scoring trends

## Bowling Analysis

Bowling impact analysis including:

* top wicket takers
* economy leaders
* phase-wise wicket distribution

## Venue Insights

Stadium performance including:

* average venue score
* highest scoring venues
* toss strategies by stadium

---

# Key Insights

• Chasing teams win approximately **52.6% of IPL matches**

• Average first innings score across IPL seasons is **167 runs**

• **Virat Kohli** is the highest run scorer in IPL history

• **Yuzvendra Chahal** leads IPL wicket tallies

• Run rates have increased steadily across recent IPL seasons

---

# Tools & Technologies

Python
Pandas
NumPy
Matplotlib
Seaborn

SQL (MySQL)

Power BI

---

# Skills Demonstrated

* Exploratory Data Analysis
* Data Cleaning
* Feature Engineering
* Statistical Testing
* SQL Analytics
* Data Visualization
* Sports Data Analysis

---
## How to Run This Project

### 1. Clone the repository

```
git clone https://github.com/yourusername/ipl-analytics-end-to-end.git
cd ipl-analytics-end-to-end
```

### 2. Install Python dependencies

This project uses Python for data analysis.

```
pip install pandas numpy matplotlib seaborn jupyter
```

### 3. Run the notebooks

Open Jupyter Notebook and run the analysis notebooks in order:

```
01_data_understanding.ipynb
02_data_cleaning.ipynb
03_exploratory_data_analysis.ipynb
04_statistical_analysis.ipynb
05_feature_engineering.ipynb
```

### 4. Run SQL queries

Open the SQL file in MySQL Workbench:

```
sql/ipl_queries.sql
```

Execute queries to reproduce the analytical results.

### 5. Open the Power BI dashboard

Open the Power BI file:

```
powerbi/ipl_dashboard.pbix
```

Refresh the data model if necessary to view the interactive dashboard.
---

# Author

Srikanth Nakka
Data Analyst | Data Science Enthusiast
