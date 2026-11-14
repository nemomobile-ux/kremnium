/*
 * Copyright (C) 2025 Chupligin Sergey <neochapay@gmail.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public License
 * along with this library; see the file COPYING.LIB.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */


#include <sizing.h>

#include "kremniumtheme.h"
#include <QRegularExpression>

KremniumTheme::KremniumTheme(QObject* parent)
    : QObject { parent }
    , m_theme(new Theme(this))
{
    m_fontFamilyHeading = m_theme->fontPath().isEmpty() ? QStringLiteral("sans-serif") : m_theme->fontPath();
    m_fontFamily = m_fontFamilyHeading;
    m_fontSizeTinyBase = m_theme->fontSizeTiny();
    m_fontSizeExtraSmallBase = m_theme->fontSizeSmall();
    m_fontSizeSmallBase = m_theme->fontSizeSmall();
    m_fontSizeMediumBase = m_theme->fontSizeMedium();
    m_fontSizeLargeBase = m_theme->fontSizeLarge();
    m_fontSizeExtraLargeBase = m_theme->fontSizeExtraLarge();
    m_fontSizeHugeBase = m_theme->fontSizeExtraLarge() * 1.2;
    m_fontSizeHuge = m_fontSizeHugeBase;
    m_highlightBackgroundOpacity = 0.3f;
    m_opacityFaint = 0.2f;
    m_opacityLow = 0.4f;
    m_opacityHigh = 0.6f;
    m_opacityOverlay = 0.6f;
    m_horizontalPageMargin = m_theme->itemSpacingLarge();
    m_pageStackIndicatorWidth = m_theme->itemSpacingSmall();
    m_startDragDistance = 20;
    m_minimumPressHighlightTime = 64;
    m_flickDeceleration = 1500.0f;
    m_maximumFlickVelocity = 2500.0f;
    m_iconSizeExtraSmall = 24;
    m_iconSizeSmall = 32;
    m_iconSizeSmallPlus = 48;
    m_iconSizeMedium = 64;
    m_iconSizeLarge = 96;
    m_iconSizeExtraLarge = 128;
    m_iconSizeLauncher = 86;
    m_buttonWidthExtraSmall = 140;
    m_buttonWidthSmall = 200;
    m_buttonWidthMedium = 300;
    m_buttonWidthLarge = 400;
    m_coverSizeSmall = QSize(234, 234);
    m_coverSizeLarge = QSize(204, 374);
    m__homePageMargin = m_horizontalPageMargin;
    m_highlightDimmerColor = QColor(QStringLiteral("#000000"));
    m_secondaryColor = QColor(QStringLiteral("#b0ffffff"));
    m_overlayBackgroundColor = QColor(QStringLiteral("#e6000000"));
    m_backgroundGlowColor = QColor(QStringLiteral("#00000000"));
    m_errorColor = QColor(QStringLiteral("#ff4d4d"));
    m__wallpaperOverlayColor = QColor(QStringLiteral("#66000000"));
    m_lightPrimaryColor = QColor(QStringLiteral("#ffffffff"));
    m_lightSecondaryColor = QColor(QStringLiteral("#b0ffffff"));
    m_darkPrimaryColor = QColor(QStringLiteral("#ff000000"));
    m_darkSecondaryColor = QColor(QStringLiteral("#b0000000"));
    m_secondaryHighlightColor = QColor(QStringLiteral("#80ffffff"));
    m__coverOverlayColor = QColor(QStringLiteral("#33000000"));
    m_colorScheme = LightOnDark;
    m__webviewCustomLayoutWidthScalingFactor = 1.0f;
    connect(m_theme, &Theme::themeUpdated, this, &KremniumTheme::themeChanged);
}

QColor KremniumTheme::rgba(QColor color, float opacity)
{
    color.setAlphaF(qBound(0.0f, opacity, 1.0f));
    return color;
}

float KremniumTheme::pixelRatio() const
{
    return m_theme->dpScaleFactor();
}

QString KremniumTheme::fontFamilyHeading() const
{
    return m_fontFamilyHeading;
}

QString KremniumTheme::fontFamily() const
{
    return m_fontFamily;
}

int KremniumTheme::fontSizeTiny() const
{
    return m_theme->fontSizeTiny();
}

