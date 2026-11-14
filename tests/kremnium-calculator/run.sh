#!/bin/sh
# Run the kremnium-calculator example (loads real /usr/share/jolla-calculator/calculator.qml).
# Requires a Qt6 QML runtime and Kremnium's Sailfish.Silica module in the QML import path.

set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
CALC_QML="${CALC_QML:-$DIR/calculator/calculator.qml}"
KREMNIUM_QML="${KREMNIUM_QML:-}"

IMPORT_PATH="$DIR"
if [ -n "$KREMNIUM_QML" ]; then
    IMPORT_PATH="$KREMNIUM_QML:$IMPORT_PATH"
fi

export QML_IMPORT_PATH="$IMPORT_PATH${QML_IMPORT_PATH:+:$QML_IMPORT_PATH}"
export QML2_IMPORT_PATH="$QML_IMPORT_PATH"

RUNTIME="${QML_RUNTIME:-qml6}"
echo "Using runtime: $RUNTIME"
echo "QML_IMPORT_PATH=$QML_IMPORT_PATH"
echo "Calculator QML: $CALC_QML"
exec "$RUNTIME" "$DIR/main.qml"
