#ifndef DECLARATIVEBUTTONLAYOUT_H
#define DECLARATIVEBUTTONLAYOUT_H

#include <QQuickItem>
#include <QtQml>
#include "buttonlayoutattached.h"

class DeclarativeButtonLayout : public QQuickItem
{
    Q_OBJECT
    QML_NAMED_ELEMENT(ButtonLayout)
    QML_ATTACHED(ButtonLayoutAttached)
    Q_PROPERTY(int preferredWidth READ preferredWidth WRITE setPreferredWidth NOTIFY preferredWidthChanged)
public:
    explicit DeclarativeButtonLayout(QQuickItem *parent = nullptr);
    int preferredWidth() const { return m_preferredWidth; }
    void setPreferredWidth(int v);
    static ButtonLayoutAttached *qmlAttachedProperties(QObject *object) { return new ButtonLayoutAttached(object); }
signals:
    void preferredWidthChanged();
protected:
    void componentComplete() override;
    void updatePolish() override;
    void itemChange(ItemChange change, const ItemChangeData &value) override;
    void geometryChange(const QRectF &newGeometry, const QRectF &oldGeometry) override;
private:
    void relayout();
    int m_preferredWidth = 0;
};

#endif
