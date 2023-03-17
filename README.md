# xStore_Logging

## STEPS To Install:

1. copy the 2 scripts "VOIS_Log_Script.sh" and "script.sh" into a working directory.

2. download and install 'ec2-metadata' tool (skip if using Amazon Linux AMI).

3. set the required configuration for log extraction inside the VOIS_Log_Script.sh:

    END_DATE: specify the last day + 1 on which to get logs (default: '$(date +%Y-%m-%d)')
    LOG_FILES_PATH: specify the folder on which the log files are located (default: '/var/log/xStore_Logs/')
    LOG_FILE_PREFIX: specify the prefix of the log files, for example if log file name for day 17/03/2023 is 'Backend-2023-03-17.log', prefix is 'Backend' (default: Backend)
    CURRENT_INSTANCE_ID: specify the unique identifier of current instance (default: '$(ec2-metadata -i | cut -d ' ' -f 2)')
    BUCKET_NAME: the name of the s3 bucket on which the log files will be archived on (default: 'vois-logs-bucket')
    
4. make the 'script.sh' file executable by running the command 'chmod +x script.sh'

5. (OPTIONAL): copy the log samples to test the script with real files from the "Sample Log Files" folder to the LOG_FILES_PATH on the ec2 instance.

6. execute the "script.sh" file. 
  
