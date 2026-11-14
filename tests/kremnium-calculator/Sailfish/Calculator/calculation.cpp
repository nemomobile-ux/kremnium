#include "calculation.h"
#include <QJSValue>
#include <QJSEngine>
#include <QtMath>
#include <QGuiApplication>
#include <QClipboard>
#include <cmath>

class CalcResult : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool valid READ valid NOTIFY changed)
    Q_PROPERTY(QString valueText READ valueText NOTIFY changed)
    Q_PROPERTY(QString linkText READ linkText WRITE setLinkText NOTIFY changed)
public:
    using QObject::QObject;
    bool valid() const { return m_valid; }
    QString valueText() const { return m_valueText; }
    QString linkText() const { return m_linkText; }
    void set(bool v, const QString &t) { m_valid = v; m_valueText = t; emit changed(); }
    void setLinkText(const QString &t) { if (m_linkText==t) return; m_linkText = t; emit changed(); }
signals:
    void changed();
private:
    bool m_valid = false;
    QString m_valueText = QStringLiteral("0");
    QString m_linkText;
};

class FocusField : public QObject {
    Q_OBJECT
public:
    using QObject::QObject;
    std::function<void(const QVariant&)> linkHandler;
    Q_INVOKABLE void link(const QVariant &r) { if (linkHandler) linkHandler(r); }
};

#include "calculation.moc"

Calculation::Calculation(QObject *parent) : QAbstractListModel(parent)
{
    auto *res = new CalcResult(this);
    m_result = res;
    auto *ff = new FocusField(this);
    ff->linkHandler = [this](const QVariant &r){
        QString vt;
        if (auto obj = qvariant_cast<QObject*>(r)) {
            vt = obj->property("valueText").toString();
        } else if (r.canConvert<QVariantMap>()) {
            vt = r.toMap().value("valueText").toString();
        }
        if (!vt.isEmpty()) insert(vt);
    };
    m_focusField = ff;
}

int Calculation::rowCount(const QModelIndex &parent) const {
    if (parent.isValid()) return 0;
    return m_items.size();
}

QVariant Calculation::data(const QModelIndex &index, int role) const {
    if (!index.isValid() || index.row() < 0 || index.row() >= m_items.size()) return {};
    const Item &it = m_items[index.row()];
    if (role == TypeRole) return it.type;
    if (role == TextRole) return it.text;
    if (role == FieldRole) return it.field;
    return {};
}

QHash<int, QByteArray> Calculation::roleNames() const {
    return {{TypeRole, "type"}, {TextRole, "text"}, {FieldRole, "field"}};
}

void Calculation::setCurrentIndex(int idx) {
    if (m_currentIndex == idx) return;
    m_currentIndex = idx;
    emit currentIndexChanged();
}

int Calculation::ensureField() {
    if (m_items.isEmpty() || m_items.last().type != Field) {
        beginInsertRows(QModelIndex(), m_items.size(), m_items.size());
        m_items.append({Field, QString(), {{"linkText", ""}, {"fraction", false}, {"numerator", ""}, {"denominator", ""}}});
        endInsertRows();
        setCurrentIndex(m_items.size() - 1);
    }
    return m_items.size() - 1;
}

int Calculation::currentFieldIndex() {
    if (m_currentIndex >= 0 && m_currentIndex < m_items.size() && m_items[m_currentIndex].type == Field)
        return m_currentIndex;
    return ensureField();
}

void Calculation::setFieldText(int idx, const QString &text) {
    if (idx < 0 || idx >= m_items.size()) return;
    m_items[idx].text = text;
    m_items[idx].field = {{"linkText", ""}, {"fraction", false}, {"numerator", text}, {"denominator", ""}};
    QModelIndex mi = index(idx);
    emit dataChanged(mi, mi, {TextRole, FieldRole});
}

void Calculation::insert(const QString &t) {
    int idx = currentFieldIndex();
    QString cur = m_items[idx].text;
    setFieldText(idx, cur + t);
    setCurrentIndex(idx);
    static_cast<CalcResult*>(m_result)->set(false, static_cast<CalcResult*>(m_result)->valueText());
}

void Calculation::appendOp(const QString &symbol) {
    if (m_items.isEmpty()) {
        emit operationMadeToEmptyCalculation();
        ensureField();
    } else {
        Item &last = m_items.last();
        if (last.type == Operation) {
            last.text = symbol;
            emit dataChanged(index(m_items.size()-1), index(m_items.size()-1), {TextRole});
            setCurrentIndex(m_items.size()-1);
            static_cast<CalcResult*>(m_result)->set(false, static_cast<CalcResult*>(m_result)->valueText());
            return;
        }
    }
    beginInsertRows(QModelIndex(), m_items.size(), m_items.size()+1);
    m_items.append({Operation, symbol, {}});
    m_items.append({Field, QString(), {{"linkText", ""}, {"fraction", false}, {"numerator", ""}, {"denominator", ""}}});
    endInsertRows();
    setCurrentIndex(m_items.size()-1);
    static_cast<CalcResult*>(m_result)->set(false, static_cast<CalcResult*>(m_result)->valueText());
}

