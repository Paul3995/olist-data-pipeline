DROP TABLE IF EXISTS order_reviews, order_payments, order_items, orders,
  customers, products, sellers, geolocation, category_translation;

CREATE TABLE customers (
  customer_id TEXT PRIMARY KEY,
  customer_unique_id TEXT,
  customer_zip_code_prefix TEXT,
  customer_city TEXT,
  customer_state TEXT
);

CREATE TABLE orders (
  order_id TEXT PRIMARY KEY,
  customer_id TEXT,
  order_status TEXT,
  order_purchase_timestamp TIMESTAMP,
  order_approved_at TIMESTAMP,
  order_delivered_carrier_date TIMESTAMP,
  order_delivered_customer_date TIMESTAMP,
  order_estimated_delivery_date TIMESTAMP
);

CREATE TABLE order_items (
  order_id TEXT,
  order_item_id INT,
  product_id TEXT,
  seller_id TEXT,
  shipping_limit_date TIMESTAMP,
  price NUMERIC,
  freight_value NUMERIC,
  PRIMARY KEY (order_id, order_item_id)
);

CREATE TABLE order_payments (
  order_id TEXT,
  payment_sequential INT,
  payment_type TEXT,
  payment_installments INT,
  payment_value NUMERIC
);

CREATE TABLE order_reviews (
  review_id TEXT,
  order_id TEXT,
  review_score INT,
  review_comment_title TEXT,
  review_comment_message TEXT,
  review_creation_date TIMESTAMP,
  review_answer_timestamp TIMESTAMP
);

CREATE TABLE products (
  product_id TEXT PRIMARY KEY,
  product_category_name TEXT,
  product_name_length INT,
  product_description_length INT,
  product_photos_qty INT,
  product_weight_g INT,
  product_length_cm INT,
  product_height_cm INT,
  product_width_cm INT
);

CREATE TABLE sellers (
  seller_id TEXT PRIMARY KEY,
  seller_zip_code_prefix TEXT,
  seller_city TEXT,
  seller_state TEXT
);

CREATE TABLE geolocation (
  geolocation_zip_code_prefix TEXT,
  geolocation_lat NUMERIC,
  geolocation_lng NUMERIC,
  geolocation_city TEXT,
  geolocation_state TEXT
);

CREATE TABLE category_translation (
  product_category_name TEXT PRIMARY KEY,
  product_category_name_english TEXT
);

COPY customers FROM '/data/olist_customers_dataset.csv' WITH (FORMAT csv, HEADER true);
COPY orders FROM '/data/olist_orders_dataset.csv' WITH (FORMAT csv, HEADER true);
COPY order_items FROM '/data/olist_order_items_dataset.csv' WITH (FORMAT csv, HEADER true);
COPY order_payments FROM '/data/olist_order_payments_dataset.csv' WITH (FORMAT csv, HEADER true);
COPY order_reviews FROM '/data/olist_order_reviews_dataset.csv' WITH (FORMAT csv, HEADER true);
COPY products FROM '/data/olist_products_dataset.csv' WITH (FORMAT csv, HEADER true);
COPY sellers FROM '/data/olist_sellers_dataset.csv' WITH (FORMAT csv, HEADER true);
COPY geolocation FROM '/data/olist_geolocation_dataset.csv' WITH (FORMAT csv, HEADER true);
COPY category_translation FROM '/data/product_category_name_translation.csv' WITH (FORMAT csv, HEADER true);