#ifndef DECLARATIVEPAGESTATUS_H
#define DECLARATIVEPAGESTATUS_H

#include <QObject>

class DeclarativePageStatus : public QObject {
    Q_OBJECT
public:
    explicit DeclarativePageStatus(QObject* parent = nullptr);
    enum Status {
        Inactive,
        Activating,
        Active,
        Deactivating
    };
    Q_ENUM(Status)
};

#endif // DECLARATIVEPAGESTATUS_H
