import pandas as pd
from sqlalchemy import create_engine
import argparse
import os

parser = argparse.ArgumentParser('Ingest CSV data to Postgres')

parser.add_argument('--user', help='username for postgres')
parser.add_argument('--password', help='password for postgres')
parser.add_argument('--host', help='host for postgres')
parser.add_argument('--port', help='port for postgres')
parser.add_argument('--db', help='database name for postgres')
parser.add_argument('--table_name', help='name of tjhe table where we will write the results')
parser.add_argument('--url', help='URL of the parquet file')
parser.add_argument('--parquet_name', help='name of the parquet file in local')

def main(params):
    user, password = params.user, params.password
    host, port = params.host, params.port
    db, table_name = params.db, params.table_name
    url, parquet_name = params.url, params.parquet_name
    parquet_name: str = 'output.parquet'

    os.system(f'wget {url} -O {parquet_name}')

    df = pd.read_parquet(parquet_name)

    engine = create_engine(url=f'postgresql://{user}:{password}@{host}:{port}/{db}')

    df.head().to_sql(con=engine, name=table_name, if_exists='replace')


if __name__ == '__main__':
    args = parser.parse_args()
    main(args)