#ifndef DECLARATIVEOPACITYRAMP_H
#define DECLARATIVEOPACITYRAMP_H
#include <QObject>
class DeclarativeOpacityRamp : public QObject {
    Q_OBJECT
public:
    enum Direction { LeftToRight = 0, RightToLeft = 1, TopToBottom = 2, BottomToTop = 3, BothSides = 4, BothEnds = 5 };
    Q_ENUM(Direction)
};
#endif
