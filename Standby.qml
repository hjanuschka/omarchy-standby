pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.Commons
import qs.Ui

Item {
  id: root

  property bool opened: false

  readonly property string helperBin: (root.manifest && root.manifest.__sourceDir
    ? String(root.manifest.__sourceDir).replace(/\/$/, "")
    : Quickshell.env("HOME") + "/.config/omarchy/plugins/hjanuschka.standby") + "/bin/hjanuschka-standby"

  Process {
    id: suspendProc
  }

  function open(payloadJson) {
    root.opened = true
  }

  function close() {
    root.opened = false
  }

  function suspend() {
    if (suspendProc.running) return
    suspendProc.command = ["bash", root.helperBin, "suspend"]
    suspendProc.running = true
  }

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: win

      required property var modelData
      screen: modelData

      visible: root.opened
      anchors { top: true; bottom: true; left: true; right: true }
      color: "transparent"
      WlrLayershell.namespace: "hjanuschka-standby"
      WlrLayershell.layer: WlrLayer.Overlay
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
      exclusionMode: ExclusionMode.Ignore

      ConfirmDialog {
        id: confirm

        anchors.fill: parent
        opened: root.opened
        message: "Put the machine into standby?"
        cancelText: "No"
        confirmText: "Yes"

        onCanceled: root.close()
        onConfirmed: {
          root.close()
          root.suspend()
        }
      }
    }
  }
}
