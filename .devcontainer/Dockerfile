# Use an official Python image as the base image
FROM python:3.9-bullseye

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    openjdk-11-jre-headless \
    && rm -rf /var/lib/apt/lists/*

# Set Java environment variables for AWS Glue
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Verify Java installation
RUN java -version && ls -l $JAVA_HOME/bin/java

# Install Terraform
RUN curl -LO https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_amd64.zip \
    && unzip terraform_1.5.7_linux_amd64.zip -d /usr/local/bin \
    && rm terraform_1.5.7_linux_amd64.zip

# Install AWS CLI (required for AWS Glue)
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws

# Install PySpark and Pandas
RUN pip install --no-cache-dir pyspark pandas boto3

# Manually Install AWS Glue Libraries
RUN pip install --no-cache-dir \
    awscli \
    numpy \
    pyarrow \
    requests \
    typing-extensions \
    --extra-index-url https://aws-glue-etl-artifacts.s3.amazonaws.com/release/Glue4.0/latest/

# Set the working directory
WORKDIR /workspace

# Set environment variables (optional)
ENV PYSPARK_PYTHON=python3
ENV PYSPARK_DRIVER_PYTHON=python3

# Run AWS Glue locally
CMD ["python3"]