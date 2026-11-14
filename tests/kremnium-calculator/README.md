# kremnium-calculator (M1 test example)

Example launcher to load the **real Jolla Calculator Silica QML** from a Sailfish device using Kremnium's `Sailfish.Silica` compatibility layer.

## What this does
- `calculator/` contains a copy of the real Jolla Calculator QML (`calculator.qml`, `pages/*.qml`, `cover/*.qml`) from `/usr/share/jolla-calculator/` on device.
- `main.qml` loads `calculator/calculator.qml` at runtime.
- Provides a minimal `Sailfish.Calculator` **stub** (`Sailfish/Calculator/`) so the real QML can be instantiated without the proprietary Qt5 calculator plugin. The stub is not functionally complete; it is intended for UI/compatibility loading tests.

## Prerequisites
- Kremnium built/installed for the target (Qt6/Nemo environment) so `import Sailfish.Silica 1.0` resolves to Kremnium.
- Bundled real calculator QML in `calculator/` (copied from device `/usr/share/jolla-calculator/`).
- A Qt6 QML runtime (e.g. `qml6`, `qml`, or `sailfish-qml` equivalent for Qt6) on the target.

## Run (Qt6 QML runtime)
1. Ensure Kremnium's `Sailfish.Silica` module is installed/available in the QML import path, and this directory is in the import path (for the `Sailfish.Calculator` stub).
2. Run with `qml6` or the provided loader:

```sh
# adjust paths to where Kremnium is installed
export QML_IMPORT_PATH=/usr/lib/qt6/qml:$(pwd)
qml6 ./main.qml
# or, if built:
./kremnium-calculator
```

`main.qml` loads the bundled copy in `calculator/` by default.

## C++ loader (reference: `qtquickcontrols-nemo/examples/sizeview/main.cpp`)
- `main.cpp` — Qt6 `QGuiApplication` + `QQmlApplicationEngine` loader; adds its directory to the QML import path and loads `main.qml` (fallback: `calculator/calculator.qml`).
- `CMakeLists.txt` — builds the `kremnium-calculator` executable.

```sh
mkdir -p build && cd build
cmake ..
make
```

## Notes
- This exercises Kremnium against real Silica QML (Tier 1 corpus app). Expect missing/incomplete components and API gaps; use runtime/QML errors to drive M1 fixes (see `docs/app-corpus.md`, `docs/compatibility.md`, `docs/silica-api-catalog.md`).
- For meaningful results, deploy the Kremnium build under test to the device and ensure no other `Sailfish.Silica` takes precedence in the import path.
