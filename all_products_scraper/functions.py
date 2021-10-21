import requests
from bs4 import BeautifulSoup as bs

# Function returns a nested list of each product by ingredients from the url
def get_products(url):
    response = requests.get(url)
    soup = bs(response.text, "html.parser")
    products = soup.find_all("span")
    products_text = [product.get_text() for product in products]
    product_clean = products_text[6:]
    final_product_list = [i.replace("\xa0"," ") for i in product_clean]
    return final_product_list


# This function flattens the result
def flatten_list(nested_list):
    x = []
    for i in nested_list:
        x.extend(i)
    return x

