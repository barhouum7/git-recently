# git-recently 🧠

### 🧠 Instantly see your latest unstaged or untracked Git changes — right from the terminal.

A lightweight, fast CLI tool to list your most recently modified (unstaged or untracked) Git files; automatically installed via one command.

![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)
![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20macOS%20%7C%20WSL%20%7C%20Git%20Bash-blue)
![Built With](https://img.shields.io/badge/built%20with-Bash-yellow)

## ✅ Requirements
- Git
- Bash-compatible shell (Linux, macOS, WSL, or Git Bash on Windows)

## 🚀 Installation
Run the following command to install `git-recently`:
```bash
curl -fsSL https://raw.githubusercontent.com/barhouum7/git-recently/master/install.sh | bash
```

## 🔄 Update to latest
Re-run the install command:
```bash
curl -fsSL https://raw.githubusercontent.com/barhouum7/git-recently/master/install.sh | bash
```

## 🧩 Usage
Run inside any Git repository:
```bash
git recent
```

Example output:
```bash
2025-10-30 01:23:04.123456789 +0100 src/components/Navbar.tsx
2025-10-30 01:20:57.789012345 +0100 pages/dashboard.tsx
```

## 💡 Uninstall
```bash
bash uninstall.sh
```

## 🧱 How It Works

`git-recently` does the following under the hood:
1. Detects **unstaged** and **untracked** files.
2. Gets their **modification timestamps**.
3. Sorts everything **newest first**.
4. Displays results in a clean, colorized format.

Works on Linux, macOS, WSL, and Git Bash on Windows.

## 📸 Demo
Coming soon.

## 🧠 Built With
- Bash
- Git
- `stat` (Linux/macOS)

## ⚖️ License

MIT 📜 Created with ❤️ by @barhouum7