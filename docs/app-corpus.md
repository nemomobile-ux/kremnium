# Target app corpus (M1+ validation)

Device: `defaultuser@192.168.0.64` (Sailfish OS, `aarch64`, Qt5 Silica at `/usr/lib/qt5/qml/Sailfish/Silica`).  
Purpose: representative Sailfish apps to drive and validate Kremnium Silica compatibility (API usage, navigation, UI patterns). Use this corpus to prioritize M1 work and to collect runtime/QML errors when testing on device.

## Selection

| Tier | App | Package / desktop | QML root & paths | Why selected | Silica-related imports (observed) |
|---|---|---|---|---|---|
| 1 (M1 baseline) | **Calculator** | `jolla-calculator` (`jolla-calculator.desktop`) | `/usr/share/jolla-calculator/calculator.qml`, `pages/*.qml`, `cover/CalculatorCover.qml` | Small, readable app: `ApplicationWindow`, `Page`, cover, list/model usage, buttons/panels — good first end-to-end Silica target. | `Sailfish.Silica 1.0`, `Sailfish.Calculator 1.0` |
| 2 (M1–M2) | **Clock** | `jolla-clock` (`jolla-clock.desktop`) | `/usr/share/jolla-clock/clock.qml`, `pages/*.qml` (main/editdialog/stopwatch), `common/*.qml`, `cover/*.qml` | Medium complexity: multiple views/tabs-like flows, edit dialogs/pages, timers/alarms UI, covers; exercises broader Silica surface. | `Sailfish.Silica 1.0`, `Sailfish.Silica.private 1.0`, `Sailfish.Timezone 1.0`, `Nemo.Alarms 1.0` |
| 3 (M2–M4 stretch) | **Browser** | `sailfish-browser` (`sailfish-browser.desktop`) | `/usr/share/sailfish-browser/browser.qml`, `pages/*.qml`, `cover/*.qml` (+ settings UI under `/usr/share/jolla-settings/pages/browser/browser.qml`) | Complex app: deep navigation, many pages/dialogs/settings patterns, history/bookmarks/logins/permissions UIs — exercises advanced Silica and integration patterns. | (audit per-file during pass; includes Sailfish.Silica and browser-specific modules) |

## Notes on candidates

- **FingerTerm** (`fingerterm.desktop`, `/usr/share/fingerterm/Main.qml`): QML is accessible but root is a plain `QtQuick`/`FingerTerm` `Item` (not a Silica `ApplicationWindow` pattern in the sampled entry) — less suitable as a primary Silica-compatibility target, but may be useful for specific component checks.
- **Settings / other system apps** (`jolla-settings`, `jolla-contacts`, `jolla-messages`, `jolla-camera`, etc.) are present on device and can be added to the corpus once their QML entry points and import sets are audited (some ship logic in plugins/modules).

## How to use the corpus

1. **Static audit (per app):** enumerate `import Sailfish.Silica*` and used QML types/properties/signals/attached APIs in the app’s QML tree; diff against `docs/compatibility.md`, `docs/silica-nemo-mapping.md`, and `docs/silica-api-catalog.md` to produce a required-API checklist.
2. **Runtime validation (on device):** deploy Kremnium to the device and run the app against the compatibility layer where feasible; capture QML warnings/errors and behavioral gaps (navigation, dialogs, menus, covers, input, pickers).
   - Inspect files: `ssh defaultuser@192.168.0.64 'sed -n "1,120p" /usr/share/jolla-calculator/calculator.qml'`
   - Locate package files: `ssh defaultuser@192.168.0.64 'rpm -ql <pkg> | grep "\.qml"'`
3. **Prioritization:** fix blockers in tier order (Tier 1 → 2 → 3). Track per-app required components/APIs back into the catalog/checklists.

## M1 focus (derived from Tier 1)

From `jolla-calculator` entry patterns: `ApplicationWindow` (initialPage, allowed/default orientations, cover), `Page`, `Silica` controls/lists/models/covers as used by its pages — validates core app shell, page stack/navigation basics, and common item/view primitives before expanding to dialogs/private APIs (Tier 2) and complex flows (Tier 3).
