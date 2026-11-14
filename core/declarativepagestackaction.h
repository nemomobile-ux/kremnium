#ifndef DECLARATIVEPAGESTACKACTION_H
#define DECLARATIVEPAGESTACKACTION_H

#include <QObject>

class DeclarativePageStackAction : public QObject
{
    Q_OBJECT
public:
    enum Action { Animated = 0, Immediate = 1 };
    Q_ENUM(Action)
};

#endif
