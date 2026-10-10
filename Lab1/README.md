Linux Antivirus

1. Overview

This project is a simple antivirus system written in Bash.
It monitors a directory for changes and scans files for malicious extensions and keywords.

Malicious files are copied to a quarantine directory and then deleted from the original directory.

The project also includes a restore tool that allows users to restore files, permanently delete them, or leave them in quarantine.

2. Project Structure

- antivirusd.sh: Monitors the directory and scans files.
- restore.sh: Allows users to manage quarantined files.
- Makefile: Simplifies running the scripts.
- README.md: Project documentation.
- files/: Directory containing files to scan.
- quarantine/: Directory containing malicious files.

3. Running the Antivirus

Navigate to the project directory:

    cd ~/Desktop/Lab1

Run the antivirus using:

    make antivirus

The antivirus receives three arguments:
- Directory to monitor.
- Directory to store malicious files.
- Scan interval in seconds.

To stop the antivirus, press Ctrl+C.

4. Restoring Files

Run the restore tool:

    make restore

The program lists quarantined files and allows the user to:
1. Restore a file to the original directory.
2. Permanently delete a file.
3. Leave a file in quarantine.

5. Malicious File Detection

The antivirus identifies malicious files using two checks.

Malicious Extensions

- .exe
- .bat
- .vbs
- .scr
- .ps1

Malicious Keywords

The antivirus searches file contents for these keywords, ignoring case:

- virus
- trojan
- malware
- worm
- ransomware

If a file matches either check, it is considered malicious.

Bonus 1: Cron Job

Overview

The project includes antivirus-cron.sh, which scans files and moves
malicious files to the quarantine directory.

Unlike antivirusd.sh, which runs continuously using a while loop,
antivirus-cron.sh performs one scan and then exits.

Cron is responsible for scheduling the scans automatically.

Prerequisites

- Ubuntu Linux
- Bash
- Cron installed and running
- antivirus-cron.sh created in the project directory
- The monitored directory and quarantine directory configured correctly

Install Cron:

    sudo apt update
    sudo apt install cron

Start and enable the Cron service:

    sudo systemctl enable --now cron

Running the Cron Script Manually

Navigate to the project directory:

    cd ~/Desktop/Lab1

Run the script:

    bash antivirus-cron.sh /home/omer/Desktop/Lab1/files /home/omer/Desktop/Lab1/quarantine

The script scans the directory once and exits.

Configure Cron to Run Every Minute at Second 23

1. Open the user's crontab:

       crontab -e

2. Add the following line:

       * * * * * sleep 23; /bin/bash /home/omer/Desktop/Lab1/antivirus-cron.sh /home/omer/Desktop/Lab1/files /home/omer/Desktop/Lab1/quarantine >> /home/omer/Desktop/Lab1/cron.log 2>&1

3. Save the file and exit.

4. Verify the scheduled job:

       crontab -l

5. Check the execution log:

       cat /home/omer/Desktop/Lab1/cron.log

The command runs every minute and waits 23 seconds before starting
the scan. Execution may occur later depending on system load.

Standard Cron does not support seconds directly, so sleep 23 is used
to delay the execution.

Cron Expression for the Third Friday of Every Month

The requirement is to run the scan at 12:31 AM on the third Friday
of every month.

The Cron expression is:

    31 0 * * 5

Cron fields:

- 31: Minute
- 0: Hour (12:00 AM)
- *: Every day of the month
- *: Every month
- 5: Friday

The third Friday falls between the 15th and 21st of each month.
Therefore, a date check is required to ensure the scan runs only
on the third Friday.

Use this crontab entry:

    31 0 * * 5 day=$(date +\%d); [ "$day" -ge 15 ] && [ "$day" -le 21 ] && /bin/bash /home/omer/Desktop/Lab1/antivirus-cron.sh /home/omer/Desktop/Lab1/files /home/omer/Desktop/Lab1/quarantine >> /home/omer/Desktop/Lab1/cron.log 2>&1

The date check ensures that the scan runs only when the day of
the month is between 15 and 21 and the day of the week is Friday.
