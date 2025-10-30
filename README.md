# git-recently 🧠

A simple, fast CLI tool to view your most recently modified (unstaged or untracked) Git files — automatically installed via one command.

## 🚀 Install
```bash
curl -fsSL https://raw.githubusercontent.com/barhouum7/git-recently/master/install.sh | bash
```

## 🧩 Usage

```bash
git recent
```

Output example:

```bash
2025-10-30 01:23:04.123456789 +0100 src/components/Navbar.tsx
2025-10-30 01:20:57.789012345 +0100 pages/dashboard.tsx
```

## 💡 Uninstall
```bash
bash uninstall.sh
```

## 🧱 How It Works

- Detects unstaged + untracked files.

- Uses file modification timestamps.

- Sorts results newest-first.

- Works on Linux & macOS.


## 📸 Demo (Coming Soon)

A GIF showing `git recent` in action.


## 🧠 Built With

- Bash

- Git

- stat (Linux/macOS)

## ⚖️ License

MIT 📜 Created with ❤️ by @barhouum7