#ifndef DECLARATIVETOUCHINTERACTION_H
#define DECLARATIVETOUCHINTERACTION_H
#include <QObject>
class DeclarativeTouchInteraction : public QObject {
    Q_OBJECT
public:
    enum Direction { Left = 0, Up = 1, Right = 2, Down = 3 };
    Q_ENUM(Direction)
    enum Mode { Swipe = 0, EdgeSwipe = 1, Pull = 2 };
    Q_ENUM(Mode)
};
#endif
