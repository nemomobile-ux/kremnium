# Silica → Nemo mapping (inventory & strategy)

Base: `~/work/nemomobile/qtquickcontrols-nemo/` (NemoMobile, QtQuickControls-Nemo).  
Target API: Sailfish Silica as snapshotted from device `defaultuser@192.168.0.64` (`docs/device-silica/qmldir`, `docs/device-silica/plugins.qmltypes`).

Legend: **Map** = can wrap/reuse Nemo directly or with thin adapter; **Extend** = build on Nemo primitive but add Silica API/behavior; **Implement** = no Nemo equivalent, implement in Kremnium; **Gap (Nemo)** = Nemo missing capability needed for parity.

## Nemo API inventory (relevant surface)

### `Nemo` core (`src/core`)
- **`Theme`** (`theme.h`, singleton/object in Nemo): scaling `mm()/dp()`, `mmScaleFactor`/`dpScaleFactor`, item sizes (`itemWidth*`, `itemHeight*`, `itemSpacing*`), font sizes/weights/path, colors (`accentColor`, `fillColor`, `fillDarkColor`, `textColor`, `backgroundColor`, `backgroundAccentColor`), `iconSizeLauncher`, `themePath`, `loadTheme()`, `themeUpdated`.
  - **Gap vs Silica `Theme`:** different naming/units and much smaller set (Silica: `itemSize*`, `padding*`, `fontSize*Base`, `highlight*`/`primary*`/`secondary*`/`overlay*`/`error*`/light-dark roles, `colorScheme`, icon dirs/sizes, cover/page metrics, opacities, flick/drag timings, backgrounds, etc.). `KremniumTheme` currently wraps/derives from Nemo `Theme` — needs full Silica property & behavior parity.

### `Nemo.Controls` (`src/controls`)
- **C++ types:** `NemoWindow` (extends `QQuickWindow`: `allowExtendedEvents`, orientation handling, `goBack()` signal, mouse/touch/key handling), `NemoPage` (extends `QQuickItem`: `allowedOrientations` only), `EditFilter`, `FilteringMouseArea`, `InverseMouseArea`, `NemoFocusSingleton`, `RingIndicator`.
  - **Gap vs Silica:** no Silica `PageStack`, no `PageStatus` lifecycle, no dialog result semantics, no cover/remorse/window-cover APIs, limited page/window contract.
- **QML components (`src/controls/qml`):** `ApplicationWindow`, `Page`, `Header`, `HeaderToolsLayout`, `HeaderToolsIndicator`, `Button`, `IconButton`, `ToolButton`, `ActionButton`, `ButtonRow`, `Label`, `TextField`, `Checkbox`, `Slider`, `ProgressBar`, `Spinner`, `ListView`, `ListViewItemWithActions`, `ScrollDecorator`, `DatePicker`, `TimePicker`, `GlacierRoller`(+Item), `NemoIcon`, `TabButton`, `ErrorStackPage`.
  - **Nature:** Glacier/Nemo-styled controls, APIs differ from Silica naming/behavior in most cases.

### `Nemo.Dialogs` (`src/dialogs/qml`)
- **QML:** `Dialog`, `CustomDialog`, `QueryDialog`, `SelectionDialog` (Nemo dialog model; not Silica `Dialog`/`DialogHeader`/page-stack-integrated accept/reject contract).

### `Nemo.Models` (`src/models`)
- **C++/QML:** `CalendarModel` (utility; not a Silica component).

## Silica component mapping (device qmldir: 86)

