#include "declarativenotice.h"

DeclarativeNotice::DeclarativeNotice(QQuickItem *parent) : QQuickItem(parent)
{
    setVisible(false);
    m_timer.setSingleShot(true);
    connect(&m_timer, &QTimer::timeout, this, [this]() { setVisible(false); });
}

void DeclarativeNotice::setText(const QString &t) { if (m_text == t) return; m_text = t; emit textChanged(); }
void DeclarativeNotice::setDuration(int d) { if (m_duration == d) return; m_duration = d; emit durationChanged(); }
void DeclarativeNotice::setAnchor(int a) { if (m_anchor == a) return; m_anchor = a; emit anchorChanged(); }
void DeclarativeNotice::setVerticalOffset(int v) { if (m_vo == v) return; m_vo = v; emit verticalOffsetChanged(); }
void DeclarativeNotice::setHorizontalOffset(int v) { if (m_ho == v) return; m_ho = v; emit horizontalOffsetChanged(); }

void DeclarativeNotice::show(const QString &t)
{
    if (!t.isEmpty()) setText(t);
    setVisible(true);
    m_timer.start(m_duration > 0 ? m_duration : Short);
}

void DeclarativeNotice::hide()
{
    m_timer.stop();
    setVisible(false);
}
