
DIR = /home/omer/Desktop/Lab1/files
MALICIOUS_DIR = /home/omer/Desktop/Lab1/quarantine
INTERVAL = 5

antivirus:
	bash antivirusd.sh $(DIR) $(MALICIOUS_DIR) $(INTERVAL)

restore:
	bash restore.sh $(DIR) $(MALICIOUS_DIR)
