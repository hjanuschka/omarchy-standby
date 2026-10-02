# Standby

A tiny Omarchy bar widget that puts your machine into standby (suspend-to-RAM).

Click the moon icon in the bar, confirm **Yes**, and the machine suspends:
screen off, fans spun down. Any keypress wakes it right back up -- a fast
comeback, not a full shutdown.

## Install

```bash
omarchy plugin install hjanuschka.standby
```

Or clone into your user plugins directory:

```bash
git clone https://github.com/hjanuschka/omarchy-standby \
  ~/.config/omarchy/plugins/hjanuschka.standby
```

The shell hot-reloads on save. If the widget does not appear, run
`omarchy restart shell`.

## Usage

1. Click the moon icon in the bar.
2. A Yes/No dialog appears.
3. **Yes** suspends the machine. **No** (or Escape) dismisses it.

## How it works

The bar widget opens a full-screen confirm overlay. On confirm it runs
`systemctl suspend` via the user systemd manager, so the suspend is not
cancelled when the caller's scope exits. Suspend-to-RAM keeps your session
in memory while powering down the display and fans.

## Files

- `manifest.json` - plugin manifest
- `BarWidget.qml` - the bar icon
- `Standby.qml` - the confirm overlay + suspend action
- `bin/hjanuschka-standby` - suspend helper

## License

MIT