int KremniumTheme::fontSizeExtraSmall() const
{
    return m_theme->fontSizeSmall()*0.8; //TODO
}

int KremniumTheme::fontSizeSmall() const
{
    return m_theme->fontSizeSmall();
}

int KremniumTheme::fontSizeMedium() const
{
    return m_theme->fontSizeMedium();
}

int KremniumTheme::fontSizeLarge() const
{
    return m_theme->fontSizeLarge();
}

int KremniumTheme::fontSizeExtraLarge() const
{
    return m_theme->fontSizeExtraLarge();
}

int KremniumTheme::fontSizeHuge() const
{
    return m_fontSizeHuge;
}

int KremniumTheme::fontSizeTinyBase() const
{
    return m_fontSizeTinyBase;
}

int KremniumTheme::fontSizeExtraSmallBase() const
{
    return m_fontSizeExtraSmallBase;
}

int KremniumTheme::fontSizeSmallBase() const
{
    return m_fontSizeSmallBase;
}

int KremniumTheme::fontSizeMediumBase() const
{
    return m_fontSizeMediumBase;
}

int KremniumTheme::fontSizeLargeBase() const
{
    return m_fontSizeLargeBase;
}

int KremniumTheme::fontSizeHugeBase() const
{
    return m_fontSizeHugeBase;
}

int KremniumTheme::fontSizeExtraLargeBase() const
{
    return m_fontSizeExtraLargeBase;
}

float KremniumTheme::itemSizeExtraSmall() const
{
    return m_theme->itemHeightExtraSmall();
}

float KremniumTheme::itemSizeSmall() const
{
    return m_theme->itemHeightSmall();
}

float KremniumTheme::itemSizeMedium() const
{
    return m_theme->itemHeightMedium();
}

float KremniumTheme::itemSizeLarge() const
{
    return m_theme->itemHeightLarge();
}

float KremniumTheme::itemSizeExtraLarge() const
{
    return m_theme->itemHeightExtraLarge();
}

float KremniumTheme::itemSizeHuge() const
{
    return m_theme->itemHeightHuge();
}

float KremniumTheme::iconSizeExtraSmall() const
{
    return m_iconSizeExtraSmall;
}

float KremniumTheme::iconSizeSmall() const
{
    return m_iconSizeSmall;
}

float KremniumTheme::iconSizeSmallPlus() const
{
    return m_iconSizeSmallPlus;
}

float KremniumTheme::iconSizeMedium() const
{
    return m_iconSizeMedium;
}

float KremniumTheme::iconSizeLarge() const
{
    return m_iconSizeLarge;
}

float KremniumTheme::iconSizeExtraLarge() const
{
    return m_iconSizeExtraLarge;
}

float KremniumTheme::iconSizeLauncher() const
{
    return m_iconSizeLauncher;
}

QStringList KremniumTheme::launcherIconDirectories() const
{
    return m_launcherIconDirectories;
}

float KremniumTheme::buttonWidthExtraSmall() const
{
    return m_buttonWidthExtraSmall;
}

float KremniumTheme::buttonWidthSmall() const
{
    return m_buttonWidthSmall;
}

float KremniumTheme::buttonWidthMedium() const
{
    return m_buttonWidthMedium;
}

float KremniumTheme::buttonWidthLarge() const
{
    return m_buttonWidthLarge;
}

QSize KremniumTheme::coverSizeSmall() const
{
    return m_coverSizeSmall;
}

QSize KremniumTheme::coverSizeLarge() const
{
    return m_coverSizeLarge;
}

float KremniumTheme::paddingSmall() const
{
    return m_theme->itemSpacingSmall();
}

float KremniumTheme::paddingMedium() const
{
    return m_theme->itemSpacingMedium();
}

float KremniumTheme::paddingLarge() const
{
    return m_theme->itemSpacingLarge();
}

float KremniumTheme::highlightBackgroundOpacity() const
{
    return m_highlightBackgroundOpacity;
}

float KremniumTheme::horizontalPageMargin() const
{
    return m_horizontalPageMargin;
}

float KremniumTheme::_homePageMargin() const
{
    return m__homePageMargin;
}

float KremniumTheme::opacityOverlay() const
{
    return m_opacityOverlay;
}


