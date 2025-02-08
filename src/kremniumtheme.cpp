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

KremniumTheme::KremniumTheme(QObject* parent)
    : QObject { parent }
    , m_theme(new Theme(this))
{
    connect(m_theme, &Theme::themeUpdated, this, &KremniumTheme::themeChanged);
}

QColor KremniumTheme::rgba(QColor color, float opacity)
{
    Q_UNUSED(opacity)
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
    return m_theme->accentColor();
}

QColor KremniumTheme::highlightBackgroundColor() const
{
    return m_theme->backgroundAccentColor();
}

QColor KremniumTheme::highlightDimmerColor() const
{
    return m_highlightDimmerColor;
}

QColor KremniumTheme::primaryColor() const
{
    return m_theme->textColor();
}

QColor KremniumTheme::secondaryColor() const
{
    return m_theme->fillDarkColor();
}

QColor KremniumTheme::overlayBackgroundColor() const
{
    return m_overlayBackgroundColor;
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
