-- CREATE DATABASE AND SELECT IT
CREATE DATABASE IF NOT EXISTS alx_book_store CHARACTER SET UTF8MB4 COLLATE UTF8MB4_UNICODE_CI;
USE alx_book_store;

-- AUTHORS
CREATE TABLE Authors (
  author_id INT NOT NULL AUTO_INCREMENT,
  author_name VARCHAR(215) NOT NULL,
  PRIMARY KEY (author_id)
) ENGINE=INNODB;

-- BOOKS
CREATE TABLE Books (
  book_id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(130) NOT NULL,
  author_id INT NOT NULL,
  price DOUBLE NOT NULL,
  publication_date DATE,
  PRIMARY KEY (book_id),
  CONSTRAINT fk_books_author
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
      ON UPDATE RESTRICT ON DELETE RESTRICT
) ENGINE=INNODB;

-- CUSTOMERS
CREATE TABLE Customers (
  customer_id INT NOT NULL AUTO_INCREMENT,
  customer_name VARCHAR(215) NOT NULL,
  email VARCHAR(215),
  address TEXT,
  PRIMARY KEY (customer_id)
) ENGINE=INNODB;

-- ORDERS
CREATE TABLE Orders (
  order_id INT NOT NULL AUTO_INCREMENT,
  customer_id INT NOT NULL,
  order_date DATE NOT NULL,
  PRIMARY KEY (order_id),
  CONSTRAINT fk_orders_customer
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
      ON UPDATE RESTRICT ON DELETE RESTRICT
) ENGINE=INNODB;

-- ORDER_DETAILS
CREATE TABLE Order_Details (
  orderdetailid INT NOT NULL AUTO_INCREMENT,
  order_id INT NOT NULL,
  book_id INT NOT NULL,
  quantity DOUBLE NOT NULL,
  PRIMARY KEY (orderdetailid),
  CONSTRAINT fk_orderdetails_order
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id)
      ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT fk_orderdetails_book
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
      ON UPDATE RESTRICT ON DELETE RESTRICT
) ENGINE=INNODB;

-- HELPFUL INDEXES ON FOREIGN KEYS
CREATE INDEX idx_books_author_id ON Books(author_id);
CREATE INDEX idx_orders_customer_id ON Orders(customer_id);
CREATE INDEX idx_orderdetails_order_id ON Order_Details(order_id);
CREATE INDEX idx_orderdetails_book_id ON Order_Details(book_id);
