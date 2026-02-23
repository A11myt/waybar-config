# Waybar – Configuration

Monochrome-first. Orange accent. Minimal noise.

Diese Waybar-Konfiguration ist auf Hyprland ausgelegt und folgt einer „Nothing OS“-artigen UI-Linie:

* klare Typografie
* wenig Farbe, viel Struktur
* Icons als Informationsträger
* Custom Modules für Wetter, Media, Updates, Notifications

---

## 📍 Location

Standardpfade:

* Config: `~/.config/waybar/config.jsonc`
* Style: `~/.config/waybar/style.css`
* Scripts: `~/.config/waybar/scripts/`

---

## 🧱 Layout

Global:

* Height: `32`
* Spacing: `2`
* Layer: `top`

Module-Placement:

### Left

1. `custom/launcher`
2. `clock`
3. `custom/weather`
4. `hyprland/workspaces`

### Center

1. `custom/notification`
2. `custom/media`

### Right

1. `custom/pacman`
2. `pulseaudio`
3. `battery`
4. `network`
5. `power-profiles-daemon`

---

## 🧩 Modules & Behaviour

### `custom/launcher`

**Icon:** `󰣇`
**Click:** `rofi -show drun`

Dependencies:

* `rofi` (oder ersetzen durch `wofi`)

---

### `clock`

* Normal: `"{:%I:%M %p}"`
* Alt: `"{:%a, %d. %b}"`

---


### `hyprland/workspaces`

* Format: `{name}`
* Click: `hyprctl dispatch workspace {name}`
* Sort: by number
* Persistent: `* : 5` (min. 5 Workspaces immer sichtbar)

Dependencies:

* `hyprland` / `hyprctl`
* Waybar mit Hyprland-Modul-Support (`waybar` normal reicht)

---

### `power-profiles-daemon`

* Format: `{icon}`
* Tooltip: Profile + Driver

Icons:

* performance/balanced/power-saver

Dependencies:

* `power-profiles-daemon`

---

### `battery`

* Format: `{capacity}% {icon}`
* Icons: `    `

Dependencies:

* `upower` (in der Praxis oft notwendig)
* Laptop/Power supply natürlich vorhanden

---

### `custom/notification` (swaync)

Exec:

* `swaync-client -swb`

Click:

* Left: toggle panel `swaync-client -t -sw`
* Right: DND toggle `swaync-client -d -sw`

Dependencies:

* `swaync`
* `swaync-client`

---

### `custom/media`

Exec:

* `$HOME/.config/waybar/scripts/mediaplayer.py`

Behaviour:

* playing/paused shows: `{artist} - {title} {icon}`
* max length: 40
* click: play/pause
* right click: stop
* scroll up: next
* scroll down: previous

Dependencies:

* `python`
* `playerctl`

---

### `custom/pacman`

Exec:

* `checkupdates | wc -l`

Interval:

* `3600s` (1h)

Click:

* `~/.config/waybar/scripts/update.sh`

Dependencies:

* `pacman-contrib` (`checkupdates`)
* `bash` coreutils

---

### `pulseaudio`

* Click: `pavucontrol`
* Scroll step: 1
* Bluetooth format supported

Dependencies:

* `pipewire` + `wireplumber` (oder pulseaudio)
* `pavucontrol`

---

### `network`

Interface: `wlp4s0`

* wifi: `{essid} `
* ethernet: `{ipaddr}/{cidr} 󰊗`
* disconnected hidden

Dependencies:

* Network stack (NetworkManager oder systemd-networkd)
* Waybar network module

---

## 📦 Required Dependencies (Pacman)

Minimal sinnvoll:

```bash
sudo pacman -S waybar rofi pavucontrol playerctl brightnessctl
sudo pacman -S power-profiles-daemon
sudo pacman -S pacman-contrib jq curl
sudo pacman -S swaync
```

---

## 📜 Custom Scripts

Diese Config erwartet folgende Dateien:

* `~/.config/waybar/scripts/weather-openmeteo.sh`
* `~/.config/waybar/scripts/mediaplayer.py`
* `~/.config/waybar/scripts/update.sh`
* `~/.config/waybar/scripts/launch.sh` (wenn du Waybar per Hyprland bind restartest)

---
# ⚙️ Custom Script Requirements

Folgende Dateien müssen existieren:

* `weather-openmeteo.sh`
* `mediaplayer.py`
* `update.sh`
* `launch.sh`

Und **ausführbar** sein:

```bash
chmod +x ~/.config/waybar/scripts/weather-openmeteo.sh
chmod +x ~/.config/waybar/scripts/mediaplayer.py
chmod +x ~/.config/waybar/scripts/update.sh
chmod +x ~/.config/waybar/scripts/launch.sh
```

Ohne Executable-Flag werden die Module nicht starten.

---

# 📦 Required Dependencies

## Core

```bash
sudo pacman -S waybar
sudo pacman -S rofi
sudo pacman -S pavucontrol
sudo pacman -S playerctl
sudo pacman -S brightnessctl
sudo pacman -S power-profiles-daemon
sudo pacman -S pacman-contrib
sudo pacman -S jq curl
sudo pacman -S swaync
```

---

## Script-Specific Dependencies

### Weather Script

Benötigt:

```bash
sudo pacman -S curl jq
```

Script muss gültiges JSON liefern:

```json
{
  "text": "8°",
  "class": "rainy",
  "tooltip": "Open-Meteo code 61"
}
```

---

### Media Script (`mediaplayer.py`)

Benötigt:

```bash
sudo pacman -S playerctl
sudo pacman -S python
```

---

### Update Script (`update.sh`)

Benötigt:

```bash
sudo pacman -S pacman-contrib
```

Verwendet:

```
checkupdates
```

---

### Launch Script (`launch.sh`)

Typischer Inhalt:

```bash
#!/bin/bash
killall waybar
waybar &
```

---

# 🧩 Module Overview

## Launcher

* Icon: `󰣇`
* Click: `rofi -show drun`

---

## Weather

* Interval: 600s
* Return-Type: json
* Icons via class mapping

---

## Media

* Scroll: Next / Previous
* Click: Play/Pause
* Right Click: Stop

---

## Pacman Updates

* Interval: 3600s
* Click: runs update script
* Signal: 8 (manual refresh möglich via `pkill -SIGRTMIN+8 waybar`)

---

## Notifications

* Uses `swaync-client`
* Click toggles panel
* Right click toggles DND

