#ifndef DECLARATIVETEXTEDITOR_H
#define DECLARATIVETEXTEDITOR_H
#include <QObject>
class DeclarativeTextEditor : public QObject {
    Q_OBJECT
public:
    enum BackgroundStyle { UnderlineBackground = 0, FilledBackground = 1, NoBackground = 2 };
    Q_ENUM(BackgroundStyle)
};
#endif
