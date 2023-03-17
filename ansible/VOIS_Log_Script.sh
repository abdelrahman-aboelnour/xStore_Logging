#!/bin/bash

# Check if the user specified an input parameter
if [ -z "$1" ]
then
    # If no input parameter is specified, use the default value
    DAYS_T0_GO_BACK="1"
else
    # If an input parameter is specified, use it
    DAYS_T0_GO_BACK="$1"
fi

# Set the date range for the logs to be collected
END_DATE=$(date +%Y-%m-%d)
START_DATE=$(date -I -d "$END_DATE - $DAYS_T0_GO_BACK day")
BUCKET_NAME="vois-logging-bucket"
LOG_FILES_PATH="/var/log/xStore_Logs/"
LOG_FILE_PREFIX="Backend"
CURRENT_INSTANCE_ID=$(ec2-metadata -i | cut -d ' ' -f 2)

# Loop through each date within the date range
while [[ "$START_DATE" < "$END_DATE" ]]; do
  # Set the date and time for the logs to be collected
  DATE="$START_DATE"

  # Check if the log file exists on the EC2 instance
  if [ -f "$LOG_FILES_PATH/$LOG_FILE_PREFIX-$DATE.log" ]; then
    echo "Log file $LOG_FILE_PREFIX-$DATE.log exists. Checking if already on S3 Bucket..."
	
	if aws s3 ls "s3://$BUCKET_NAME/$CURRENT_INSTANCE_ID/$LOG_FILE_PREFIX-$DATE.log"; then
		echo "File $FILE_NAME already exists in S3 bucket $BUCKET_NAME, skipping...."
	else
		echo "File $FILE_NAME does not exist in S3 bucket $BUCKET_NAME, uploading file..."
		aws s3 cp "$LOG_FILES_PATH/$LOG_FILE_PREFIX-$DATE.log" "s3://$BUCKET_NAME/$CURRENT_INSTANCE_ID/$LOG_FILE_PREFIX-$DATE.log"
	fi
	
  else
    echo "Log file $LOG_FILE_NAME-$DATE.log does not exist in path $LOG_FILES_PATH."
  fi

  # Increment the date by one day
  START_DATE=$(date -I -d "$START_DATE + 1 day")
done