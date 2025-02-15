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

#ifndef KREMNIUMTHEME_H
#define KREMNIUMTHEME_H

#include <QColor>
#include <QObject>
#include <QSize>
#include <QUrl>
#include <theme.h>

class KremniumTheme : public QObject {
    Q_OBJECT

    Q_PROPERTY(float pixelRatio READ pixelRatio NOTIFY themeChanged FINAL)
//FONTS
    Q_PROPERTY(QString fontFamilyHeading READ fontFamilyHeading NOTIFY themeChanged FINAL)
    Q_PROPERTY(QString fontFamily READ fontFamily NOTIFY themeChanged FINAL)
    Q_PROPERTY(int fontSizeTiny READ fontSizeTiny NOTIFY themeChanged FINAL)
    Q_PROPERTY(int fontSizeExtraSmall READ fontSizeExtraSmall NOTIFY themeChanged FINAL)
    Q_PROPERTY(int fontSizeSmall READ fontSizeSmall NOTIFY themeChanged FINAL)
    Q_PROPERTY(int fontSizeMedium READ fontSizeMedium NOTIFY themeChanged FINAL)
    Q_PROPERTY(int fontSizeLarge READ fontSizeLarge NOTIFY themeChanged FINAL)
    Q_PROPERTY(int fontSizeExtraLarge READ fontSizeExtraLarge NOTIFY themeChanged FINAL)
    Q_PROPERTY(int fontSizeHuge READ fontSizeHuge NOTIFY themeChanged FINAL)
    Q_PROPERTY(int fontSizeTinyBase READ fontSizeTinyBase NOTIFY themeChanged FINAL)
    Q_PROPERTY(int fontSizeExtraSmallBase READ fontSizeExtraSmallBase NOTIFY themeChanged FINAL)
    Q_PROPERTY(int fontSizeSmallBase READ fontSizeSmallBase NOTIFY themeChanged FINAL)
    Q_PROPERTY(int fontSizeMediumBase READ fontSizeMediumBase NOTIFY themeChanged FINAL)
    Q_PROPERTY(int fontSizeLargeBase READ fontSizeLargeBase NOTIFY themeChanged FINAL)
    Q_PROPERTY(int fontSizeExtraLargeBase READ fontSizeExtraLargeBase NOTIFY themeChanged FINAL)
    Q_PROPERTY(int fontSizeHugeBase READ fontSizeHugeBase NOTIFY themeChanged FINAL)
//ITEMS
    Q_PROPERTY(float itemSizeExtraSmall READ itemSizeExtraSmall NOTIFY themeChanged FINAL)
    Q_PROPERTY(float itemSizeSmall READ itemSizeSmall NOTIFY themeChanged FINAL)
    Q_PROPERTY(float itemSizeMedium READ itemSizeMedium NOTIFY themeChanged FINAL)
    Q_PROPERTY(float itemSizeLarge READ itemSizeLarge NOTIFY themeChanged FINAL)
    Q_PROPERTY(float itemSizeExtraLarge READ itemSizeExtraLarge NOTIFY themeChanged FINAL)
    Q_PROPERTY(float itemSizeHuge READ itemSizeHuge NOTIFY themeChanged FINAL)
//ICONS
    Q_PROPERTY(float iconSizeExtraSmall READ iconSizeExtraSmall NOTIFY themeChanged FINAL)
    Q_PROPERTY(float iconSizeSmall READ iconSizeSmall  NOTIFY themeChanged FINAL)
    Q_PROPERTY(float iconSizeSmallPlus READ iconSizeSmallPlus NOTIFY themeChanged FINAL)
    Q_PROPERTY(float iconSizeMedium READ iconSizeMedium NOTIFY themeChanged FINAL)
    Q_PROPERTY(float iconSizeLarge READ iconSizeLarge NOTIFY themeChanged FINAL)
    Q_PROPERTY(float iconSizeExtraLarge READ iconSizeExtraLarge NOTIFY themeChanged FINAL)
    Q_PROPERTY(float iconSizeLauncher READ iconSizeLauncher NOTIFY themeChanged FINAL)

