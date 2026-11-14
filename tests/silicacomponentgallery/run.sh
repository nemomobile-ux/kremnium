#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
KREMNIUM_BUILD="${KREMNIUM_BUILD:-$DIR/../../build-m1}"
export QML_IMPORT_PATH="$KREMNIUM_BUILD:$DIR:${QML_IMPORT_PATH}"
export QT_QPA_PLATFORM="${QT_QPA_PLATFORM:-xcb}"
exec "$KREMNIUM_BUILD/tests/silicacomponentgallery/kremnium-silicacomponentgallery" "$@"
