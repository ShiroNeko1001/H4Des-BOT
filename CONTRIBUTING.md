# Panduan Kontribusi

Terima kasih telah tertarik untuk berkontribusi pada H4Des-BOT! Berikut adalah panduan untuk membantu Anda memulai.

## 🚀 Memulai

1. Fork repository
2. Clone repository Anda:
```bash
git clone https://github.com/your-username/H4Des-BOT.git
cd H4Des-BOT
```

3. Buat branch baru:
```bash
git checkout -b fitur-baru
```

## 📝 Panduan Kontribusi

### 1. Kode

- Gunakan Python 3.7+
- Ikuti PEP 8 style guide
- Tambahkan komentar yang jelas
- Tulis unit test untuk kode baru

### 2. Dokumentasi

- Update README.md jika diperlukan
- Tambahkan dokumentasi untuk fitur baru
- Gunakan format Markdown yang konsisten

### 3. Commit Messages

Format commit message:
```
type(scope): description

[optional body]
[optional footer]
```

Contoh:
```
feat(api): add user authentication endpoint

- Add POST /auth endpoint
- Add JWT token generation
- Add user validation
```

### 4. Pull Requests

1. Pastikan branch Anda up-to-date
2. Jalankan test sebelum membuat PR
3. Isi template PR dengan lengkap
4. Tunggu review dari maintainer

## 🧪 Testing

1. Install dependensi test:
```bash
pip install -r requirements-dev.txt
```

2. Jalankan test:
```bash
pytest tests/
```

## 📚 Dokumentasi

- [Style Guide](docs/development/style-guide.md)
- [API Documentation](docs/development/api.md)
- [Testing Guide](docs/development/testing.md)

## 🤝 Code of Conduct

Harap baca dan ikuti [Code of Conduct](CODE_OF_CONDUCT.md).

## 📞 Kontak

Jika Anda memiliki pertanyaan:
- Email: shironeko1001@gmail.com
- Issues: [GitHub Issues](https://github.com/ShiroNeko1001/H4Des-BOT/issues)

Terima kasih atas kontribusi Anda! 🎉 