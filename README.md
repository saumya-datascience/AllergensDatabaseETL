# Food Allergies Database

## Table of contents
- [Project Summary](https://github.com/Andyjag91/Allergens-in-Goya-Food-Products-/blob/main/README.md#project-summary)
- [Technologies](https://github.com/Andyjag91/Allergens-in-Goya-Food-Products-/blob/main/README.md#technologies)
- [Extraction, Transformation, Load Process](https://github.com/Andyjag91/Allergens-in-Goya-Food-Products-/blob/main/README.md#extraction-transform-load-process)
- [Example Queries](https://github.com/Andyjag91/Allergens-in-Goya-Food-Products-/blob/main/README.md#example-queries)
- [Hypothetical Questions](https://github.com/Andyjag91/Allergens-in-Goya-Food-Products-/blob/main/README.md#hypothetical-questions)
- [Contacts](https://github.com/Andyjag91/Allergens-in-Goya-Food-Products-/blob/main/README.md#contacts)

## Project Summary

This project is aimed at creating a database for customers with food allergies. We decided to concentrate on the list of products from Goya, to limit the scope of the project. Using this database, customers will be able to query ingredients to avoid based on their allergies.  The database compares Goya food products based on ingredients with a list of food allergens. This database also provides the food substitutes and lastly the list of symptoms one may experience with each food allergen. We focused on the 8 major food allergens. They are as follows:
 - Milk 
 - Eggs
 - Fish
 - Shellfish 
 - Tree nuts
 - Peanuts
 - Wheat 
 - Soybean

Based on the specific allergen, customers will be able to find alternative ingredients to use and the symptoms associated with each allergen.

## List of data sources:
### Goya Products:
 - https://world.openfoodfacts.org/brand/goya/ingredients

### Food Substitutes:
 - https://www.medicalnewstoday.com/articles/egg-substitutes#list-of-substitutes
 - https://www.medicalnewstoday.com/articles/fish-substitute 
 - https://www.outsideonline.com/2392887/milk-alternatives-substitutes-benefits-healthiest
 - https://thefitcookie.com/healthy-nut-alternatives
 - https://theveganatlas.com/7-plant-based-seafood-alternatives-that-you-need-to-try/ 
 - https://www.livekindly.co/9-vegan-proteins-to-eat-when-youre-allergic-to-soy/ 
 - https://www.eatingwithfoodallergies.com/wheat-substitutes/

### Symptoms:
 - https://acaai.org/allergies/types/food-allergy

## Technologies:
 - Beautiful Soup
 - PostgreSQL
 - Python
 - Pandas
 - Quick DBD

## Extraction, Transform, Load Process
![ERD](https://github.com/Andyjag91/Allergens-in-Goya-Food-Products-/blob/main/images/QuickDBD-export%20(1).png)

### Extraction
 - BeautifulSoup was used to scrape and extract the data from the Goya resourse website (Open Food Data). We extracted all 1154 ingredients and their products from the website. We then proceeded to filter all the ingredients down to the 8 aforementioned allergens. The raw data we extracted was in the form of nested lists, so a function was created to flatten the list, so that each product as well as their corresponding products were displayed in individual rows.
 - A similar process of extraction was utilized on each of the URL we used for the food substitutes.
 - For the symptoms table, after the extraction, a dictionary comprehension and stack fucntion in Pandas was utilized to match each allergen to the their list of symptoms.

### Transform
 - We shared the tasks of extracting each allergen products and their substitute amongst each other. So we ended up having 8 CSVs, each for products and their substitutes.
 - We concated the 8 CSVs into 1 and then proceeded to merge it with the master allergens table, joining on the allergy_id column. We did this for the products, symptoms and the substitutes tables.
 - We then reformatted the and cleaned the table, dropping unnecessary columns and duplicates.

### Load Process
- The resulting cleaned DataFrames were then imported into a PostgreSQL datadase that we created using pgAdmin.

#### Allergens Table (Left) and Products Table (Right)
![Allergens Table](https://github.com/Andyjag91/Allergens-in-Goya-Food-Products-/blob/main/images/allergens_table.png) ![Products Table](https://github.com/Andyjag91/Allergens-in-Goya-Food-Products-/blob/main/images/products_table.png) 

#### Ingredients Substitutes Table (Left) and Allergen Symptoms Table (Right)
![Substitutes Table](https://github.com/Andyjag91/Allergens-in-Goya-Food-Products-/blob/main/images/substitutes_table.png) ![Symptoms Table](https://github.com/Andyjag91/Allergens-in-Goya-Food-Products-/blob/main/images/symptoms_table.png)

## Example Queries:
 - For Users that want to list all the 8 Major Food Allergens and and their allergen_id
```sql
SELECT * FROM allergens;
```
 - For Users who have, for example, egg allergy. The query below is to get the allergy_id of the ingredient (Food Allergen)
```sql
SELECT allergy_id FROM allergens
WHERE ingredient='egg';
```
 - Users who wants to use the allergen_id to see all the products with that ingredient (Food Allergen). The sample query below uses egg (a001) 
```sql
SELECT a.allergy_id,p.ingredient,p.products
FROM allergens AS a
INNER JOIN all_products AS p
ON a.allergy_id=p.allergy_id
WHERE a.allergy_id='a001';
```
 - For Users who wants the ingredient to provide the information regarding all the substitute of ingredient(Food Allergen), here we look for egg 
```sql
SELECT p.ingredient,s.substitute
FROM all_products AS p
INNER JOIN substitutes AS  s
ON p.allergy_id=s.allergy_id
WHERE p.ingredient='egg';
```
 - Users will use the ingredient to provide the information regarding all the symptoms related to ingredient(Food Allergen) for ex- here we look for Egg(a001)!
```sql
SELECT p.ingredient,sy.symptoms
FROM all_products AS p
INNER JOIN symptoms AS  sy
ON p.allergy_id=sy.allergy_id
WHERE p.ingredient='egg';
```
 - If a person is having a particular symptom for example "Confusion" this query will return all the ingredients(food allergens) which can be associated with the symptom. 
```sql
SELECT sy.symptoms, p.ingredient
FROM symptoms AS sy
INNER JOIN all_products AS p
ON sy.allergy_id=p.allergy_id
WHERE sy.symptoms='Confusion';
```

## Hypothetical Questions:
 - What Goya food products should one avoid if allergic to a specific food allergen?
 - What ingredients are available to subsitute for a specific food allergen?
 - How does one know the symptoms of a specific food allergen?
 

