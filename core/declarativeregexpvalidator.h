#ifndef DECLARATIVEREGEXPVALIDATOR_H
#define DECLARATIVEREGEXPVALIDATOR_H

#include <QValidator>
#include <QRegularExpression>
#include <QJSValue>
#include <QtQml>

class DeclarativeRegExpValidator : public QValidator
{
    Q_OBJECT
    QML_NAMED_ELEMENT(RegExpValidator)
    Q_PROPERTY(QVariant regExp READ regExp WRITE setRegExp NOTIFY regExpChanged)
public:
    explicit DeclarativeRegExpValidator(QObject *parent = nullptr);
    QVariant regExp() const { return m_regExpVar; }
    void setRegExp(const QVariant &v);
    QValidator::State validate(QString &input, int &pos) const override;
signals:
    void regExpChanged();
private:
    QVariant m_regExpVar;
    QRegularExpression m_re;
};

#endif