void Calculation::add() { appendOp(QStringLiteral("+")); }
void Calculation::subtract() { appendOp(QStringLiteral("−")); }
void Calculation::multiply() { appendOp(QStringLiteral("×")); }
void Calculation::divide() { appendOp(QStringLiteral("÷")); }
void Calculation::openBracket() { insert(QStringLiteral("(")); }
void Calculation::closeBracket() { insert(QStringLiteral(")")); }
void Calculation::changeSign() {
    int idx = currentFieldIndex();
    QString cur = m_items[idx].text;
    if (cur.startsWith('-')) cur = cur.mid(1);
    else if (!cur.isEmpty()) cur = "-" + cur;
    setFieldText(idx, cur);
}
void Calculation::setConstant(const QVariant &c) {
    int id = c.toInt();
    if (id == Pi || c.toString() == QStringLiteral("π")) insert(QStringLiteral("π"));
    else if (id == E || c.toString() == QStringLiteral("e")) insert(QStringLiteral("e"));
    else insert(c.toString());
}
void Calculation::factorial() { insert(QStringLiteral("!")); }
void Calculation::power() { appendOp(QStringLiteral("^")); }
void Calculation::sine() { insert(QStringLiteral("sin(")); }
void Calculation::cosine() { insert(QStringLiteral("cos(")); }
void Calculation::tangent() { insert(QStringLiteral("tan(")); }
void Calculation::logarithm() { insert(QStringLiteral("ln(")); }
void Calculation::logarithmBase10() { insert(QStringLiteral("log(")); }
void Calculation::squareRoot() { insert(QStringLiteral("√(")); }
void Calculation::paste() {
    if (!qGuiApp) return;
    QClipboard *cb = QGuiApplication::clipboard();
    if (!cb) return;
    const QString t = cb->text();
    if (!t.isEmpty()) insert(t);
}
void Calculation::backspace() {
    if (m_items.isEmpty()) return;
    int idx = m_currentIndex >= 0 ? m_currentIndex : m_items.size()-1;
    if (idx < 0 || idx >= m_items.size()) return;
    if (m_items[idx].type == Field) {
        QString cur = m_items[idx].text;
        if (!cur.isEmpty()) {
            setFieldText(idx, cur.left(cur.size()-1));
        } else if (m_items.size() > 1) {
            beginRemoveRows(QModelIndex(), idx, idx);
            m_items.removeAt(idx);
            endRemoveRows();
            setCurrentIndex(qMax(0, idx-1));
        }
    } else {
        beginRemoveRows(QModelIndex(), idx, idx);
        m_items.removeAt(idx);
        endRemoveRows();
        setCurrentIndex(qMax(0, idx-1));
    }
    static_cast<CalcResult*>(m_result)->set(false, static_cast<CalcResult*>(m_result)->valueText());
}

QString Calculation::buildExpression() const {
    QString expr;
    for (const Item &it : m_items) {
        QString t = it.text;
        t.replace("×", "*").replace("÷", "/").replace("−", "-").replace("π", "3.141592653589793").replace("e", "2.718281828459045");
        t.replace("√(", "sqrt(").replace("sin(", "sin(").replace("cos(", "cos(").replace("tan(", "tan(").replace("ln(", "log(").replace("log(", "log10(");
        expr += t;
    }
    return expr;
}

void Calculation::calculate() {
    QString expr = buildExpression();
    QJSEngine eng;
    eng.evaluate("function sqrt(x){return Math.sqrt(x);} function sin(x){return Math.sin(x);} function cos(x){return Math.cos(x);} function tan(x){return Math.tan(x);} function log(x){return Math.log(x);} function log10(x){return Math.log10?Math.log10(x):Math.log(x)/Math.LN10;}");
    QJSValue val = eng.evaluate(expr);
    if (val.isError() || !val.isNumber()) {
        static_cast<CalcResult*>(m_result)->set(false, QStringLiteral("nan"));
    } else {
        double d = val.toNumber();
        if (std::isnan(d) || std::isinf(d)) static_cast<CalcResult*>(m_result)->set(false, QStringLiteral("nan"));
        else static_cast<CalcResult*>(m_result)->set(true, QString::number(d, 'g', 12));
    }
    emit completed();
}

QString Calculation::functionText(const QVariant &name) const {
    int id = name.toInt();
    if (id == Sine || name.toString()=="sin") return "sin";
    if (id == Cosine || name.toString()=="cos") return "cos";
    if (id == Tangent || name.toString()=="tan") return "tan";
    if (id == Logarithm || name.toString()=="ln") return "ln";
    if (id == LogarithmBase10 || name.toString()=="log") return "log";
    if (id == Factorial || name.toString()=="fact") return "x!";
    if (id == SquareRoot || name.toString()=="sqrt") return "√";
    return name.toString();
}
QString Calculation::constantText(const QVariant &name) const {
    int id = name.toInt();
    if (id == Pi || name.toString()=="π") return "π";
    if (id == E || name.toString()=="e") return "e";
    return name.toString();
}
QString Calculation::symbolText(const QVariant &name) const {
    int id = name.toInt();
    if (id == Divide) return "÷";
    if (id == Multiply) return "×";
    if (id == Subtract) return "−";
    if (id == Add) return "+";
    if (id == Power) return "^";
    if (id == OpenBracket) return "(";
    if (id == CloseBracket) return ")";
    return name.toString();
}