| Silica component/type | Nemo base (if any) | Strategy | Notes / key work |
|---|---|---|---|
| `ApplicationWindow` | `NemoWindow` (C++), `Nemo.Controls.ApplicationWindow` (concept) | **Extend** | Provide Silica `pageStack`, `initialPage`, `cover`, `allowedOrientations`/`defaultAllowedOrientations`, content/insets; replace/customize StackView-based shim for Silica semantics. |
| `Page` | `NemoPage` (C++), `Nemo.Controls.Page` | **Extend** | Add `status` (`PageStatus`), full orientation policy, header/pulley attachment, forward nav, Silica sizing/metrics; currently partial. |
| `PageStack` | — | **Implement** | Core Silica API (`push/pop/replace/clear`, depth, transitions, attached props). Critical M1. |
| `Dialog` | `Nemo.Dialogs.Dialog` (different API) | **Implement/Adapt** | Silica page-based dialog: accept/reject/canAccept, `DialogHeader`, result to caller; integrate with PageStack. Nemo dialogs not contract-compatible. |
| `DialogHeader` | — | **Implement** | Accept/cancel labels/actions tied to Dialog. |
| `PageHeader` | `Nemo.Controls.Header`/`HeaderToolsLayout` | **Extend/Implement** | Match Silica `PageHeader` API/visual/interaction (title/description/extra content) rather than Nemo header tools model. |
| `PageBusyIndicator`, `FullscreenContentPage` | — | **Implement** | Silica-specific page variants/indicators. |
| `SilicaFlickable` | Qt Quick Flickable | **Extend** | Silica properties (pull-down/push-up menus, quick scroll hooks, bounds behavior). |
| `SilicaListView` | `Nemo.Controls.ListView` / Qt Quick ListView | **Extend** | Silica API (menus attachment, quick scroll, section/header/footer behaviors, delegates patterns). |
| `SilicaGridView` | — (Qt Quick GridView) | **Implement/Extend** | Silica grid API/behaviors. |
| `SlideshowView`, `ColumnView`, `NestedGridView` | — | **Implement** | No Nemo equivalents. |
| `PullDownMenu` | — | **Implement** | Pulley menu behavior/animation/activation; attach to flickables/page. |
| `PushUpMenu` | — | **Implement** | Complement to PullDownMenu. |
| `ContextMenu` | — (conceptually separate) | **Extend/Implement** | Silica context menu semantics; current impl partial. |
| `MenuItem`, `MenuLabel` | — | **Extend/Implement** | Silica menu item API (signals, visibility, colors). |
| `RemorsePopup`, `RemorseItem` | — | **Extend/Implement** | Timed remorse interaction; present but needs API/behavior parity. |
| `Remorse` (singleton) | — | **Implement** | Device exposes singleton; provide compatible API. |
| `CoverBackground`, `CoverAction`, `CoverActionList`, `CoverPlaceholder` | — | **Implement** | Active cover API and integration with `ApplicationWindow.cover`. |
| `Label` | `Nemo.Controls.Label` | **Extend** | Map to Silica Label props (color roles, truncation mode, font/palette behavior). |
| `Button`, `IconButton` | `Nemo.Controls.Button`/`IconButton` | **Extend** | Align Silica API (preferredWidth, colors, icons, pressed states) over Nemo styling/impl. |
| `SecondaryButton`, `ValueButton` | — | **Implement** | Silica-specific button types. |
| `TextField`, `SearchField`, `PasswordField`, `TextArea` | `Nemo.Controls.TextField` (partial) | **Extend/Implement** | Silica input APIs (labels/placeholders/error/EnterKey, focus, software input panel hooks) differ significantly; TextArea/Search/Password likely mostly new. |
| `ComboBox`, `IconComboBox`, `MiniComboBox` | — | **Implement** | No Nemo equivalent. |
| `Switch`, `TextSwitch`, `IconTextSwitch` | `Nemo.Controls.Checkbox` (different) | **Implement/Adapt** | Silica switch/toggles API & UX differ from checkbox. |
| `Slider`, `ProgressBar` | `Nemo.Controls.Slider`/`ProgressBar` | **Extend** | Align value/label/animation/indeterminate APIs to Silica. |
| `BusyIndicator`, `BusyLabel`, `PageBusyIndicator` | `Nemo.Controls.Spinner` (visual analogue) | **Extend/Implement** | Match Silica sizing/running/behavior APIs. |
| `BackgroundItem`, `ListItem`, `GridItem`, `DetailItem` | — | **Implement/Extend** | Core interactive list/detail primitives; `ListItem` present but needs parity (menus, contentItem, highlight/remorse integration). |
| `SectionHeader`, `Separator`, `ViewPlaceholder` | — | **Extend/Implement** | Layout/placeholder components; present ones need API parity. |
| `Icon`, `HighlightImage`, `HighlightBar` | `NemoIcon` (partial) | **Extend/Implement** | Silica icon/source/highlight behavior and image helpers. |
| `DockedPanel`, `PanelBackground`, `Drawer`, `ExpandingSection`, `ExpandingSectionGroup` | — | **Implement** | Container/panel behaviors. |
| `DatePicker`, `DatePickerDialog`, `TimePicker`, `TimePickerDialog`, `ColorPicker`, `ColorPickerDialog`, `ColorPickerPage` | `Nemo.Controls.DatePicker`/`TimePicker` (different API/UX) | **Implement/Adapt** | Nemo pickers exist but Silica picker/dialog APIs and visuals differ; likely need Silica-specific implementations (may reuse logic). |
| `ScrollDecorator`, `VerticalScrollDecorator`, `HorizontalScrollDecorator` | `Nemo.Controls.ScrollDecorator` | **Extend** | Provide Silica decorator variants/APIs. |
| `ProgressCircle`, `ProgressCircleBase` | — | **Implement** | No Nemo equivalent. |
| `OpacityRampEffect`, `OpacityRampEffectBase` | — | **Implement** | Shader/effect helpers. |
| `AddAnimation`, `RemoveAnimation`, `FadeAnimation`, `FadeAnimator` | — | **Implement** | Transition/animation helpers. |
| `Keypad` | — | **Implement** | Numeric/keypad UI. |
| `TouchInteractionHint`, `TapInteractionHint`, `InteractionHintLabel`, `PulleyAnimationHint`, `FirstTimeUseCounter` | — | **Implement** | Onboarding/hint framework (some private helpers exist on device). |
| `InfoLabel`, `LinkedLabel`, `TextEditorLabel` | — | **Implement/Extend** | Specialized labels. |
| `CoverLoader.js`, `PageStack.js`, `private/*` | — | **Implement/Adapt as needed** | JS helpers/private QML used by Silica internals/apps. |
| `singleton Remorse` | — | **Implement** | Expose compatible singleton in module. |

