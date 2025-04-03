# 🚀 H4Des-BOT

<div align="center">
  <img src="assets/images/logo.png" alt="H4Des-BOT Logo" width="200"/>
  
  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
  [![Python Version](https://img.shields.io/badge/python-3.7%2B-blue.svg)](https://www.python.org/downloads/)
  [![GitHub Stars](https://img.shields.io/github/stars/ShiroNeko1001/H4Des-BOT.svg?style=social)](https://github.com/ShiroNeko1001/H4Des-BOT/stargazers)
  [![GitHub Forks](https://img.shields.io/github/forks/ShiroNeko1001/H4Des-BOT.svg?style=social)](https://github.com/ShiroNeko1001/H4Des-BOT/network/members)
</div>

## 📝 Deskripsi

H4Des-BOT adalah solusi otomatis untuk mengubah sistem Linux menjadi server yang dapat dikontrol secara remote dengan GUI Gnome. Dengan fitur keamanan terintegrasi dan monitoring real-time, H4Des-BOT memudahkan manajemen server Linux Anda.

## ✨ Fitur Utama

<div align="center">
  <table>
    <tr>
      <td>🔒 Remote Access</td>
      <td>SSH & VNC dengan keamanan tinggi</td>
    </tr>
    <tr>
      <td>🖥️ GUI</td>
      <td>Gnome Desktop Environment</td>
    </tr>
    <tr>
      <td>🌐 Web Interface</td>
      <td>Kontrol melalui browser</td>
    </tr>
    <tr>
      <td>🔐 Security</td>
      <td>Firewall, Fail2ban, SSL/TLS</td>
    </tr>
    <tr>
      <td>💾 Backup</td>
      <td>Backup otomatis harian</td>
    </tr>
    <tr>
      <td>📊 Monitoring</td>
      <td>Monitoring sistem real-time</td>
    </tr>
  </table>
</div>

## 🚀 Quick Start

```bash
# Clone repository
git clone https://github.com/ShiroNeko1001/H4Des-BOT.git
cd H4Des-BOT

# Install dependencies
sudo ./scripts/setup.sh

# Configure VNC
vncpasswd
vncserver :1 -geometry 1920x1080
```

## 📚 Dokumentasi

- [📖 Panduan Instalasi](docs/installation/README.md)
- [💻 Panduan Penggunaan](docs/usage/README.md)
- [⚙️ Konfigurasi](docs/configuration/README.md)
- [🔧 Development](docs/development/README.md)

## 🏗️ Struktur Proyek

```
H4Des-BOT/
├── src/                    # Source code
│   ├── core/              # Core functionality
│   ├── utils/             # Utility functions
│   ├── api/               # API endpoints
│   └── web/               # Web interface
├── scripts/               # Scripts
│   ├── setup.sh          # Installation script
│   ├── update.sh         # Update script
│   └── system_status.sh  # Monitoring script
├── config/                # Configuration
│   ├── default/          # Default configs
│   └── production/       # Production configs
├── docs/                  # Documentation
│   ├── installation/     # Installation guides
│   ├── usage/            # Usage guides
│   ├── configuration/    # Configuration guides
│   └── development/      # Development guides
├── tests/                # Tests
│   ├── unit/            # Unit tests
│   └── integration/     # Integration tests
├── assets/               # Assets
│   ├── images/          # Images
│   └── icons/           # Icons
├── logs/                 # Log files
└── backups/              # Backup data
```

## 🛠️ Teknologi

- Python 3.7+
- Flask
- VNC Server
- SSH
- UFW
- Fail2ban
- Gnome Desktop

## 🤝 Kontribusi

Kami menyambut kontribusi! Silakan lihat [CONTRIBUTING.md](CONTRIBUTING.md) untuk panduan kontribusi.

1. Fork repository
2. Buat branch baru (`git checkout -b fitur-baru`)
3. Commit perubahan (`git commit -am 'Menambahkan fitur baru'`)
4. Push ke branch (`git push origin fitur-baru`)
5. Buat Pull Request

## 📝 Lisensi

Proyek ini dilisensikan di bawah [MIT License](LICENSE).

## 📞 Kontak

- Email: shironeko1001@gmail.com
- GitHub: [ShiroNeko1001](https://github.com/ShiroNeko1001)
- Issues: [GitHub Issues](https://github.com/ShiroNeko1001/H4Des-BOT/issues)

---

<div align="center">
  <sub>Dibuat dengan ❤️ oleh ShiroNeko1001</sub>
</div> 