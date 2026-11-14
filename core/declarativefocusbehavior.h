#ifndef DECLARATIVEFOCUSBEHAVIOR_H
#define DECLARATIVEFOCUSBEHAVIOR_H
#include <QObject>
class DeclarativeFocusBehavior : public QObject {
    Q_OBJECT
public:
    enum FocusBehavior { ClearItemFocus = 0, ClearPageFocus = 1, KeepFocus = 2 };
    Q_ENUM(FocusBehavior)
};
#endif
