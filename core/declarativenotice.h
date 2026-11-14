#ifndef DECLARATIVENOTICE_H
#define DECLARATIVENOTICE_H

#include <QQuickItem>
#include <QTimer>

class DeclarativeNotice : public QQuickItem
{
    Q_OBJECT
    QML_NAMED_ELEMENT(Notice)
    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)
    Q_PROPERTY(int duration READ duration WRITE setDuration NOTIFY durationChanged)
    Q_PROPERTY(int anchor READ anchor WRITE setAnchor NOTIFY anchorChanged)
    Q_PROPERTY(int verticalOffset READ verticalOffset WRITE setVerticalOffset NOTIFY verticalOffsetChanged)
    Q_PROPERTY(int horizontalOffset READ horizontalOffset WRITE setHorizontalOffset NOTIFY horizontalOffsetChanged)
public:
    enum Duration { Short = 2000, Long = 4000 };
    Q_ENUM(Duration)
    enum Anchor { Top = 0, Bottom = 1, Center = 2, Left = 3, Right = 4 };
    Q_ENUM(Anchor)

    explicit DeclarativeNotice(QQuickItem *parent = nullptr);
    QString text() const { return m_text; }
    void setText(const QString &t);
    int duration() const { return m_duration; }
    void setDuration(int d);
    int anchor() const { return m_anchor; }
    void setAnchor(int a);
    int verticalOffset() const { return m_vo; }
    void setVerticalOffset(int v);
    int horizontalOffset() const { return m_ho; }
    void setHorizontalOffset(int v);

    Q_INVOKABLE void show(const QString &t = QString());
    Q_INVOKABLE void hide();

signals:
    void textChanged();
    void durationChanged();
    void anchorChanged();
    void verticalOffsetChanged();
    void horizontalOffsetChanged();
    void clicked();

private:
    QString m_text;
    int m_duration = Short;
    int m_anchor = Top;
    int m_vo = 0;
    int m_ho = 0;
    QTimer m_timer;
};

#endif
