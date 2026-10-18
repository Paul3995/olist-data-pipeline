import pandas as pd
from sqlalchemy import create_engine

engine = create_engine("postgresql+psycopg2://olist:olist@localhost:5433/olist")

orders = pd.read_sql("SELECT * FROM orders", engine)

print(orders.shape)
print(orders.head())