QColor KremniumTheme::highlightColor() const
{
    QColor c = m_theme->accentColor();
    return c.isValid() ? c : QColor(QStringLiteral("#00bcd4"));
}

QColor KremniumTheme::highlightBackgroundColor() const
{
    // Silica uses highlight-derived background for highlighted items; ensure contrast with primary text
    QColor base = highlightColor();
    if (!base.isValid())
        base = QColor(QStringLiteral("#00bcd4"));
    base.setAlphaF(qBound(0.0, (double)m_highlightBackgroundOpacity, 1.0));
    return base;
}

QColor KremniumTheme::highlightDimmerColor() const
{
    return m_highlightDimmerColor.isValid() ? m_highlightDimmerColor : QColor(QStringLiteral("#cc000000"));
}

QColor KremniumTheme::primaryColor() const
{
    QColor c = m_theme->textColor();
    return c.isValid() ? c : QColor(QStringLiteral("#ffffffff"));
}

QColor KremniumTheme::secondaryColor() const
{
    QColor c = m_theme->fillDarkColor();
    return c.isValid() ? c : QColor(QStringLiteral("#b0ffffff"));
}

QColor KremniumTheme::overlayBackgroundColor() const
{
    QColor c = m_theme->backgroundColor();
    if (c.isValid()) return c;
    c = QColor(QStringLiteral("#000000"));
    c.setAlphaF(0.9f);
    return c;
}

QColor KremniumTheme::backgroundGlowColor() const
{
    return m_backgroundGlowColor;
}

QColor KremniumTheme::errorColor() const
{
    return m_errorColor;
}

QColor KremniumTheme::_wallpaperOverlayColor() const
{
    return m__wallpaperOverlayColor;
}

QColor KremniumTheme::lightPrimaryColor() const
{
    return m_lightPrimaryColor;
}

QColor KremniumTheme::lightSecondaryColor() const
{
    return m_lightSecondaryColor;
}

QColor KremniumTheme::darkPrimaryColor() const
{
    return m_darkPrimaryColor;
}

QColor KremniumTheme::darkSecondaryColor() const
{
    return m_darkSecondaryColor;
}

float KremniumTheme::pageStackIndicatorWidth() const
{
    return m_pageStackIndicatorWidth;
}

float KremniumTheme::opacityFaint() const
{
    return m_opacityFaint;
}

float KremniumTheme::opacityLow() const
{
    return m_opacityLow;
}

float KremniumTheme::opacityHigh() const
{
    return m_opacityHigh;
}

QColor KremniumTheme::secondaryHighlightColor() const
{
    return m_secondaryHighlightColor;
}

QColor KremniumTheme::_coverOverlayColor() const
{
    return m__coverOverlayColor;
}

KremniumTheme::ColorScheme KremniumTheme::colorScheme() const
{
    return m_colorScheme;
}

float KremniumTheme::flickDeceleration() const
{
    return m_flickDeceleration;
}

float KremniumTheme::maximumFlickVelocity() const
{
    return m_maximumFlickVelocity;
}

QUrl KremniumTheme::backgroundImage() const
{
    return m_backgroundImage;
}

QUrl KremniumTheme::_homeBackgroundImage() const
{
    return m__homeBackgroundImage;
}

int KremniumTheme::startDragDistance() const
{
    return m_startDragDistance;
}

int KremniumTheme::minimumPressHighlightTime() const
{
    return m_minimumPressHighlightTime;
}

float KremniumTheme::_webviewCustomLayoutWidthScalingFactor() const
{
    return m__webviewCustomLayoutWidthScalingFactor;
}

QString KremniumTheme::highlightText(const QString &text, const QVariant &pattern, const QVariant &color) const
{
    QString pat = pattern.toString();
    if (pat.isEmpty())
        return text.toHtmlEscaped();
    QString escaped = text.toHtmlEscaped();
    QString patEsc = QRegularExpression::escape(pat);
    QRegularExpression re(patEsc, QRegularExpression::CaseInsensitiveOption);
    QColor c = color.value<QColor>();
    if (!c.isValid() && color.canConvert<QString>()) c = QColor(color.toString());
    QString col = c.isValid() ? c.name(QColor::HexArgb) : QStringLiteral("#ffffff");
    return QString(escaped).replace(re, QStringLiteral("<font color='%1'>\\0</font>").arg(col));
}
