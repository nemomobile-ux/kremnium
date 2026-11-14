#ifndef SILICACOVER_H
#define SILICACOVER_H
#include <QObject>
class SilicaCover : public QObject {
    Q_OBJECT
public:
    enum Status { Inactive = 0, Activating = 1, Active = 2, Deactivating = 3 };
    Q_ENUM(Status)
};
#endif
