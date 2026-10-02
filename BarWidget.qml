pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import qs.Commons
import qs.Ui

BarWidget {
  id: root

  moduleName: "hjanuschka.standby"

  readonly property var host: root.bar ? root.bar.shell : null
  readonly property bool opened: host !== null && host.openPanelIds !== undefined
    && host.openPanelIds[root.moduleName] === true

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  function requestStandby() {
    if (!host || typeof host.toggle !== "function") return
    host.toggle(root.moduleName, "{}")
  }

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: "󰊚"
    active: root.opened
    tooltipText: "Standby (suspend: screen off, fans off, wake on keypress)"
    onPressed: function(b) { root.requestStandby() }
  }
}
