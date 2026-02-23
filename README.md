# 🛡️ Threat Detection Lab with Wazuh SIEM/EDR

Repositori ini mendokumentasikan implementasi dan simulasi deteksi ancaman keamanan siber menggunakan **Wazuh SIEM/EDR** di lingkungan virtual. Proyek ini mencakup konfigurasi deteksi kustom, pemantauan integritas file (FIM), dan analisis serangan aplikasi web secara *real-time*.

## 🏗️ Infrastruktur Lab
* **SIEM Manager**: Wazuh Manager (Ubuntu 22.04) - IP: `192.168.15.135`
* **Target Server**: Ubuntu 22.04 (Apache & SSH) - IP: `192.168.15.139`
* **Attacker Machine**: Kali Linux - IP: `192.168.15.138`

### Deployment Status
Agent `lab-server` berhasil diinstal dan terhubung ke dashboard dengan status **Active**.
![Agent Status](img/agent-active-status.png)

---

## ⚔️ Security Simulation & Detection Analysis

### 1. Remote Code Execution (RCE) - Command Injection
Mendeteksi upaya eksekusi perintah sistem melalui parameter URL pada web server.

* **Metode Serangan**: Mengirimkan payload `cat /etc/passwd` menggunakan `curl`.
* **Hasil Eksploitasi**: Penyerang berhasil membaca data user sistem.
* **Deteksi SOC**: Implementasi **Custom Rule ID: 100005** menghasilkan alert **Level 12 (High Severity)**.

![RCE Detail](img/wazuh-alert-rce-detail.png)
![RCE Timeline](img/security-events-timeline(rce).png)

### 2. Brute Force Attack - SSH
Mendeteksi upaya login paksa menggunakan kamus password melalui protokol SSH.

* **Metode Serangan**: Menggunakan **Hydra** untuk menyerang user `envy`.
* **Analisis Alert**: Terdeteksi lonjakan kegagalan otentikasi (spike) pada dashboard.
* **Detail Teknis**: Log menunjukkan kegagalan otentikasi pada level sistem (PAM).

![SSH Spike](img/wazuh-alert-ssh-timeline.png)
![PAM Failure](img/ssh-pam-auth-failure.png)

### 3. File Integrity Monitoring (FIM)
Memantau perubahan dan penambahan file pada direktori web server secara instan.

* **Konfigurasi**: Mengaktifkan mode `realtime="yes"` pada direktori `/var/www/html/`.
* **Skenario**: Deteksi pembuatan file mencurigakan `test-fim.txt` oleh penyerang.
* **Hasil Deteksi**: Alert **Rule 554 (File added to the system)** terekam secara otomatis.

![FIM Alert](img/wazuh-fim-alert-added.png)

---

## ⚙️ Configuration & Scripts
Detail teknis untuk mereplikasi lab ini tersedia di folder berikut:
* [**configs/**](configs/): Berisi `local_rules.xml` (Logic Deteksi) dan `ossec.conf` (FIM Config).
* [**scripts/**](scripts/): Berisi `vulnerable.php` (Vulnerability Simulation) dan `attack_commands.sh` (Attack Command List).

---
**Author**: Muhamad Yusril Malakaini
**Date**: February 2026
