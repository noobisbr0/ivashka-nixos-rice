# ❄️ NixOS Configuration Flake

Модульная и декларативная конфигурация рабочей станции **NixOS** на базе **Flakes** и **Home Manager**. Рабочее окружение построено вокруг легковесного и плавного тайлингового композитора **Hyprland** с кастомной фиолетовой эстетикой (*Dark Purple*), строгим управлением энергопотреблением на ноутбуке и шифрованием секретов через `ragenix`.

---

## 🚀 Основные особенности

* **Оконный менеджер**: Hyprland с современной конфигурацией через **Lua API** (`hyprland.lua`), автоблокировкой (`hypridle`, `hyprlock`), обоями (`hyprpaper`) и меню выключения (`wleave`).
* **Панель и статус**: **Waybar** в кастомном фиолетовом стиле (`#d8b4fe`, `#2d1e3e`) с виджетами батареи, сетевого трафика, нагрузки процессора, MPD и медиаплеера.
* **Лаунчер и интерфейс**: `hyprlauncher` с темами иконок Papirus-Dark и оформления `adw-gtk3-dark`, уведомлениями через `mako` и курсором `Bibata-Modern-Classic`.
* **Терминал и оболочка**: **Kitty** (с эффектом блюра и прозрачностью) + **Zsh** с Oh My Zsh, подсветкой синтаксиса, автодополнением и темой `Powerlevel10k`.
* **Управление питанием**: Глубокая оптимизация батареи через **TLP** (отключение Turbo Boost при работе от АКБ, энергосбережение PCIe ASPM, пороги зарядки 75%–95%).
* **Безопасность и секреты**: Шифрование персональных токенов с помощью **ragenix** (`github-token.age`).
* **Обход блокировок и сеть**:
  * Интеграция службы **zapret-discord-youtube** (профиль `general(ALT)`).
  * DNS-over-TLS через `systemd-resolved` со встроенным bash-алиасом быстрого переключения DNS (`dns-toggle`).
* **Вход в систему**: `greetd` с компактным TUI-интерфейсом `tuigreet` и автологином в Hyprland.
* **Звук**: PipeWire с поддержкой ALSA, 32-bit ALSA и PulseAudio через `rtkit`.

---

## 📂 Структура репозитория

```text
├── configuration.nix         # Базовый системный файл конфигурации (настройки ядра Nix, unfree, версии)
├── flake.nix                 # Описание inputs (nixpkgs, home-manager, zapret, ragenix) и outputs
├── flake.lock                # Зафиксированные версии зависимостей
├── hardware-configuration.nix# Аппаратная спецификация (AMD CPU, NVMe, файловые системы)
├── modules/
│   ├── audio.nix             # Настройка PipeWire и звукового стека
│   ├── battery.nix           # Оптимизация TLP и профили энергопотребления
│   ├── boot.nix              # systemd-boot, ROCm/OpenCL и драйверы Bluetooth
│   ├── desktop.nix           # Системная часть Hyprland, greetd и XDG Desktop Portals
│   ├── fonts.nix             # Подборка шрифтов (JetBrainsMono, Fira Code, CaskaydiaCove, Noto Emoji)
│   ├── home.nix              # Главная точка входа Home Manager (Zsh, Git, переменные окружения)
│   ├── networking.nix        # Сеть, NetworkManager, DoT, фаервол и SSH
│   ├── packages.nix          # Системные пакеты (CLI, GUI, C++/Qt дев-стек, медиа, утилиты)
│   ├── secrets.nix           # Подключение и расшифровка ragenix секретов
│   ├── shell.nix             # Конфигурация системного шелла, GnuPG-агента и GPU-Screen-Recorder
│   ├── users.nix             # Пользовательская учетная запись, локали (en_US / ru_RU), таймзона
│   ├── zapret.nix            # Настройки zapret-discord-youtube
│   └── home/
│       ├── desktop.nix       # hyprland.lua, hyprlock.conf, hypridle.conf, hyprpaper.conf, wleave
│       ├── launcher.nix      # hyprlauncher, GTK-темы, dconf
│       ├── terminal.nix      # Конфигурации Kitty, Mako и Fastfetch
│       └── waybar.nix        # Стили (CSS) и раскладка модулей (JSONC) для Waybar
└── secrets/
    ├── github-token.age      # Зашифрованный токен GitHub
    └── secrets.nix           # SSH-ключи (хоста и пользователя) для доступа к ragenix
```

