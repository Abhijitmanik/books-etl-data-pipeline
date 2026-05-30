# Books ETL Data Pipeline

## Overview

This project demonstrates an end-to-end ETL (Extract, Transform, Load) Data Pipeline using Python, PySpark, and PostgreSQL.

The pipeline extracts book data from the BooksToScrape website, transforms and cleans the data using PySpark, loads the processed data into PostgreSQL, and performs SQL-based analysis.

## Project Architecture

BooksToScrape Website

↓

Python + BeautifulSoup (Extract)

↓

Raw CSV Data

↓

PySpark ETL (Transform)

↓

Cleaned Data

↓

PostgreSQL (Load)

↓

SQL Analysis

## Tech Stack

* Python
* BeautifulSoup
* Requests
* Pandas
* PySpark
* PostgreSQL
* SQLAlchemy
* Git & GitHub

## Project Structure

books-etl-data-pipeline/

├── config/

├── data/

│   ├── raw/

│   │   └── books_raw.csv

│   └── processed/

│       └── clean_data/

├── extract/

│   └── scrape_books.py

├── transform/

│   └── etl_pyspark.py

├── load/

│   └── load_postgres.py

├── sql/

│   ├── create_table.sql

│   └── analysis_queries.sql

├── logs/

│   └── pipeline.log

├── main.py

├── requirements.txt

└── README.md

## ETL Process

### Extract

* Scraped book data from BooksToScrape
* Extracted:

  * Title
  * Price
  * Rating
* Stored raw data in CSV format

### Transform

* Cleaned price values
* Converted ratings into numeric format
* Removed invalid records
* Processed data using PySpark

### Load

* Loaded transformed data into PostgreSQL
* Created books table
* Inserted all cleaned records

### Analysis

Performed SQL analysis including:

* Top expensive books
* Average book price
* Rating distribution
* Window functions
* CTEs
* Ranking queries

## Sample SQL Query

```sql
WITH cte AS
(
    SELECT
        title,
        rating,
        price,
        ROW_NUMBER() OVER
        (
            PARTITION BY rating
            ORDER BY price DESC
        ) AS rn
    FROM books
)
SELECT *
FROM cte
WHERE rn <= 5;
```

## Installation

Clone repository:

```bash
git clone https://github.com/Abhijitmanik/books-etl-data-pipeline.git
```

Install dependencies:

```bash
pip install -r requirements.txt
```

## Run Pipeline

Execute:

```bash
python main.py
```

## Results

* Successfully scraped 1000+ book records
* Built a complete ETL pipeline
* Loaded data into PostgreSQL
* Performed advanced SQL analysis

## Author

Abhijit Manik

Senior Data Analyst Engineer

Aspiring Data Engineer
