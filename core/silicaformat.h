#ifndef SILICAFORMAT_H
#define SILICAFORMAT_H
#include <QObject>
#include <QDateTime>
#include <QLocale>
class SilicaFormat : public QObject {
    Q_OBJECT
public:
    enum FormatType { Timepoint = 0, DateFull = 1, DateMedium = 2, DateMediumWithoutYear = 3, DateLong = 4, TimeValueTwentyFourHours = 5 };
    Q_ENUM(FormatType)
    explicit SilicaFormat(QObject *parent = nullptr) : QObject(parent) {}
    Q_INVOKABLE QString formatDate(const QDateTime &date, int format = DateFull) const {
        Q_UNUSED(format);
        return QLocale().toString(date.date(), QLocale::LongFormat);
    }
    Q_INVOKABLE QString formatDate(const QDate &date, int format = DateFull) const {
        Q_UNUSED(format);
        return QLocale().toString(date, QLocale::LongFormat);
    }
    Q_INVOKABLE QString formatTime(const QDateTime &date, int format = 0) const {
        Q_UNUSED(format);
        return QLocale().toString(date.time(), QLocale::ShortFormat);
    }
    Q_INVOKABLE QString formatTime(const QTime &time, int format = 0) const {
        Q_UNUSED(format);
        return QLocale().toString(time, QLocale::ShortFormat);
    }
    Q_INVOKABLE QString formatDateTime(const QDateTime &date, int format = 0) const {
        Q_UNUSED(format);
        return QLocale().toString(date, QLocale::ShortFormat);
    }
    Q_INVOKABLE QString formatDuration(int seconds, int format = 0) const { Q_UNUSED(format); return QString::number(seconds); }
    Q_INVOKABLE QString durationText(int seconds, int format = 0) const { Q_UNUSED(format); return QString::number(seconds); }
    Q_INVOKABLE QString formatFileSize(qint64 bytes) const { return QString::number(bytes) + QStringLiteral(" B"); }
    Q_INVOKABLE QString formatFileSize(double bytes) const { return QString::number(bytes) + QStringLiteral(" B"); }
};
#endif
