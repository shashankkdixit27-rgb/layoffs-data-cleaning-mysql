update layoffs_staging2
set company = trim(company);

select * from layoffs_staging2
where industry like '%crypto';

update layoffs_staging2
set industry = 'crypto'
where industry like 'crypto%';

select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;

update layoffs_staging2
set country  = trim(trailing '.' from country)
where country like 'united states%';
