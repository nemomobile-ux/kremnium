#ifndef ENTERKEYATTACHED_H
#define ENTERKEYATTACHED_H

#include <QObject>
#include <QUrl>
#include <QtQml>

class EnterKeyAttached : public QObject
{
    Q_OBJECT
    QML_ANONYMOUS
    Q_PROPERTY(QUrl iconSource READ iconSource WRITE setIconSource NOTIFY iconSourceChanged)
    Q_PROPERTY(bool enabled READ enabled WRITE setEnabled NOTIFY enabledChanged)
    Q_PROPERTY(bool highlighted READ highlighted WRITE setHighlighted NOTIFY highlightedChanged)
    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)
public:
    explicit EnterKeyAttached(QObject *parent = nullptr) : QObject(parent) {}
    QUrl iconSource() const { return m_iconSource; }
    void setIconSource(const QUrl &v) { if (m_iconSource == v) return; m_iconSource = v; emit iconSourceChanged(); }
    bool enabled() const { return m_enabled; }
    void setEnabled(bool v) { if (m_enabled == v) return; m_enabled = v; emit enabledChanged(); }
    bool highlighted() const { return m_highlighted; }
    void setHighlighted(bool v) { if (m_highlighted == v) return; m_highlighted = v; emit highlightedChanged(); }
    QString text() const { return m_text; }
    void setText(const QString &v) { if (m_text == v) return; m_text = v; emit textChanged(); }
    static EnterKeyAttached *qmlAttachedProperties(QObject *object) { return new EnterKeyAttached(object); }
signals:
    void iconSourceChanged();
    void enabledChanged();
    void highlightedChanged();
    void textChanged();
    void clicked();
private:
    QUrl m_iconSource;
    bool m_enabled = true;
    bool m_highlighted = false;
    QString m_text;
};

class EnterKey : public QObject
{
    Q_OBJECT
    QML_ATTACHED(EnterKeyAttached)
    QML_NAMED_ELEMENT(EnterKey)
    QML_UNCREATABLE("EnterKey is an attached property")
public:
    static EnterKeyAttached *qmlAttachedProperties(QObject *object) { return new EnterKeyAttached(object); }
};

#endif
