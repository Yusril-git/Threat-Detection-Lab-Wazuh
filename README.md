# 🛡️ Threat Detection Lab with Wazuh SIEM/EDR

Repositori ini mendokumentasikan implementasi, konfigurasi, dan simulasi deteksi ancaman menggunakan **Wazuh SIEM/EDR**. Proyek ini dirancang untuk mensimulasikan alur kerja seorang **SOC Analyst** dalam mendeteksi serangan aplikasi web, upaya akses ilegal (Brute Force), dan pemantauan integritas file (FIM) secara *real-time*.

## 🏗️ Infrastruktur Lab
* **SIEM Manager**: Wazuh Manager (Ubuntu 22.04) - IP: `192.168.15.135`
* **Target Server**: Ubuntu 22.04 with Apache & SSH - IP: `192.168.15.139`
* **Attacker**: Kali Linux - IP: `192.168.15.138`

### Deployment Status
Agent `lab-server` telah dideploy dan terhubung ke dashboard manager dengan status **Active**.
![Agent Status](img/agent-active-status.png)

---

## ⚔️ Skenario 1: Remote Code Execution (RCE) Detection
Simulasi serangan **Command Injection** melalui parameter URL pada aplikasi web yang rentan.

* **Attack Vector**: Eksekusi payload `cat /etc/passwd` menggunakan `curl` dari mesin penyerang.
* **Impact**: Penyerang berhasil mendapatkan data sensitif user dari file `/etc/passwd`.
* **Detection Logic**: Implementasi **Custom Rule (ID: 100005)** pada `local_rules.xml` untuk mendeteksi pembacaan file sistem via HTTP.
* **Alert Analysis**: Wazuh menghasilkan Alert **Level 12** (High Severity) dengan detail payload serangan yang terekam sempurna.

![RCE Alert](img/wazuh-alert-rce-detail.png)
![RCE Timeline](img/security-events-timeline(rce).png)

---

## 🔑 Skenario 2: SSH Brute Force Detection
Mendeteksi upaya login paksa secara masif menggunakan alat **Hydra**.

* **Attack Activity**: Penyerang melakukan ribuan percobaan login ke user `envy` dalam waktu singkat.
* **Detection**: Terjadi lonjakan (*spike*) alert pada dashboard yang dipicu oleh kegagalan otentikasi berulang.
* **Technical Detail**: Log menunjukkan kegagalan pada modul PAM dan percobaan login menggunakan user yang tidak terdaftar.

![SSH Brute Force Spike](img/wazuh-alert-ssh-timeline.png)
![SSH Auth Failure Detail](img/ssh-pam-auth-failure.png)

---

## 🔍 Skenario 3: File Integrity Monitoring (FIM)
Memantau perubahan atau penambahan file pada direktori web server secara *real-time*.

* **Configuration**: Mengaktifkan fitur `syscheck` dengan mode `realtime="yes"` pada direktori `/var/www/html/`.
* **Activity**: Simulasi pembuatan file *backdoor* `test-fim.txt` oleh penyerang.
* **Detection Result**: Wazuh secara instan mendeteksi event **"File added to the system" (Rule 554)** lengkap dengan detail file yang dibuat.

![FIM Alert](img/wazuh-fim-alert-added.png)

---

## 🛠️ Konfigurasi Teknis
Bukti konfigurasi manual yang dilakukan pada sisi Manager dan Agent:
1. **Custom Detection Logic**: `wazuh-custom-rule-config.png`
2. **Real-time FIM Config**: `wazuh-agent-fim-config.png`

---
**Created by**: Muhamad Yusril Malakaini
**Year**: 2026
