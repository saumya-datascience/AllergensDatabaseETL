--1)For the Users Information, list all the Ingredients
--(Food Allergens and) and their Allergen Id
SELECT * FROM allergens;


--2)lets start as an example of a person having egg allergy.This query is to get the Allergy_id
-- of the ingredient(Food Allergen)
SELECT allergy_id FROM allergens
WHERE ingredient='egg';


--3) Users will use the allergen ID to provide the information regarding all the products
--with that ingredient(Food Allergen) for ex- here we look for Egg(a001)
SELECT a.allergy_id,p.ingredient,p.products
FROM allergens AS a
INNER JOIN all_products AS p
ON a.allergy_id=p.allergy_id
WHERE a.allergy_id='a001';

--4) Users will use the ingredient to provide the information regarding all the substitute 
--of ingredient(Food Allergen) for ex- here we look for Egg(a001)
SELECT p.ingredient,s.substitute
FROM all_products AS p
INNER JOIN substitutes AS  s
ON p.allergy_id=s.allergy_id
WHERE p.ingredient='egg';


--5) Users will use the ingredient to provide the information regarding all the symptoms related to
-- ingredient(Food Allergen) for ex- here we look for Egg(a001)
SELECT p.ingredient,sy.symptoms
FROM all_products AS p
INNER JOIN symptoms AS  sy
ON p.allergy_id=sy.allergy_id
WHERE p.ingredient='egg';

--6)If a person is having a particular symptom for ex "Confusion" this query will return all 
--the ingredients(food allergens) which can be associated  with the symptom.
SELECT sy.symptoms, p.ingredient
FROM symptoms AS sy
INNER JOIN all_products AS p
ON sy.allergy_id=p.allergy_id
WHERE sy.symptoms='Confusion';
