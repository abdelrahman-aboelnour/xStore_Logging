echo "Creating directory 'Vois_Scripts' and copying 'Vois_Log_Script.sh' into it"
mkdir -p ~/VOIS_Scripts;
cp VOIS_Log_Script.sh ~/VOIS_Scripts;
echo "Making 'Vois_Log_Script.sh' executable"
chmod +x ~/VOIS_Scripts/VOIS_Log_Script.sh;


echo "scheduling task to run command every day at 12:00 am that pulls logs"
# Register VOIS_Log_Script to run daily at 12:05 am
crontab -l > "mycron";
echo "0 0 * * * ~/VOIS_Scripts/VOIS_Log_Script.sh 1>>~/VOIS_Scripts/VOIS_Log_Script_Debug.log 2>>~/VOIS_Scripts/VOIS_Log_Script_Error.log " >> mycron;
crontab "mycron";
rm "mycron";

echo "Running script with days to go back paremeter = 7 for one time."
# Run the script now with input parameter to get last 7 days of logs
source ~/VOIS_Scripts/VOIS_Log_Script.sh 7;
