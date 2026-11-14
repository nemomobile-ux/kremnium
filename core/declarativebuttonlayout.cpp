#include "declarativebuttonlayout.h"
#include <QtQml>

DeclarativeButtonLayout::DeclarativeButtonLayout(QQuickItem *parent) : QQuickItem(parent)
{
}

void DeclarativeButtonLayout::setPreferredWidth(int v)
{
    if (m_preferredWidth == v) return;
    m_preferredWidth = v;
    emit preferredWidthChanged();
    polish();
}

void DeclarativeButtonLayout::componentComplete()
{
    QQuickItem::componentComplete();
    polish();
}

void DeclarativeButtonLayout::updatePolish()
{
    relayout();
}

void DeclarativeButtonLayout::itemChange(ItemChange change, const ItemChangeData &value)
{
    QQuickItem::itemChange(change, value);
    if (change == ItemChildAddedChange || change == ItemChildRemovedChange) {
        polish();
    }
}

void DeclarativeButtonLayout::geometryChange(const QRectF &newGeometry, const QRectF &oldGeometry)
{
    QQuickItem::geometryChange(newGeometry, oldGeometry);
    if (newGeometry.width() != oldGeometry.width())
        polish();
}

void DeclarativeButtonLayout::relayout()
{
    const auto kids = childItems();
    qreal x = 0, y = 0, rowH = 0;
    const qreal spacing = 16;
    const qreal w = width();
    for (QQuickItem *c : kids) {
        if (!c || !c->isVisible())
            continue;
        bool nl = false;
        QObject *attObj = qmlAttachedPropertiesObject<DeclarativeButtonLayout>(c, false);
        if (auto *att = qobject_cast<ButtonLayoutAttached*>(attObj))
            nl = att->newLine();
        if (nl && x > 0) { x = 0; y += rowH + spacing; rowH = 0; }
        qreal cw = c->implicitWidth() > 0 ? c->implicitWidth() : c->width();
        qreal ch = c->implicitHeight() > 0 ? c->implicitHeight() : c->height();
        if (m_preferredWidth > 0) cw = m_preferredWidth;
        if (x > 0 && w > 0 && x + cw > w) { x = 0; y += rowH + spacing; rowH = 0; }
        c->setX(x);
        c->setY(y);
        if (m_preferredWidth > 0) c->setWidth(cw);
        x += cw + spacing;
        if (ch > rowH) rowH = ch;
    }
    setImplicitHeight(y + rowH);
}
