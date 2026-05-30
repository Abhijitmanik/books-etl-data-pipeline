import requests
from bs4 import BeautifulSoup
import pandas as pd

books = []

for page in range(1, 51):

    if page == 1:
        url = "https://books.toscrape.com/"
    else:
        url = f"https://books.toscrape.com/catalogue/page-{page}.html"

    response = requests.get(url)
    soup = BeautifulSoup(response.text, "html.parser")

    for book in soup.find_all("article", class_="product_pod"):

        title = book.h3.a["title"]
        price = book.find("p", class_="price_color").text
        rating = book.find("p")["class"][1]

        books.append({
            "title": title,
            "price": price,
            "rating": rating
        })

df = pd.DataFrame(books)
df.to_csv("./data/raw/books_raw.csv", index=False)

print(f"Total books scraped: {len(df)}")

def extract():
    print("Extracting data...")

    