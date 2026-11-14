#ifndef THEMEIMAGEPROVIDER_H
#define THEMEIMAGEPROVIDER_H

#include <QQuickImageProvider>
#include <QPixmap>
#include <QIcon>
#include <QPainter>
#include <QColor>
#include <QFont>

class ThemeImageProvider : public QQuickImageProvider
{
public:
    ThemeImageProvider() : QQuickImageProvider(QQuickImageProvider::Pixmap) {}

    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize) override
    {
        // id may include query like "icon-m-clipboard?#ffffff"
        QString name = id.section('?', 0, 0);
        QString colorPart = id.section('?', 1, 1);
        QColor color = colorPart.isEmpty() ? QColor(Qt::white) : QColor(colorPart);
        if (!color.isValid()) color = Qt::white;

        QIcon icon = QIcon::fromTheme(name);
        QSize s = requestedSize.isValid() ? requestedSize : QSize(64, 64);
        QPixmap pm = icon.isNull() ? QPixmap() : icon.pixmap(s);

        if (pm.isNull()) {
            pm = QPixmap(s);
            pm.fill(Qt::transparent);
            QString glyph;
            if (name.contains("backspace")) glyph = QStringLiteral("⌫");
            else if (name.contains("clipboard")) glyph = QStringLiteral("⎘");
            else if (name.contains("clear")) glyph = QStringLiteral("✕");
            else if (name.contains("chevron-left") || name.contains("back")) glyph = QStringLiteral("‹");
            else if (name.contains("ellipsis")) glyph = QStringLiteral("⋮");
            if (!glyph.isEmpty()) {
                QPainter p(&pm);
                p.setRenderHint(QPainter::Antialiasing);
                p.setPen(color);
                QFont f = p.font();
                f.setPixelSize(qMax(12, s.height() * 55 / 100));
                p.setFont(f);
                p.drawText(pm.rect(), Qt::AlignCenter, glyph);
            }
        }
        if (size) *size = pm.size();
        return pm;
    }
};

#endif
