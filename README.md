🚀 Threat Detection Lab with Wazuh SIEM
Repositori ini mendokumentasikan implementasi Wazuh SIEM/EDR untuk mendeteksi berbagai jenis serangan siber secara real-time di lingkungan virtual.

🛠️ Environment Lab
SIEM Manager: Wazuh Manager (Ubuntu 22.04) - IP 192.168.15.135

Target Server: Ubuntu 22.04 with Apache2 - IP 192.168.15.139

Attacker: Kali Linux - IP 192.168.15.138

🛡️ Skenario Deteksi
1. Command Injection Detection (Web Attack)
Mendeteksi upaya eksekusi perintah sistem melalui parameter URL pada web server yang rentan.

Rule ID: 100005 (Custom Rule)

Level: 12 (High Severity)

Analisis: Wazuh berhasil menangkap payload cat /etc/passwd yang dikirimkan oleh attacker melalui protokol HTTP.

2. Privilege Escalation & Root Activity
Mendeteksi penggunaan perintah sudo oleh user yang mencoba melakukan aktivitas administratif di sistem.

Event: Successful sudo to ROOT executed

Analisis: Terdeteksi aktivitas pembuatan file mencurigakan hacked.txt di direktori /root/.

3. SSH Brute Force Detection
Mendeteksi upaya login paksa secara masal (Brute Force) menggunakan alat Hydra.