## C++ / type mapping (high level)

| Silica area (plugins.qmltypes) | Nemo base | Strategy | Notes |
|---|---|---|---|
| `Theme` properties/enums/helpers | `Nemo::Theme` (`src/core/theme.h`) | **Extend/Adapt** | `KremniumTheme` must present full Silica `Theme` API; map to Nemo values where possible, compute/override where not. |
| Window (`ApplicationWindow` backend, orientation) | `NemoWindow` (`src/controls/nemowindow.h`) | **Extend** | `DeclarativeWindow` currently minimal (`QQuickItem`); likely should bridge to/align with `NemoWindow` + Silica window contract. |
| Page/allowed orientations | `NemoPage` (`src/controls/nemopage.h`) | **Extend** | Add status, stack attachment, lifecycle. |
| Page stack / navigation | — | **Implement** | No Nemo PageStack; central dependency for most apps. |
| Enums (`PageStatus`, `TruncationMode`, etc.) | — | **Implement** | Register Silica enums with matching values. |
| Input/edit filters, mouse helpers | `EditFilter`, `FilteringMouseArea`, `InverseMouseArea` | **Map/Reuse** | Useful for Silica input/interaction internals where behavior matches. |
| Focus singleton | `NemoFocusSingleton` | **Assess** | Reuse if compatible with Silica focus expectations. |
| Image/icon providers | `NemoImageProvider` | **Assess/Extend** | Support Silica icon/source resolution if needed. |

## Priority guidance (derived from mapping)

1. **M1 core (Extend Nemo + Implement missing):** `ApplicationWindow`/`NemoWindow`, `Page`/`NemoPage`+`PageStatus`, `PageStack`, `Dialog`/`DialogHeader`, `Theme` Silica parity, basic `SilicaFlickable`/`SilicaListView` attachments.
2. **M2 common UI:** `BackgroundItem`, `ListItem` parity, `Switch`/`TextSwitch`/`IconTextSwitch`, `TextField`/`TextArea`/`SearchField`, `Label`/`Icon`/decorators, `PullDownMenu`/`PushUpMenu`.
3. **M3 breadth:** grid/slideshow/drawer/expanders, combo/value buttons, pickers/dialog pickers, busy/progress variants.
4. **M4 polish/platform:** covers, `Remorse` singleton, hints/counters, effects/animations, `Sailfish.WebView`, private/JS helpers — validated against device `plugins.qmltypes`.

## Open items to resolve
- Confirm whether `DeclarativeWindow` should inherit/wrap `NemoWindow` (vs current `QQuickItem`) for correct window-level behavior on Qt6/Nemo.
- Decide adaptation vs reimplementation for Nemo pickers/dialogs given API/UX divergence from Silica.
- Extract per-property/method/signal parity tables from `docs/device-silica/plugins.qmltypes` for each **Extend/Implement** component during implementation.
