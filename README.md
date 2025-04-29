# Sub-Saharan Child Height Analysis
---

![Image](https://github.com/user-attachments/assets/f60daec5-3030-4d33-adc5-66e06ce706a7)

---

## Introduction

Children are classified as stunted if their height-for-age falls more than two standard deviations below the WHO growth standards; however, stunting exists along a continuum rather than a strict threshold (Onis & Branca, 2016).

This study examines factors associated with children's height (expressed as z-scores) in sub-Saharan Africa, using data from 3,799 children under five years old. Key variables include maternal health (weight and age at childbirth), breastfeeding practices, household wealth, parental education, urban/rural residence, and number of siblings.

The analysis is conducted in two stages: first, applying linear regression to assess continuous height outcomes; and second, using logistic regression by categorizing children as either stunted or not. The findings aim to shed light on how biological and social factors jointly influence child growth in regions where hunger and malnutrition remain pressing challenges.

---

## Variables
- HW5		      : Height-for-Age z score
- MOMWEIGHT	  : Mother's weight in pounds		
- BREASTFEED	: Duration of breastfeeding [still=still breastfeeding, <1=less than 1 year, b12=1-2 years, >2=more than 2 years]
- WEALTHIND	  : Household wealth index [pst=poorest, pr=poorer, m=middle, rc=rich, rcst=richest]	
- RESIDENCE	  : Type of place of residence [urban, rural]	
- MOMAGE		  : Mother's age at birth of child
- SEX		      : Sex of child [male, female]
- MOMEDU		  : Mother’s highest educational level [Ne=no education, Pri=primary, SecH=secondary or higher]
- LIVCHN		  : Number of living children [<3=less than 3, B34=3-4, >5=5 or more]

---

## Result

### Model
- Final linear regression model:<br>
HW5 = -8.31 + 0.06MOMWEIGHT - 0.06MOMEDU_NE – 0.15MOMEDU_Pri – 0.17WEALTHININD_pst – 0.16WEALTHIDN_pr – 0.10WEALTHIDN_m – 0.05WEALTHIDN_rc + 0.06BREASTFEED_still – 0.02BREASTFEED_<1 – 0.06BREASTFEED_B12 + 1.04 LIVCHN_<3 + 0.74 LIVCHN_B34 – 0.008MOMWEIGHT*LIVCHN_<3 – 0.006 MOMWEIGHT*LIVCHN_B34  
R-Square = 0.5775

- Final logistic regression model:<br>
g(x) = logit (π̂) = 12.19 - 0.10MOMWEIGHT – 0.73LIVCHN_<3 - 0.53LIVCHN_B34 – 0.03MOMAGE + 0.43MOMEDU_NE + 0.40MOMEDU_Pri  
Classification table resulting in an overall accuracy rate of 81.65%.

---

### Comparison
- The main difference between linear regression and logistic regression is the form of the response variable. Linear regression predicts a numeric outcome, while logistic regression classifies into binary categories.
- Both models identified SEX and RESIDENCE as non-significant predictors.
- Linear regression modeled interactions (e.g., LIVCHN and MOMWEIGHT), while logistic regression did not.
- Linear regression gives detailed continuous predictions (HW5 values), while logistic regression estimates the probability of being stunted.
- Using linear regression and categorizing the predicted HW5 scores, the correct classification rate was 81.13%, slightly lower than logistic regression’s 81.65%, indicating logistic regression provided slightly better classification in this case.

---

## See Full Report
## [Full Report](https://github.com/alfian-mamab/Sub-Saharan_Child_Height/blob/main/Regression%20on%20Sub-Saharan%20Child%20Height.pdf)
