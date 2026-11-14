#ifndef BUTTONLAYOUTATTACHED_H
#define BUTTONLAYOUTATTACHED_H

#include <QObject>
#include <QtQml>

class ButtonLayoutAttached : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool newLine READ newLine WRITE setNewLine NOTIFY newLineChanged)
public:
    explicit ButtonLayoutAttached(QObject *parent = nullptr) : QObject(parent) {}
    bool newLine() const { return m_newLine; }
    void setNewLine(bool v) { if (m_newLine == v) return; m_newLine = v; emit newLineChanged(); }
    static ButtonLayoutAttached *qmlAttachedProperties(QObject *object) { return new ButtonLayoutAttached(object); }
signals:
    void newLineChanged();
private:
    bool m_newLine = false;
};

QML_DECLARE_TYPEINFO(ButtonLayoutAttached, QML_HAS_ATTACHED_PROPERTIES)

#endif
