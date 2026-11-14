#ifndef DECLARATIVETOUCHINTERACTION_H
#define DECLARATIVETOUCHINTERACTION_H
#include <QObject>
class DeclarativeTouchInteraction : public QObject {
    Q_OBJECT
public:
    enum InteractionMode { EdgeSwipe = 0, Swipe = 1, Pull = 2 };
    Q_ENUM(InteractionMode)
    enum Direction { Up = 0, Down = 1, Left = 2, Right = 3 };
    Q_ENUM(Direction)
};
#endif
