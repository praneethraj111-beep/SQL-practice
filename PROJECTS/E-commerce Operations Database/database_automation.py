import psycopg2
import csv # Added this to handle Excel-friendly files

try:
    connection = psycopg2.connect(
        user="postgres",
        password="Manish@030",
        host="127.0.0.1",
        port="5432",
        database="postgres"
    )

    cursor = connection.cursor()
    cursor.execute("SELECT full_name FROM users;")
    record = cursor.fetchall()

    print("Connection Successful! Here are your customers:")
    for row in record:
        print(f"Customer Name: {row[0]}")

    # --- ADD THE 3 LINES BELOW THIS LINE ---
    with open('customer_report.csv', 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(['Customer Name']) # This creates the Excel Header
        writer.writerows(record)           # This writes all the names
    print("Success! 'customer_report.csv' has been created in your folder.")
    # ---------------------------------------

except Exception as error:
    print(f"Error while connecting to PostgreSQL: {error}")

finally:
    if connection:
        cursor.close()
        connection.close()
        print("PostgreSQL connection is closed.")