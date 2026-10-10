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
