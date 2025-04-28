# Sub-Saharan_Child_Height
---
![Image](https://github.com/user-attachments/assets/f60daec5-3030-4d33-adc5-66e06ce706a7)
---
## Introduction
<div dir="rtl">
Children are classified as stunted if their height-for-age falls more than two standard deviations below the WHO growth standards; however, stunting exists along a continuum rather than a strict threshold (Onis & Branca, 2016).
This study examines factors associated with children's height (expressed as z-scores) in sub-Saharan Africa, using data from 3,799 children under five years old. Key variables include maternal health (weight and age at childbirth), breastfeeding practices, household wealth, parental education, urban/rural residence, and number of siblings.
The analysis is conducted in two stages: first, applying linear regression to assess continuous height outcomes; and second, using logistic regression by categorizing children as either stunted or not. The findings aim to shed light on how biological and social factors jointly influence child growth in regions where hunger and malnutrition remain pressing challenges.
</div>
---
## Result
### Model
- Final linear regression model: <br />
HW5 = -8.31 + 0.06MOMWEIGHT - 0.06MOMEDU_NE – 0.15MOMEDU_Pri – 0.17WEALTHININD_pst – 0.16WEALTHIDN_pr – 0.10WEALTHIDN_m – 0.05WEALTHIDN_rc + 0.06BREASTFEED_still – 0.02BREASTFEED_<1 – 0.06BREASTFEED_B12 + 1.04 LIVCHN_<3 + 0.74 LIVCHN_B34 – 0.008MOMWEIGHT*LIVCHN_<3 – 0.006 MOMWEIGHT*LIVCHN_B34 <br />
R-Square = 0.5775 <br />
- Final logistic regression model: <br />
g(x)=logit (π ̂ ) = 12.19 - 0.10MOMWEIGHT – 0.73LIVCHN_<3 - 0.53LIVCHN_B34 – 0.03MOMAGE + 0.43MOMEDU_NE + 0.40MOMEDU_Pri <br />
Classification table resulting in an overall accuracy rate of 81.65%.
### Comparison
<div dir="rtl">
- The main difference between linear regression and logistic regression is the form of the response variable. Linear regression's response variable is in numeric form, while logistic regression requires a binary format. 
- Linear regression is used to identify the best-fitting line, while on the other hand logistic regression fits the line's values to a sigmoid curve (“S” shaped curve), allowing it to model non-linear relationships and classify data into discrete categories.
- Both models defined SEX and RESIDENCE as not significant variables, but there are some differences in the other variables (shown by the table). Also, linear regression counted the interaction between LIVCHN and MOMWEIGHT in the model, while logistic regression did not.
- Linear regression provides greater detail in the outcome compared to logistic regression, which can only estimate the probability of a category. In the given case, logistic regression can estimate the probability of a child not being stunted (height-z-score>-2), but cannot predict the child's height-z-score.
- By using the linear model, we can get the prediction value of HW5 (called HW5_hat). Then by categorising HW5_hat <-2 as predicted stunted, classification table can be calculated. 
Overall, there are 81.13% correct predictions from the linear model, which is slightly lower than the logistic model which can produce 81,65 correct predictions. It means in this case logistic regression has a better model in predicting stunted and non-stunted group.
</div>
