import QtQuick 2.0

import QtLocation 5.0

MapQuickItem {
    property alias diameter: image.width
    sourceItem: Image {
        id: image
        source: Qt.resolvedUrl("footprints.svg")
        width: objectSize
        height: width
        fillMode: Image.PreserveAspectFit
    }

    anchorPoint {
        x: sourceItem.width / 2
        y: sourceItem.height / 2
    }
}
