import sys
import boto3
from sqlalchemy import create_engine, Table, MetaData, Column, Integer, String, DateTime, Float
from sqlalchemy.sql import select, insert, update, delete
import json

# Fetch RDS credentials from Secrets Manager
def get_db_credentials(secret_arn):
    secrets_manager = boto3.client('secretsmanager')
    secret = secrets_manager.get_secret_value(SecretId=secret_arn)
    secret_value = secret['SecretString']
    credentials = json.loads(secret_value)
    return credentials

# Fetch the RDS endpoint dynamically using boto3 (if you want)
def get_rds_endpoint(db_instance_identifier):
    rds_client = boto3.client('rds')
    response = rds_client.describe_db_instances(DBInstanceIdentifier=db_instance_identifier)
    endpoint = response['DBInstances'][0]['Endpoint']['Address']
    return endpoint

# AWS RDS settings
secret_arn = "arn:aws:secretsmanager:region:account-id:secret:my-db-credentials"
db_instance_identifier = "mydbinstance"
db_name = "mydb"

isLocal = (len(sys.argv) == 2) and (sys.argv[1] == 'local')

# Check if we are running on AWS or locally
if not isLocal:
# if is_running_in_aws():
    # Get DB credentials from Secrets Manager
    credentials = get_db_credentials(secret_arn)
    db_user = credentials['username']
    db_password = credentials['password']
    
    # Get the RDS endpoint dynamically
    rds_endpoint = get_rds_endpoint(db_instance_identifier)
else:
    # If running locally, use a local PostgreSQL instance (replace with your local DB settings)
    db_user = "postgres"
    db_password = "root"
    rds_endpoint = "host.docker.internal"  # Localhost for local Postgres
    db_name = "postgres"

# Build the database connection URL
db_url = f"postgresql+psycopg2://{db_user}:{db_password}@{rds_endpoint}/{db_name}"

# Create the engine
engine = create_engine(db_url, echo=True)

# Define metadata and table structure
metadata = MetaData()

crime_reports = Table('crime_reports', metadata,
    Column('DR_NO', String(10), primary_key=True),
    Column('date_rptd', DateTime, nullable=False),
    Column('date_occ', DateTime, nullable=False),
    Column('time_occ', String(4), nullable=False),
    Column('area', String(2), nullable=False),
    Column('area_name', String(50), nullable=False),
    Column('rpt_dist_no', String(4), nullable=False),
    Column('part_1_2', Integer, nullable=False),
    Column('crm_cd', Integer, nullable=False),
    Column('crm_cd_desc', String(100)),
    Column('mocodes', String(100)),
    Column('vict_age', Integer),
    Column('vict_sex', String(1)),
    Column('vict_descent', String(1)),
    Column('premis_cd', String(3)),
    Column('premis_desc', String(100)),
    Column('weapon_used_cd', String(3)),
    Column('weapon_desc', String(100)),
    Column('status', Integer, nullable=False),
    Column('status_desc', String(100)),
    Column('crm_cd_1', Integer),
    Column('crm_cd_2', Integer),
    Column('crm_cd_3', Integer),
    Column('crm_cd_4', Integer),
    Column('location', String(100)),
    Column('cross_street', String(100)),
    Column('lat', Float),
    Column('lon', Float)
)

# Create the table in the database if it doesn't exist
metadata.create_all(engine)