"""Load cleaned book data into PostgreSQL."""

import pandas as pd
from sqlalchemy import create_engine
import os

# Folder created by PySpark
folder = "data/processed/clean_data"

# Find the CSV file inside the folder
csv_file = [f for f in os.listdir(folder) if f.endswith(".csv")][0]

file_path = os.path.join(folder, csv_file)

# Read CSV
df = pd.read_csv(file_path)

# PostgreSQL Connection
engine = create_engine(
    "postgresql://postgres:9292@localhost:5432/employee"
)

# Load data into PostgreSQL
df.to_sql(
    "books",
    engine,
    if_exists="replace",  # replace existing table
    index=False
)

print("Data loaded successfully!")

print("Data loaded successfully!")
def load():
    print("Loading data...")

