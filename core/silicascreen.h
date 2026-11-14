#ifndef SILICASCREEN_H
#define SILICASCREEN_H

#include <QObject>
#include <QGuiApplication>
#include <QScreen>

class SilicaScreen : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int width READ width NOTIFY sizeChanged)
    Q_PROPERTY(int height READ height NOTIFY sizeChanged)
    Q_PROPERTY(qreal pixelDensity READ pixelDensity NOTIFY screenChanged)
    Q_PROPERTY(qreal devicePixelRatio READ devicePixelRatio NOTIFY screenChanged)
    Q_PROPERTY(int orientation READ orientation NOTIFY sizeChanged)
    Q_PROPERTY(int primaryOrientation READ primaryOrientation NOTIFY screenChanged)
    Q_PROPERTY(int desktopAvailableWidth READ desktopAvailableWidth NOTIFY screenChanged)
    Q_PROPERTY(int desktopAvailableHeight READ desktopAvailableHeight NOTIFY screenChanged)
    Q_PROPERTY(int sizeCategory READ sizeCategory NOTIFY sizeChanged)
    Q_PROPERTY(int Small READ small CONSTANT)
    Q_PROPERTY(int Medium READ medium CONSTANT)
    Q_PROPERTY(int Large READ large CONSTANT)
    Q_PROPERTY(int ExtraLarge READ extraLarge CONSTANT)

    Q_PROPERTY(int _overrideWidth READ overrideWidth WRITE setOverrideWidth NOTIFY sizeChanged)
    Q_PROPERTY(int _overrideHeight READ overrideHeight WRITE setOverrideHeight NOTIFY sizeChanged)

public:
    explicit SilicaScreen(QObject *parent = nullptr);

    int width() const;
    int height() const;
    qreal pixelDensity() const;
    qreal devicePixelRatio() const;
    int orientation() const;
    int primaryOrientation() const;
    int desktopAvailableWidth() const;
    int desktopAvailableHeight() const;
    int sizeCategory() const;
    int small() const { return 1; }
    int medium() const { return 2; }
    int large() const { return 3; }
    int extraLarge() const { return 4; }

    int overrideWidth() const { return m_overrideWidth; }
    void setOverrideWidth(int w);
    int overrideHeight() const { return m_overrideHeight; }
    void setOverrideHeight(int h);

signals:
    void sizeChanged();
    void screenChanged();

private:
    QScreen *screen() const;
    int m_overrideWidth = -1;
    int m_overrideHeight = -1;
};

#endif