---

## ⌨️ Основные горячие клавиши (Hyprland)

| Сочетание клавиш | Действие |
| :--- | :--- |
| <kbd>Super</kbd> + <kbd>Return</kbd> | Запуск терминала (`kitty`) |
| <kbd>Super</kbd> + <kbd>D</kbd> | Меню приложений (`hyprlauncher`) |
| <kbd>Super</kbd> + <kbd>E</kbd> | Файловый менеджер (`thunar`) |
| <kbd>Super</kbd> + <kbd>F</kbd> | Браузер (`firefox`) |
| <kbd>Super</kbd> + <kbd>T</kbd> | Мессенджер (`Telegram`) |
| <kbd>Super</kbd> + <kbd>B</kbd> | История буфера обмена (`cliphist` + `rofi`) |
| <kbd>Super</kbd> + <kbd>Q</kbd> | Закрыть активное окно |
| <kbd>Super</kbd> + <kbd>V</kbd> | Переключить плавающий режим (Floating) |
| <kbd>Super</kbd> + <kbd>L</kbd> | Заблокировать экран (`hyprlock`) |
| <kbd>Super</kbd> + <kbd>M</kbd> | Выход из системы / выключение |
| <kbd>Super</kbd> + <kbd>1</kbd>–<kbd>0</kbd> | Переключение на воркспейс 1–10 |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>1</kbd>–<kbd>0</kbd> | Перемещение окна на воркспейс 1–10 |
| <kbd>Print</kbd> | Полный скриншот в `~/Pictures/Screenshots/` |
| <kbd>Super</kbd> + <kbd>Print</kbd> | Выборочный скриншот в буфер (`slurp` + `grim`) |
| <kbd>Super</kbd> + <kbd>Ctrl</kbd> + <kbd>Стрелки</kbd> | Изменение размера активного окна |

---

## 🛠️ Полезные алиасы оболочки

* `rebuild` — пересобрать систему из текущего каталога:
  ```bash
  sudo nixos-rebuild switch --flake /etc/nixos#nixos
  ```
* `update` — обновить `flake.lock` и применить обновления:
  ```bash
  cd /etc/nixos && nix flake update && git add flake.lock && sudo nixos-rebuild switch --flake .#nixos
  ```
* `dns-toggle` — быстрое переключение между системным DNS роутера (DHCP) и DoT (Xbox DNS).
* `ani-cli` — просмотр аниме из терминала (`anicli-ru cli`).
* `tg-ws` — запуск изолированного Telegram WebSocket прокси.

---

## 📦 Развёртывание и установка

### 1. Клонирование репозитория

```bash
sudo git clone <URL_РЕПОЗИТОРИЯ> /etc/nixos
cd /etc/nixos
```

### 2. Настройка аппаратной конфигурации

Сгенерируйте и проверьте привязку к вашим дискам:

```bash
sudo nixos-generate-config --show-hardware-config > /etc/nixos/hardware-configuration.nix
```

### 3. Управление секретами (ragenix)

Для работы с секретами убедитесь, что ваши публичные SSH-ключи добавлены в `secrets/secrets.nix`:

```bash
# Редактирование или перешифрование секретов
ragenix -e secrets/github-token.age
```

### 4. Применение конфигурации

```bash
sudo nixos-rebuild switch --flake .#nixos
```