# import sys

# # Check if AWS Glue is available
# try:
#     from awsglue.utils import getResolvedOptions
#     from awsglue.context import GlueContext
#     from pyspark.context import SparkContext
#     is_glue = True
# except ImportError:
#     is_glue = False
#     from pyspark.sql import SparkSession

# # Initialize the SparkContext and GlueContext for AWS Glue
# if is_glue:
#     sc = SparkContext()
#     glueContext = GlueContext(sc)
#     spark = glueContext.spark_session
#     args = getResolvedOptions(sys.argv, ['JOB_NAME', 'bucketName', 'objectKey'])
#     path = f"s3://{args['bucketName']}/{args['objectKey']}"
# else:
#     # Initialize SparkSession for local mode
#     spark = SparkSession.builder.appName("LocalSparkApp").getOrCreate()
    
#     # Simulate the arguments for local testing
#     args = {'JOB_NAME': 'local_job', 'bucketName': 'your-bucket-name', 'objectKey': 'Crime_Data_from_2020_to_Present.csv'}
#     path = f"./assets/{args['objectKey']}"

# # Read the CSV file into a DataFrame
# df = spark.read.csv(path, header=True, inferSchema=True)

# # Show the DataFrame
# df.show(5)

# db_properties = {
#     "user": "postgres",
#     "password": "root",
#     "driver": "org.postgresql.Driver"
# }

# jdbc_url = "jdbc:postgresql://host.docker.internal:5432/postgres"

# df.write.jdbc(url=jdbc_url, table="crime_reports", mode="overwrite", properties=db_properties)

print("Hello, world!")