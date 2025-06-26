<p align="center">
  <img src="https://img.shields.io/badge/File--Integrity--Checker-BASH-green?style=for-the-badge" />
</p>

<h2 align="center">🔒 File System Integrity Checker</h2>

## 📌 Description

This BASH script helps you:
- ✅ Create a **baseline** of directory file hashes
- ✅ Detect **file changes**, additions, or deletions
- ✅ Generate **reports** showing detected differences

## 📂 Folder Structure

- `baselines/` → Stores saved baselines
- `reports/` → Stores integrity check reports
- `integrity_checker.sh` → Main script

## 🚀 How to Use

### ✅ 1. Make script executable
```bash
chmod +x integrity_checker.sh
```

### ✅ 2. Run the script
```bash
./integrity_checker.sh
```

Choose:
- Option 1 to create a baseline of a folder
- Option 2 to check the folder’s integrity against a saved baseline

## 📄 Sample Report

See `reports/sample_report.txt` for an example of detected changes.

## 🛠 Requirements

- Bash shell
- `sha256sum`, `diff`, `find`

## 📅 Created: November 2024
