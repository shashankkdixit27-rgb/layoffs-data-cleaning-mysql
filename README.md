# layoffs-data-cleaning-mysql
Cleaned raw layoffs dataset (2.3k rows) using MySQL Window Functions, CTEs and Standardization
# Layoffs Data Cleaning Project - Using MySQL

## 📌 Overview
This project focuses on cleaning a raw layoffs dataset (2020-2023) which was messy, had duplicates, inconsistent formats, and null values. The goal was to make it analysis-ready using MySQL.

## 📂 Dataset
- **Source:** Kaggle - Layoffs 2022
- **Raw Rows:** 2361
- **Clean Rows:** 2344
- **Columns:** company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions

## 🛠️ Problems Found in Raw Data
1. Duplicate companies with same data
2. Company names with extra spaces ex: " Airbnb"
3. Inconsistent Industry names - "Crypto Currency" and "Crypto"
4. Date column was in TEXT format - "12/16/2022"
5. Null & blank values in industry and company
6. Country names had trailing dots ex: "United States."

## ⚙️ Steps I Performed

### 1. Remove Duplicates
- Used `ROW_NUMBER() OVER(PARTITION BY ...)` to identify duplicates
- Created `layoffs_staging2` table with row_num column
- Deleted where row_num > 1
- Solved **MySQL Error 1175 - Safe Update Mode** using `SET SQL_SAFE_UPDATES = 0`

### 2. Standardize Data
```sql
UPDATE layoffs_staging2 SET company = TRIM(company);
UPDATE layoffs_staging2 SET industry = 'Crypto' WHERE industry LIKE 'Crypto%';
UPDATE layoffs_staging2 SET country = TRIM(TRAILING '.' FROM country);

27 lines hidden
3. Fix Date Format
Date was TEXT in format MM/DD/YYYY
Converted using STR_TO_DATE()
Solved Error 1292 - Truncated incorrect date value - Changed %y to %Y for 4-digit year
SQL
UPDATE layoffs_staging2 SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');
ALTER TABLE layoffs_staging2 MODIFY COLUMN `date` DATE;
4. Handle NULL & Blank Values
Set blank industry to NULL
Filled NULL industry based on company name
Deleted rows where both total_laid_off and percentage_laid_off were NULL
📁 Repository Structure
Code
/data
    - layoffs.csv (raw)
    - layoffs_clean.csv (cleaned)
/scripts
    - 01_remove_duplicates.sql
    - 02_standardize_data.sql
    - 03_handle_nulls.sql
    - 04_fix_dates.sql

3 lines hidden
💻 Tech Stack
MySQL Workbench
Window Functions (ROW_NUMBER)
CTEs
Data Cleaning Concepts
📈 Final Result
100% duplicate-free dataset
Standardized company, industry, country fields
Proper DATE data type
Ready for Exploratory Data Analysis (EDA)
🚀 Next Steps
Will perform EDA to find:

Which industry laid off most?
Which year had max layoffs?
Company-wise layoff trends
👨‍💻 Author
Shashank Dixit - Aspiring Data Analyst
