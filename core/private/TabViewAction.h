#ifndef TABVIEWACTION_H
#define TABVIEWACTION_H
#include <QObject>
class TabViewAction : public QObject {
    Q_OBJECT
public:
    enum Action { Immediate = 0, Animated = 1 };
    Q_ENUM(Action)
};
#endif
