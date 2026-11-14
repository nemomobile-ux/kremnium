#ifndef DECLARATIVEDOCK_H
#define DECLARATIVEDOCK_H
#include <QObject>
class DeclarativeDock : public QObject {
    Q_OBJECT
public:
    enum Dock { Left = 0, Right = 1, Top = 2, Bottom = 3 };
    Q_ENUM(Dock)
};
#endif
