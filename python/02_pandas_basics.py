import pandas as pd
from sqlalchemy import create_engine

engine = create_engine("postgresql+psycopg2://olist:olist@localhost:5433/olist")

orders = pd.read_sql("SELECT * FROM orders", engine)
items = pd.read_sql("SELECT * FROM order_items", engine)

# 1. FILTER (like WHERE)
canceled = orders[orders["order_status"] == "canceled"]
print("Canceled orders:", len(canceled))

# 2. GROUP BY (count orders per status)
print(orders["order_status"].value_counts())

# 3. GROUP BY + SUM (revenue per order)
revenue = items.groupby("order_id")["price"].sum()
print("Biggest order value:", revenue.max())

# 4. MERGE (like JOIN): attach order status to each item
merged = items.merge(orders[["order_id", "order_status"]], on="order_id")
print(merged.head())

# 5. MONTHLY REVENUE
merged = merged.merge(orders[["order_id", "order_purchase_timestamp"]], on="order_id")
merged["month"] = merged["order_purchase_timestamp"].dt.to_period("M")
print(merged.groupby("month")["price"].sum())