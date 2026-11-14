#include "declarativeregexpvalidator.h"
#include <QJSValue>

DeclarativeRegExpValidator::DeclarativeRegExpValidator(QObject *parent) : QValidator(parent) {}

void DeclarativeRegExpValidator::setRegExp(const QVariant &v)
{
    m_regExpVar = v;
    QString pattern;
    if (v.canConvert<QJSValue>()) {
        QJSValue js = v.value<QJSValue>();
        if (js.isRegExp()) {
            // try to get source/pattern; QJSValue doesn't expose directly in all APIs, use toString as fallback
            pattern = js.toString();
            if (pattern.startsWith('/') && pattern.lastIndexOf('/') > 0) {
                int last = pattern.lastIndexOf('/');
                pattern = pattern.mid(1, last - 1);
            }
        } else {
            pattern = js.toString();
        }
    } else if (v.canConvert<QRegularExpression>()) {
        m_re = v.toRegularExpression();
        emit regExpChanged();
        emit changed();
        return;
    } else {
        pattern = v.toString();
        if (pattern.startsWith('/') && pattern.lastIndexOf('/') > 0) {
            int last = pattern.lastIndexOf('/');
            pattern = pattern.mid(1, last - 1);
        }
    }
    m_re = QRegularExpression(pattern);
    emit regExpChanged();
    emit changed();
}

QValidator::State DeclarativeRegExpValidator::validate(QString &input, int &pos) const
{
    if (!m_re.isValid())
        return QValidator::Acceptable;
    QRegularExpressionMatch m = m_re.match(input);
    if (m.hasMatch() && m.capturedStart() == 0 && m.capturedLength() == input.length())
        return QValidator::Acceptable;
    // partial match heuristic
    QRegularExpression partial(m_re.pattern());
    QRegularExpressionMatch pm = partial.match(input, 0, QRegularExpression::PartialPreferCompleteMatch);
    if (pm.hasPartialMatch() || pm.hasMatch())
        return QValidator::Intermediate;
    return QValidator::Invalid;
}
