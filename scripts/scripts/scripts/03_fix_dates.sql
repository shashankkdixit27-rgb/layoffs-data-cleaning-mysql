select `date`,
STR_TO_DATE(`date`,'%m/%d/%Y')
FROM layoffs_staging2;


update layoffs_staging2
set `date` = STR_TO_DATE(`date`,'%m/%d/%Y');

alter table layoffs_staging2
modify column `date` DATE;
