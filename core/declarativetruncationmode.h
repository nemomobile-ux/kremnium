#ifndef DECLARATIVETRUNCATIONMODE_H
#define DECLARATIVETRUNCATIONMODE_H

#include <QObject>

class DeclarativeTruncationMode : public QObject {
    Q_OBJECT
public:
    explicit DeclarativeTruncationMode(QObject* parent = nullptr);
    enum Mode {
        None,
        Elide,
        Fade
    };
    Q_ENUM(Mode)

signals:
};

#endif // DECLARATIVETRUNCATIONMODE_H
