

from extract.scrape_books import extract
from transform.etl_pyspark import transform
from load.load_postgres import load

def main():
    extract()
    transform()
    load()
    print("Pipeline Completed Successfully")

if __name__ == "__main__":
    main()