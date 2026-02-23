# 🛡️ Threat Detection Lab with Wazuh SIEM/EDR

Repositori ini mendokumentasikan implementasi dan simulasi deteksi ancaman keamanan siber menggunakan **Wazuh SIEM/EDR**. Proyek ini mencakup konfigurasi infrastruktur keamanan, pembuatan *custom detection rules*, dan analisis berbagai vektor serangan dalam lingkungan virtual.

## 🏗️ Environment Setup
* **Wazuh Manager**: Ubuntu 22.04 (IP: `192.168.15.135`)
* **Target Server (Agent)**: Ubuntu 22.04 with Apache Web Server (IP: `192.168.15.139`)
* **Attacker Machine**: Kali Linux (IP: `192.168.15.138`)

### Deployment Status
Agent `lab-server` berhasil dideploy dan terhubung secara *real-time* ke SIEM Manager.
![Agent Status](img/agent-active-status.png)

---

## ⚔️ Security Simulation & Detection Analysis

### 1. Web-based Attack: Remote Code Execution (RCE)
Simulasi serangan **Command Injection** dilakukan melalui parameter URL pada aplikasi web yang rentan.

* **Attack Vector**: Penyerang mengirimkan payload `cat /etc/passwd` melalui parameter `?cmd=`.
* **Detection Logic**: Dibuat *custom rule* (Rule ID: `100005`) untuk mendeteksi upaya pembacaan file sistem sensitif melalui log Apache.
* **Wazuh Alert**: Terdeteksi Alert Level 12 (High Severity).

![RCE Detection](img/wazuh-alert-rce-detail.png)

### 2. Authentication Attack: SSH Brute Force
Simulasi upaya akses ilegal secara masal menggunakan metode **Brute Force** dengan alat **Hydra**.

* **Attack Vector**: Percobaan login otomatis ke user `envy` secara berulang.
* **Detection**: Wazuh mendeteksi lonjakan kegagalan otentikasi (Authentication Failure) dan kegagalan modul PAM secara signifikan.

![Brute Force Detection](img/wazuh-alert-ssh-timeline.png)

### 3. Post-Exploitation: File Integrity Monitoring (FIM)
Mendeteksi aktivitas mencurigakan pasca-eksploitasi, seperti pembuatan file *backdoor* atau perubahan file sistem.

* **Mechanism**: Mengonfigurasi `syscheck` pada agent agar berjalan dalam mode **Real-time**.
* **Result**: Wazuh berhasil mendeteksi penambahan file baru (`test-fim.txt`) di direktori `/var/www/html/` secara instan.

![FIM Alert](img/wazuh-fim-event-list.png)

---

## ⚙️ Configuration Files
Detail konfigurasi teknis yang digunakan dalam lab ini dapat dilihat pada folder:
* `configs/local_rules.xml`: Logika deteksi custom untuk Command Injection.
* `configs/ossec.conf`: Konfigurasi agent untuk FIM dan pembacaan log Apache.

---
**Author**: Muhamad Yusril Malakaini
**Date**: February 2026
