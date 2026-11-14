# Silica compatibility status
Baseline source: device `defaultuser@192.168.0.64` `/usr/lib/qt5/qml/Sailfish/Silica` (Qt5). Snapshotted into `docs/device-silica/`.

## Base / dependencies
- **Primary base:** NemoMobile components in `~/work/nemomobile/qtquickcontrols-nemo/` (`Nemo`, `Nemo.Controls`): e.g. `Theme`/`NemoTheme`, `NemoWindow`, `NemoPage`, and Nemo control implementations. Kremnium currently builds on these (e.g. `KremniumTheme` wraps Nemo `Theme`, `ApplicationWindow` uses `KremniumWindow`, `Page` extends `NemoPage`).
- **Strategy:** map Silica APIs/behavior onto Nemo primitives where possible; implement Silica-specific types, properties, signals, attached objects, and interactions in Kremnium where Nemo does not provide parity. Track Nemo gaps that block Silica compatibility.
- **Mapping:** see `docs/silica-nemo-mapping.md` for Nemo API inventory and per-component/type Silica→Nemo mapping (Map / Extend / Implement / Gap).
- **API catalog:** see `docs/silica-api-catalog.md` (parsed from `docs/device-silica/plugins.qmltypes`) for per-component properties, signals, methods, enums, and initial mapping/status checklists.
- **App corpus:** see `docs/app-corpus.md` for target Sailfish apps on device used to drive/prioritize M1+ validation.

## Summary
- Device qmldir types/singletons: **86**
- Kremnium qmldir types: **25**
- Present (name match): **22**
- Missing in Kremnium: **64**
- Extra/different in Kremnium: **3**

## Present (name match, implementation may be partial)
- [ ] `ApplicationWindow`
- [ ] `BusyIndicator`
- [ ] `Button`
- [ ] `ContextMenu`
- [ ] `CoverBackground`
- [ ] `DockedPanel`
- [ ] `IconButton`
- [ ] `Label`
- [ ] `ListItem`
- [ ] `MenuItem`
- [ ] `Page`
- [ ] `PageHeader`
- [ ] `ProgressBar`
- [ ] `PullDownMenu`
- [ ] `RemorseItem`
- [ ] `RemorsePopup`
- [ ] `SectionHeader`
- [ ] `SilicaFlickable`
- [ ] `SilicaListView`
- [ ] `Slider`
- [ ] `VerticalScrollDecorator`
- [ ] `ViewPlaceholder`

## Missing in Kremnium
- [ ] `AddAnimation`
- [ ] `BackgroundItem`
- [ ] `BusyLabel`
- [ ] `ColorPicker`
- [ ] `ColorPickerDialog`
- [ ] `ColorPickerPage`
- [ ] `ColumnView`
- [ ] `ComboBox`
- [ ] `CoverPlaceholder`
- [ ] `DatePicker`
- [ ] `DatePickerDialog`
- [ ] `DetailItem`
- [ ] `Dialog`
- [ ] `DialogHeader`
- [ ] `Drawer`
- [ ] `ExpandingSection`
- [ ] `ExpandingSectionGroup`
- [ ] `FadeAnimation`
- [ ] `FadeAnimator`
- [ ] `FirstTimeUseCounter`
- [ ] `FullscreenContentPage`
- [ ] `GridItem`
- [ ] `HighlightBar`
- [ ] `HighlightImage`
- [ ] `HorizontalScrollDecorator`
- [ ] `Icon`
- [ ] `IconComboBox`
- [ ] `IconMenuItem`
- [ ] `IconTextSwitch`
- [ ] `InfoLabel`
- [ ] `InteractionHintLabel`
- [ ] `Keypad`
- [ ] `LinkedLabel`
- [ ] `MenuLabel`
- [ ] `MiniComboBox`
- [ ] `NestedGridView`
- [ ] `OpacityRampEffect`
- [ ] `OpacityRampEffectBase`
- [ ] `PageBusyIndicator`
- [ ] `PageStack`
- [ ] `PanelBackground`
- [ ] `PasswordField`
- [ ] `ProgressCircle`
- [ ] `ProgressCircleBase`
- [ ] `PulleyAnimationHint`
- [ ] `PushUpMenu`
- [ ] `Remorse`
- [ ] `RemoveAnimation`
- [ ] `ScrollDecorator`
- [ ] `SearchField`
- [ ] `SecondaryButton`
- [ ] `Separator`
- [ ] `SilicaGridView`
- [ ] `SlideshowView`
- [ ] `Switch`
- [ ] `TapInteractionHint`
- [ ] `TextArea`
- [ ] `TextEditorLabel`
- [ ] `TextField`
- [ ] `TextSwitch`
- [ ] `TimePicker`
- [ ] `TimePickerDialog`
- [ ] `TouchInteractionHint`
- [ ] `ValueButton`

## Extra / naming differences
- [ ] `CoverAction` (review vs device API)
- [ ] `CoverActionList` (review vs device API)
- [ ] `CoverPage` (review vs device API)

## C++/runtime API gaps (initial)
- [ ] Register/implement C++ types from `docs/device-silica/plugins.qmltypes` (2095 lines) with signature parity.
- [ ] `Theme` singleton/object parity (values, roles, signals, icon/font resolution) — `core/kremniumtheme.*`.
- [ ] `DeclarativeWindow` / `ApplicationWindow` Silica window & cover API parity — `core/declarativewindow.*`, `core/qml/ApplicationWindow.qml`.
- [ ] `PageStack` API and navigation semantics (currently StackView-based shim).
- [ ] `Page` lifecycle/orientation/attached behavior parity.
- [ ] `Dialog`/`DialogHeader` accept/reject flow and page-stack integration.
- [ ] `PullDownMenu`/`PushUpMenu`/interaction hints behavior parity.
- [ ] `Remorse` singleton API parity (device has singleton; Kremnium has popup/item components).
- [ ] `Sailfish.Silica.private` / JS helpers (`CoverLoader.js`, `PageStack.js`, etc.) as required.
- [ ] `Sailfish.WebView` API parity (`webview/`).

## Notes
- Status is by **name presence** only; present components likely need property/signal/behavior parity work.
- Re-diff against `docs/device-silica/plugins.qmltypes` when implementing C++/attached APIs.
