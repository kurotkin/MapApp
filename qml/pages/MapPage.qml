import QtQuick 2.0
import Sailfish.Silica 1.0

import QtPositioning 5.3
import QtLocation 5.0
import "../assets"

Page {
    PositionSource {
        id: positionSource
        updateInterval: 1000
    }

    Plugin {
        id: mapPlugin
        name: "webtiles"
        allowExperimental: false
        PluginParameter { name: "webtiles.scheme"; value: "https" }
        PluginParameter { name: "webtiles.host"; value: "a.tile.openstreetmap.fr" }
        PluginParameter { name: "webtiles.path"; value: "/hot/${z}/${x}/${y}.png" }
    }

    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        gesture.enabled: true
        zoomLevel: zoomSlider.value

        // ToDo: add binding of the map center to the position coordinate
        Binding {
            target: map
            property: "center"
            value: positionSource.position.coordinate
            when: positionSource.position.coordinate.isValid
        }

        // ToDo: create MouseArea to handle clicks and holds
        MouseArea {
            anchors.fill: map
            onClicked: {
                appendCircle(map.toCoordinate(Qt.point(mouseX, mouseY)))
            }
        }

        Component.onCompleted: center = QtPositioning.coordinate(55.751244, 37.618423)
    }

    // ToDo: add a slider to control zoom level

    Slider {
        id: zoomSlider
        color: palette.errorColor
        anchors {
            left: parent.left;
            right: parent.right
            bottom: parent.bottom
            bottomMargin: Theme.paddingLarge
        }
        minimumValue:  map.minimumZoomLevel
        maximumValue: map.maximumZoomLevel
        value: 11
    }

    // ToDo: add a component corresponding to MapQuickCircle
    // ToDo: add item at the current position

    function appendCircle(curCoordnate){
        var circl = Qt.createQmlObject("import QtLocation 5.0; MapCircle {}", map)
        circl.center = curCoordnate
        circl.radius = 48 * Theme.pixelRatio
        circl.color = 'red'
        circl.border.width = 1
        map.addMapItem(circl)
    }

    FootPrints {
        id: foots
        diameter: Math.min(map.width, map.height) / 8
        coordinate: positionSource.position.coordinate
    }

    Component.onCompleted: { map.addMapItem(foots) }
}
