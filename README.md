# Linux Server Bot

Bot untuk mengubah sistem Linux menjadi server yang dapat dikontrol secara remote dengan GUI.

## Fitur

- SSH remote access dengan keamanan tinggi
- VNC untuk GUI remote
- Antarmuka web untuk kontrol
- Keamanan terintegrasi (Firewall, Fail2ban)
- Backup otomatis harian
- Update otomatis
- Dukungan multiple display
- SSL/TLS support (Opsional)

## Persyaratan Sistem

- Linux (Ubuntu/Debian)
- Python 3.7+
- Akses root/sudo
- Koneksi internet

## Instalasi Otomatis

1. Clone repositori ini:
```bash
git clone https://github.com/yourusername/linux-server-bot.git
cd linux-server-bot
```

2. Jalankan script setup sebagai root:
```bash
sudo ./scripts/setup.sh
```

Script akan secara otomatis:
- Menginstal semua dependensi yang diperlukan
- Mengkonfigurasi SSH dengan keamanan tinggi
- Mengatur firewall (UFW)
- Mengkonfigurasi Fail2ban
- Membuat virtual environment Python
- Menginstal dependensi Python
- Mengkonfigurasi VNC server
- Membuat service systemd
- Mengatur backup otomatis
- Membuat script update otomatis

## Konfigurasi

Setelah instalasi, konfigurasi file `config/config.yaml`:
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

## Penggunaan

1. Bot akan berjalan otomatis sebagai service systemd
2. Akses antarmuka web di: `http://localhost:5000`
3. Untuk mengontrol server:
   - Start/Stop server melalui antarmuka web
   - Monitor status koneksi
   - Akses VNC viewer

## Fitur Keamanan

- SSH dengan autentikasi key
- Firewall dengan UFW
- Fail2ban untuk proteksi brute force
- Backup otomatis harian
- Update otomatis
- Enkripsi SSL/TLS (opsional)

## Maintenance

- Backup otomatis berjalan setiap hari jam 00:00
- Untuk update manual: `./scripts/update.sh`
- Logs tersimpan di direktori `logs/`
- Backup tersimpan di direktori `backups/`

## Troubleshooting

1. Jika service gagal start:
```bash
sudo systemctl status linux-server-bot
sudo journalctl -u linux-server-bot
```

2. Jika VNC tidak berfungsi:
```bash
vncserver -kill :1
vncserver :1
```

3. Untuk melihat logs:
```bash
tail -f logs/server.log
```

## Lisensi

MIT License 