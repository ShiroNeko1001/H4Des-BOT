# H4Des-BOT

Bot untuk mengubah sistem Linux menjadi server yang dapat dikontrol secara remote dengan GUI Gnome.

![H4Des-BOT Logo](assets/images/logo.png)

## 🚀 Fitur Utama

- 🔒 SSH remote access dengan keamanan tinggi
- 🖥️ VNC untuk GUI remote dengan Gnome
- 🌐 Antarmuka web untuk kontrol
- 🔐 Keamanan terintegrasi (Firewall, Fail2ban)
- 💾 Backup otomatis harian
- 🔄 Update otomatis
- 📊 Monitoring sistem real-time
- 🛡️ SSL/TLS support

## 📋 Persyaratan Sistem

- Linux (Ubuntu/Debian)
- Python 3.7+
- Akses root/sudo
- Koneksi internet
- RAM minimal 2GB
- Storage minimal 10GB

## 🛠️ Instalasi

1. Clone repositori:
```bash
git clone https://github.com/ShiroNeko1001/H4Des-BOT.git
cd H4Des-BOT
```

2. Jalankan script instalasi:
```bash
sudo ./scripts/setup.sh
```

3. Konfigurasi awal:
```bash
# Buat password VNC
vncpasswd

# Mulai VNC server
vncserver :1 -geometry 1920x1080
```

## ⚙️ Konfigurasi

Edit file `config/config.yaml`:
```yaml
server:
  host: 0.0.0.0
  port: 5000

ssh:
  username: your_username
  password: your_password

vnc:
  password: your_vnc_password
```

## 💻 Penggunaan

1. Akses Web Interface:
   - Buka: `http://localhost:5000`
   - Atau: `http://[IP_SERVER]:5000`

2. Akses VNC:
   - Host: `[IP_SERVER]:1`
   - Password: (password VNC yang dibuat)

3. Monitoring Sistem:
```bash
./scripts/system_status.sh
```

## 🔒 Keamanan

- SSH dengan autentikasi key
- Firewall dengan UFW
- Fail2ban untuk proteksi brute force
- Backup otomatis harian
- Update otomatis
- Enkripsi SSL/TLS

## 📦 Struktur Proyek

```
H4Des-BOT/
├── src/                    # Source code utama
├── scripts/               # Script instalasi dan maintenance
├── config/                # File konfigurasi
├── docs/                  # Dokumentasi
├── assets/               # Gambar dan icon
├── tests/                # Unit test
├── logs/                 # Log file
└── backups/              # Backup data
```

## 🔄 Maintenance

1. Update sistem:
```bash
./scripts/update.sh
```

2. Backup manual:
```bash
./scripts/backup.sh
```

3. Monitoring:
```bash
./scripts/system_status.sh
```

## 🐛 Troubleshooting

1. Service gagal start:
```bash
sudo systemctl status linux-server-bot
sudo journalctl -u linux-server-bot
```

2. VNC bermasalah:
```bash
vncserver -kill :1
vncserver :1
```

3. Lihat logs:
```bash
tail -f logs/server.log
```

## 🤝 Kontribusi

1. Fork repository
2. Buat branch baru (`git checkout -b fitur-baru`)
3. Commit perubahan (`git commit -am 'Menambahkan fitur baru'`)
4. Push ke branch (`git push origin fitur-baru`)
5. Buat Pull Request

## 📝 Lisensi

MIT License

## 📞 Kontak

- Email: shironeko1001@gmail.com
- GitHub: [ShiroNeko1001](https://github.com/ShiroNeko1001)

---

<div align="center">
  <sub>Dibuat dengan ❤️ oleh ShiroNeko1001</sub>
</div> 