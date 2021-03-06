/*
*  Copyright 2016  Smith AR <audoban@openmailbox.org>
*                  Michail Vourlakos <mvourlakos@gmail.com>
*
*  This file is part of Latte-Dock
*
*  Latte-Dock is free software; you can redistribute it and/or
*  modify it under the terms of the GNU General Public License as
*  published by the Free Software Foundation; either version 2 of
*  the License, or (at your option) any later version.
*
*  Latte-Dock is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*
*  You should have received a copy of the GNU General Public License
*  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as Components

import QtGraphicalEffects 1.0

Item{
    //   property string color
    id: glowItem  

    property bool roundCorners: true
    property bool showAttention: false

    property int animation: root.durationTime*units.longDuration

    property color attentionColor: colorScopePalette.negativeTextColor // "#ffff1717"
    property color basicColor: "blue"

    onShowAttentionChanged: {
        if(showAttention == false){
            smallCircle.color = basicColor;
        }
    }

    Item{
        id:mainGlow
        anchors.fill: parent

        Rectangle {
            id: smallCircle
            anchors.centerIn: parent
            anchors.fill: parent

            color: glowItem.basicColor
            radius: glowItem.roundCorners ? Math.min(width,height) / 2 : 0


            SequentialAnimation{
                running: (glowItem.showAttention == true)
                loops: Animation.Infinite

                PropertyAnimation {
                    target: smallCircle
                    property: "color"
                    to: glowItem.attentionColor
                    duration: glowItem.animation
                    easing.type: Easing.InOutQuad
                }

                PropertyAnimation {
                    target:smallCircle
                    property: "color"
                    to: glowItem.basicColor
                    duration: glowItem.animation
                    easing.type: Easing.InOutQuad
                }
            }           
        }

       RectangularGlow {
            id:recGlow
            anchors.fill: smallCircle
            glowRadius: 2 * Math.min(smallCircle.width, smallCircle.height)
            spread: 0.2
            color: smallCircle.color
            //color: "#cc222222"
         //   cornerRadius: smallCircle.radius + glowRadius
            opacity: root.showBarLine ? 0.25 : 0.45
            visible: root.showGlow
        }

     /*   BrightnessContrast {
            anchors.fill: recGlow
            source: recGlow
            anchors.margins: 1
            brightness: 0.4
            contrast: 0.3
            visible: root.glow
        }*/
    }



}
