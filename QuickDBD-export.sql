-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "allergens" (
    "allergy_id" VARCHAR   NOT NULL,
    "ingredient" VARCHAR   NOT NULL,
    CONSTRAINT "pk_allergens" PRIMARY KEY (
        "allergy_id"
     )
);

CREATE TABLE "all_products" (
    "id" INT   NOT NULL,
    "allergy_id" VARCHAR   NOT NULL,
    "ingredient" VARCHAR   NOT NULL,
    "products" VARCHAR   NOT NULL
);

CREATE TABLE "substitutes" (
    "id" INT   NOT NULL,
    "allergy_id" VARCHAR   NOT NULL,
    "substitute" VARCHAR   NOT NULL
);

CREATE TABLE "symptoms" (
    "id" INT   NOT NULL,
    "allergy_id" VARCHAR   NOT NULL,
    "symptoms" VARCHAR   NOT NULL
);

ALTER TABLE "all_products" ADD CONSTRAINT "fk_all_products_allergy_id" FOREIGN KEY("allergy_id")
REFERENCES "allergens" ("allergy_id");

ALTER TABLE "substitutes" ADD CONSTRAINT "fk_substitutes_allergy_id" FOREIGN KEY("allergy_id")
REFERENCES "allergens" ("allergy_id");

ALTER TABLE "symptoms" ADD CONSTRAINT "fk_symptoms_allergy_id" FOREIGN KEY("allergy_id")
REFERENCES "allergens" ("allergy_id");

