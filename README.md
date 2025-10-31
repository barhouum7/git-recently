# git-recently 🧠

### 🧠 Instantly see your latest unstaged or untracked Git changes — right from the terminal.

A lightweight and lightning-fast CLI tool to instantly list your most recently modified (**unstaged** or **untracked**) files in any Git repository — without extra setup or dependencies.

![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)
![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20macOS%20%7C%20WSL%20%7C%20Git%20Bash-blue)
![Built With](https://img.shields.io/badge/built%20with-Bash-yellow)
![Version](https://img.shields.io/badge/version-1.0.0-blue)

## ✅ Requirements
- [Git](https://git-scm.com/)
- Bash-compatible shell  
  *(Linux, macOS, WSL, or Git Bash on Windows)*

## 🚀 Installation
Run the following command to install `git-recently`:
```bash
curl -fsSL https://raw.githubusercontent.com/barhouum7/git-recently/master/install.sh | bash
```

## 🔄 Update to latest
Simply re-run the same install command:
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

## 🧱 How It Works

`git-recently` does the following under the hood:
1. Detects **unstaged** and **untracked** files.
2. Fetches their **modification timestamps**.
3. Sorts everything **newest first**.
4. Displays results in a clean, **colorized** format.

Cross-platform compatible — works seamlessly on Linux, macOS, WSL, and Git Bash.

## 💡 Uninstall
```bash
curl -fsSL https://raw.githubusercontent.com/barhouum7/git-recently/master/uninstall.sh | bash

# Or simply run:
bash uninstall.sh
```

## 📸 Demo
<a href="https://youtu.be/QZynN_iFDIY"><img src="https://github.com/barhouum7/git-recently/blob/master/Git-Recently_Demo.gif?raw=true" alt="Watch the demo" width="700" height="370"></a>


## 🧠 Built With
- Bash
- Git
- `stat` (Linux/macOS)

## 🗺️ Roadmap

- Add PowerShell installer (Windows native)

- Port to Node.js for npx git-recently

- Add unit tests and CI workflow

- Add output customization (JSON / plain text)

## ⚖️ License

MIT 📜 Created with ❤️ by [@barhouum7 ↗](https://github.com/barhouum7)