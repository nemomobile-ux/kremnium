import QtQuick 2.0

// Compatibility implementation of Sailfish.Calculator Calculation for loading/running
// the unmodified Jolla Calculator QML with Kremnium (Qt6). Not a full port of the
// native Sailfish plugin, but provides the API/behavior the app expects.

ListModel {
    id: root

    property int currentIndex: 0

    // enums/constants (dynamic for Qt6 uppercase compatibility)
    readonly property int _init: {
        root.Field = 0
        root.Function = 1
        root.Operation = 2

        // constants
        root.Pi = "π"
        root.E = "e"

        // operations/symbols
        root.Add = "add"
        root.Subtract = "sub"
        root.Multiply = "mul"
        root.Divide = "div"
        root.Power = "pow"
        root.OpenBracket = "("
        root.CloseBracket = ")"

        // functions
        root.Sine = "sin"
        root.Cosine = "cos"
        root.Tangent = "tan"
        root.Logarithm = "ln"
        root.LogarithmBase10 = "log"
        root.Factorial = "fact"
        root.SquareRoot = "sqrt"
        return 1
    }

    signal completed()
    signal operationMadeToEmptyCalculation()

    property QtObject result: QtObject {
        property bool valid: false
        property string valueText: "0"
        property string linkText: ""
    }

    function _ensureField() {
        if (root.count === 0 || root.get(root.count - 1).type !== root.Field) {
            root.append({"type": root.Field, "text": "", "field": {"linkText": "", "fraction": false, "numerator": "", "denominator": ""}})
            root.currentIndex = root.count - 1
        }
        return root.count - 1
    }

    function _currentFieldIndex() {
        if (root.currentIndex >= 0 && root.currentIndex < root.count && root.get(root.currentIndex).type === root.Field)
            return root.currentIndex
        return _ensureField()
    }

    function _setFieldText(idx, text) {
        var item = root.get(idx)
        if (!item) return
        var f = item.field
        root.set(idx, {"type": root.Field, "text": text, "field": {"linkText": f ? f.linkText : "", "fraction": false, "numerator": text, "denominator": ""}})
    }

    property QtObject focusField: QtObject {
        function link(r) {
            // link a previous result into current field
            if (r && r.valueText !== undefined) {
                insert(r.valueText)
                if (r.linkText !== undefined)
                    root.result.linkText = r.linkText
            }
        }
    }

    function insert(t) {
        var s = (t === undefined || t === null) ? "" : String(t)
        var idx = _currentFieldIndex()
        var item = root.get(idx)
        var cur = item && item.text ? item.text : ""
        _setFieldText(idx, cur + s)
        root.currentIndex = idx
        result.valid = false
    }

    function _appendOp(symbol, name) {
        // ensure there's something to operate on; if empty, signal
        if (root.count === 0) {
            operationMadeToEmptyCalculation()
            _ensureField()
        } else {
            var last = root.get(root.count - 1)
            if (last.type === root.Operation) {
                root.set(root.count - 1, {"type": root.Operation, "text": symbol})
                root.currentIndex = root.count - 1
                result.valid = false
                return
            }
            if (last.type === root.Field && (!last.text || last.text === "")) {
                // keep empty field
            }
        }
        root.append({"type": root.Operation, "text": symbol})
        root.append({"type": root.Field, "text": "", "field": {"linkText": "", "fraction": false, "numerator": "", "denominator": ""}})
        root.currentIndex = root.count - 1
        result.valid = false
    }

    function add() { _appendOp("+", "add") }
    function subtract() { _appendOp("−", "sub") }
    function multiply() { _appendOp("×", "mul") }
    function divide() { _appendOp("÷", "div") }

    function openBracket() { insert("(") }
    function closeBracket() { insert(")") }
    function changeSign() {
        var idx = _currentFieldIndex()
        var item = root.get(idx)
        var cur = item && item.text ? item.text : ""
        if (cur.indexOf("-") === 0) cur = cur.slice(1)
        else if (cur.length > 0) cur = "-" + cur
        _setFieldText(idx, cur)
    }
    function setConstant(c) {
        if (c === root.Pi) insert("π")
        else if (c === root.E) insert("e")
        else insert(String(c))
    }
    function factorial() { insert("!") }
    function power() { _appendOp("^", "pow") }
    function sine() { insert("sin(") }
    function cosine() { insert("cos(") }
    function tangent() { insert("tan(") }
    function logarithm() { insert("ln(") }
    function logarithmBase10() { insert("log(") }
    function squareRoot() { insert("√(") }
    function paste() { /* no clipboard integration in stub */ }
    function backspace() {
        if (root.count === 0) return
        var idx = root.currentIndex >= 0 ? root.currentIndex : root.count - 1
        var item = root.get(idx)
        if (!item) return
        if (item.type === root.Field) {
            var cur = item.text || ""
            if (cur.length > 0) {
                _setFieldText(idx, cur.slice(0, -1))
            } else if (root.count > 1) {
                root.remove(idx)
                root.currentIndex = Math.max(0, idx - 1)
            }
        } else {
            root.remove(idx)
            root.currentIndex = Math.max(0, idx - 1)
        }
        result.valid = false
    }

    function _buildExpression() {
        var expr = ""
        for (var i = 0; i < root.count; i++) {
            var it = root.get(i)
            if (!it) continue
            var t = it.text || ""
            t = t.replace(/×/g, "*").replace(/÷/g, "/").replace(/−/g, "-").replace(/π/g, "Math.PI").replace(/\be\b/g, "Math.E")
            t = t.replace(/√\(/g, "Math.sqrt(").replace(/sin\(/g, "Math.sin(").replace(/cos\(/g, "Math.cos(")
            t = t.replace(/tan\(/g, "Math.tan(").replace(/ln\(/g, "Math.log(").replace(/log\(/g, "Math.log10(")
            expr += t
        }
        return expr
    }

    function calculate() {
        var expr = _buildExpression()
        var value = 0
        try {
            // basic eval for simple expressions
            value = eval(expr) // eslint-disable-line no-eval
        } catch (e) {
            result.valid = false
            result.valueText = "nan"
            return
        }
        if (value === undefined || value === null || isNaN(value)) {
            result.valid = false
            result.valueText = "nan"
        } else {
            result.valid = true
            result.valueText = String(value)
        }
        completed()
    }

    function functionText(name) {
        if (name === root.Sine) return "sin"
        if (name === root.Cosine) return "cos"
        if (name === root.Tangent) return "tan"
        if (name === root.Logarithm) return "ln"
        if (name === root.LogarithmBase10) return "log"
        if (name === root.Factorial) return "x!"
        if (name === root.SquareRoot) return "√"
        return name ? String(name) : ""
    }
    function constantText(name) {
        if (name === root.Pi) return "π"
        if (name === root.E) return "e"
        return name ? String(name) : ""
    }
    function symbolText(name) {
        if (name === root.Divide) return "÷"
        if (name === root.Multiply) return "×"
        if (name === root.Subtract) return "−"
        if (name === root.Add) return "+"
        if (name === root.Power) return "^"
        if (name === root.OpenBracket) return "("
        if (name === root.CloseBracket) return ")"
        return name ? String(name) : ""
    }
}
