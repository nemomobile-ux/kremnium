#ifndef SILICABUSYINDICATORSIZE_H
#define SILICABUSYINDICATORSIZE_H
#include <QObject>
class SilicaBusyIndicatorSize : public QObject {
    Q_OBJECT
public:
    enum Size { ExtraSmall = 0, Small = 1, Medium = 2, Large = 3, ExtraLarge = 4 };
    Q_ENUM(Size)
};
#endif
