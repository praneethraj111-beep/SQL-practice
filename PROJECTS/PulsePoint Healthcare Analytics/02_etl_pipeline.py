import pandas as pd
from sqlalchemy import create_engine
import urllib.parse  # Import this to handle special characters

# 1. Safely encode the password containing '@'
raw_password = "Manish@030"
encoded_password = urllib.parse.quote_plus(raw_password)

# 2. Setup the connection string using the encoded password
conn_string = f"postgresql://postgres:{encoded_password}@localhost:5432/postgres"
engine = create_engine(conn_string)

def run_etl():
    try:
        # 3. EXTRACT: Load the third-party file
        print("Starting Extraction...")
        df = pd.read_csv('hospital_raw_data.csv')

        # 4. TRANSFORM: Professional cleaning
        df['pat_name'] = df['pat_name'].str.upper()
        
        # 5. LOAD: Pump it into the Staging Area
        print("Loading into SQL Staging...")
        df.to_sql('stg_hospital_data', engine, schema='pulsepoint', if_exists='replace', index=False)
        
        print("✅ Success! The 'Robot' has finished the delivery.")

    except Exception as e:
        print(f"❌ Error during delivery: {e}")

if __name__ == "__main__":
    run_etl()