    Q_PROPERTY(QStringList launcherIconDirectories READ launcherIconDirectories NOTIFY themeChanged FINAL)
 //BUTTONS
    Q_PROPERTY(float buttonWidthExtraSmall READ buttonWidthExtraSmall NOTIFY themeChanged FINAL)
    Q_PROPERTY(float buttonWidthSmall READ buttonWidthSmall NOTIFY themeChanged FINAL)
    Q_PROPERTY(float buttonWidthMedium READ buttonWidthMedium NOTIFY themeChanged FINAL)
    Q_PROPERTY(float buttonWidthLarge READ buttonWidthLarge NOTIFY themeChanged FINAL)
//COVERS
    Q_PROPERTY(QSize coverSizeSmall READ coverSizeSmall NOTIFY themeChanged FINAL)
    Q_PROPERTY(QSize coverSizeLarge READ coverSizeLarge NOTIFY themeChanged FINAL)
//PADDING
    Q_PROPERTY(float paddingSmall READ paddingSmall NOTIFY themeChanged FINAL)
    Q_PROPERTY(float paddingMedium READ paddingMedium NOTIFY themeChanged FINAL)
    Q_PROPERTY(float paddingLarge READ paddingLarge NOTIFY themeChanged FINAL)
//PAGE
    Q_PROPERTY(float horizontalPageMargin READ horizontalPageMargin NOTIFY themeChanged FINAL)
    Q_PROPERTY(float _homePageMargin READ _homePageMargin NOTIFY themeChanged FINAL)
    Q_PROPERTY(float pageStackIndicatorWidth READ pageStackIndicatorWidth NOTIFY themeChanged FINAL)
//OPACITY
    Q_PROPERTY(float highlightBackgroundOpacity READ highlightBackgroundOpacity NOTIFY themeChanged FINAL)
    Q_PROPERTY(float opacityFaint READ opacityFaint NOTIFY themeChanged FINAL)
    Q_PROPERTY(float opacityLow READ opacityLow NOTIFY themeChanged FINAL)
    Q_PROPERTY(float opacityHigh READ opacityHigh NOTIFY themeChanged FINAL)
    Q_PROPERTY(float opacityOverlay READ opacityOverlay NOTIFY themeChanged FINAL)
//COLORS
    Q_PROPERTY(QColor highlightColor READ highlightColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor highlightBackgroundColor READ highlightBackgroundColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor highlightDimmerColor READ highlightDimmerColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor primaryColor READ primaryColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor secondaryColor READ secondaryColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor overlayBackgroundColor READ overlayBackgroundColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor secondaryHighlightColor READ secondaryHighlightColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor backgroundGlowColor READ backgroundGlowColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor errorColor READ errorColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor _wallpaperOverlayColor READ _wallpaperOverlayColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor _coverOverlayColor READ _coverOverlayColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor lightPrimaryColor READ lightPrimaryColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor lightSecondaryColor READ lightSecondaryColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor darkPrimaryColor READ darkPrimaryColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor darkSecondaryColor READ darkSecondaryColor NOTIFY themeChanged FINAL)
//OTHER
    Q_PROPERTY(ColorScheme colorScheme READ colorScheme NOTIFY themeChanged FINAL)
    Q_PROPERTY(float flickDeceleration READ flickDeceleration NOTIFY themeChanged FINAL)
    Q_PROPERTY(float maximumFlickVelocity READ maximumFlickVelocity NOTIFY themeChanged FINAL)
    Q_PROPERTY(QUrl backgroundImage READ backgroundImage NOTIFY themeChanged FINAL)
    Q_PROPERTY(QUrl _homeBackgroundImage READ _homeBackgroundImage NOTIFY themeChanged FINAL)
    Q_PROPERTY(int startDragDistance READ startDragDistance NOTIFY themeChanged FINAL)
    Q_PROPERTY(int minimumPressHighlightTime READ minimumPressHighlightTime NOTIFY themeChanged FINAL)
    Q_PROPERTY(float _webviewCustomLayoutWidthScalingFactor READ _webviewCustomLayoutWidthScalingFactor NOTIFY themeChanged FINAL)

public:
    explicit KremniumTheme(QObject* parent = nullptr);

    enum ColorScheme{
        LightOnDark,
        DarkOnLight
    };

    Q_INVOKABLE QColor rgba(QColor color, float opacity);

    float pixelRatio() const;
    QString fontFamilyHeading() const;
    QString fontFamily() const;
    int fontSizeTiny() const;
    int fontSizeExtraSmall() const;
    int fontSizeSmall() const;
    int fontSizeMedium() const;
    int fontSizeLarge() const;
    int fontSizeExtraLarge() const;
    int fontSizeHuge() const;
    int fontSizeTinyBase() const;
    int fontSizeExtraSmallBase() const;
    int fontSizeSmallBase() const;
    int fontSizeMediumBase() const;
    int fontSizeLargeBase() const;
    int fontSizeHugeBase() const;
    int fontSizeExtraLargeBase() const;

