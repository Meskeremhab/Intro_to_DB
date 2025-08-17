#!/usr/bin/env python3
"""
MySQLServer.py
Creates the database `alx_book_store` on a MySQL server.
- Prints a success message when created (or already present).
- Does NOT use SELECT or SHOW.
- Handles connection errors.
- Opens and closes the DB connection safely.
"""

import sys
import argparse
from getpass import getpass

try:
    import mysql.connector as mysql
    from mysql.connector import Error
except ImportError:
    print("ERROR: mysql-connector-python is not installed.\n"
          "Install it with:  pip install mysql-connector-python")
    sys.exit(1)


def main():
    parser = argparse.ArgumentParser(description="Create the alx_book_store database.")
    parser.add_argument("--host", default="localhost", help="MySQL host (default: localhost)")
    parser.add_argument("--port", type=int, default=3306, help="MySQL port (default: 3306)")
    parser.add_argument("--user", default="root", help="MySQL username (default: root)")
    parser.add_argument("--password", help="MySQL password (omit to be prompted securely)")
    args = parser.parse_args()

    password = args.password if args.password is not None else getpass("MySQL password: ")

    conn = None
    cursor = None
    try:
        # Connect WITHOUT specifying a database
        conn = mysql.connect(
            host=args.host,
            port=args.port,
            user=args.user,
            password=password,
        )

        # Create cursor and run DDL
        cursor = conn.cursor()
        cursor.execute("CREATE DATABASE IF NOT EXISTS alx_book_store")

        # Success message (no SELECT/SHOW used)
        print("Database 'alx_book_store' created successfully!")

    except Error as e:
        # Print a clean error message on failure
        print(f"Failed to connect or create database: {e}")
        sys.exit(1)

    finally:
        # Close cursor and connection if they were opened
        if cursor is not None:
            try:
                cursor.close()
            except Exception:
                pass
        if conn is not None and conn.is_connected():
            try:
                conn.close()
            except Exception:
                pass


if __name__ == "__main__":
    main()
