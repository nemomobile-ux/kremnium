#ifndef SILICAORIENTATION_H
#define SILICAORIENTATION_H

#include <QObject>

class SilicaOrientation : public QObject
{
    Q_OBJECT
public:
    enum Orientation {
        Portrait = 1,
        PortraitInverted = 2,
        PortraitMask = 3,
        Landscape = 4,
        LandscapeInverted = 8,
        LandscapeMask = 12,
        All = 15
    };
    Q_ENUM(Orientation)
};

#endif