    float itemSizeExtraSmall() const;
    float itemSizeSmall() const;
    float itemSizeMedium() const;
    float itemSizeLarge() const;
    float itemSizeExtraLarge() const;
    float itemSizeHuge() const;
    float iconSizeExtraSmall() const;
    float iconSizeSmall() const;
    float iconSizeSmallPlus() const;
    float iconSizeMedium() const;
    float iconSizeLarge() const;
    float iconSizeExtraLarge() const;
    float iconSizeLauncher() const;
    QStringList launcherIconDirectories() const;
    float buttonWidthExtraSmall() const;
    float buttonWidthSmall() const;
    float buttonWidthMedium() const;
    float buttonWidthLarge() const;
    QSize coverSizeSmall() const;
    QSize coverSizeLarge() const;
    float paddingSmall() const;
    float paddingMedium() const;
    float paddingLarge() const;
    float highlightBackgroundOpacity() const;
    float horizontalPageMargin() const;
    float _homePageMargin() const;
    float opacityOverlay() const;
    QColor highlightColor() const;
    QColor highlightBackgroundColor() const;
    QColor highlightDimmerColor() const;
    QColor primaryColor() const;
    QColor secondaryColor() const;
    QColor overlayBackgroundColor() const;
    QColor backgroundGlowColor() const;
    QColor errorColor() const;
    QColor _wallpaperOverlayColor() const;
    QColor lightPrimaryColor() const;
    QColor lightSecondaryColor() const;
    QColor darkPrimaryColor() const;
    QColor darkSecondaryColor() const;
    float pageStackIndicatorWidth() const;
    float opacityFaint() const;
    float opacityLow() const;
    float opacityHigh() const;
    QColor secondaryHighlightColor() const;
    QColor _coverOverlayColor() const;
    KremniumTheme::ColorScheme colorScheme() const;
    float flickDeceleration() const;
    float maximumFlickVelocity() const;
    QUrl backgroundImage() const;
    QUrl _homeBackgroundImage() const;
    int startDragDistance() const;
    int minimumPressHighlightTime() const;
    float _webviewCustomLayoutWidthScalingFactor() const;

signals:
    void themeChanged();
    void homeBackgroundImageChanged();
    void wallpaperOverlayColorChanged();

private:
    Theme* m_theme;

    QString m_fontFamilyHeading;
    QString m_fontFamily;
    int m_fontSizeExtraSmall;
    int m_fontSizeHuge;
    int m_fontSizeTinyBase;
    int m_fontSizeExtraSmallBase;
    int m_fontSizeSmallBase;
    int m_fontSizeMediumBase;
    int m_fontSizeLargeBase;
    int m_fontSizeHugeBase;
    int m_fontSizeExtraLargeBase;

    float m_iconSizeExtraSmall;
    float m_iconSizeSmall;
    float m_iconSizeSmallPlus;
    float m_iconSizeMedium;
    float m_iconSizeLarge;
    float m_iconSizeExtraLarge;
    float m_iconSizeLauncher;
    QStringList m_launcherIconDirectories;
    float m_buttonWidthExtraSmall;
    float m_buttonWidthSmall;
    float m_buttonWidthMedium;
    float m_buttonWidthLarge;
    QSize m_coverSizeSmall;
    QSize m_coverSizeLarge;

    float m_highlightBackgroundOpacity;
    float m_horizontalPageMargin;
    float m__homePageMargin;
    float m_opacityOverlay;

    QColor m_highlightDimmerColor;

    QColor m_secondaryColor;
    QColor m_overlayBackgroundColor;
    QColor m_backgroundGlowColor;
    QColor m_errorColor;
    QColor m__wallpaperOverlayColor;
    QColor m_lightPrimaryColor;
    QColor m_lightSecondaryColor;
    QColor m_darkPrimaryColor;
    QColor m_darkSecondaryColor;
    float m_pageStackIndicatorWidth;
    float m_opacityFaint;
    float m_opacityLow;
    float m_opacityHigh;
    QColor m_secondaryHighlightColor;
    QColor m__coverOverlayColor;
    ColorScheme m_colorScheme;
    float m_flickDeceleration;
    float m_maximumFlickVelocity;
    QUrl m_backgroundImage;
    QUrl m__homeBackgroundImage;
    int m_startDragDistance;
    int m_minimumPressHighlightTime;
    float m__webviewCustomLayoutWidthScalingFactor;
};
#endif // KREMNIUMTHEME_H
