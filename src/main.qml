import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.13
import Qt.labs.settings 1.0

import "Components"

Window {
    id: window
    visible: true
    width: 300
    height: 300

    maximumWidth: width
    maximumHeight: height

    minimumWidth: width
    minimumHeight: height

    color: appSettings.darkMode ? colors.bgDark : colors.bgLight
    title: qsTr("qml timer")

    property string clockMode: "start"

    onClockModeChanged: { canvas.requestPaint()}

    function checkClockMode (){
        if (pomodoroQueue.infiniteMode && globalTimer.running){
            clockMode = "pomodoro"
        } else if (!pomodoroQueue.infiniteMode){
            clockMode = "timer"
        } else {
            clockMode = "start"
        }
    }

    NotificationSystem {
        id: notifications
    }


    PomodoroModel {
        id: pomodoroQueue
        durationSettings: durationSettings
    }

    Settings {
        id: durationSettings

        property real pomodoro: 25 * 60
        property real pause: 10 * 60
        property real breakTime: 15 * 60
        property int repeatBeforeBreak: 2
    }

    Settings {
        id: appSettings

        property bool darkMode: false
        property alias soundMuted: notifications.soundMuted
        property bool splitToSequence: false

        onDarkModeChanged: { canvas.requestPaint(); }
        onSplitToSequenceChanged: { canvas.requestPaint(); }
    }

    Colors {
        id: colors
    }

    QTimer {
        id: globalTimer
    }

    QtObject {
        id: time
        property real hours: 0
        property real minutes: 0
        property real seconds: 0

        function updateTime(){
            var currentDate = new Date()
            hours = currentDate.getHours()
            minutes = currentDate.getMinutes()
            seconds = currentDate.getSeconds()
        }
    }

    StackView {
        id: content
        initialItem: timerLayout

        anchors.rightMargin: 16
        anchors.leftMargin: 16
        anchors.bottomMargin: 16
        anchors.topMargin: 16
        anchors.fill: parent

        Item {
            id: timerLayout
            anchors.fill: parent

            Dials {
                id: canvas

            MouseTracker {
                id: mouseArea}
            }

            StartScreen {
                id: startControls
            }

            TimerScreen {
                id: digitalClock
            }

          SoundButton {
                  id: soundButton
          }
        }

        Preferences {
            id: preferences
            visible: false
        }

        PrefsButton {
            id: prefsButton
        }
        DarkModeButton {
            id: darkModeButton
        }

    }
}






/*##^##
Designer {
    D{i:1;anchors_height:200;anchors_width:200;anchors_x:50;anchors_y:55}D{i:3;anchors_height:200;anchors_width:200;anchors_x:44;anchors_y:55}
D{i:5;anchors_x:99;anchors_y:54}D{i:6;anchors_x:99;anchors_y:54}D{i:7;anchors_x:104;invisible:true}
D{i:15;anchors_width:200;invisible:true}D{i:18;anchors_width:200;anchors_x:99;anchors_y:54}
D{i:19;anchors_width:200;anchors_x:99;anchors_y:54}D{i:21;anchors_x:99;anchors_y:54}
D{i:22;anchors_x:99;anchors_y:54}D{i:20;anchors_x:99;anchors_y:54}D{i:24;anchors_x:245;anchors_y:245}
D{i:25;anchors_x:99;anchors_y:54;invisible:true}D{i:16;anchors_height:40;anchors_x:99;anchors_y:54;invisible:true}
D{i:28;anchors_x:99;anchors_y:54;invisible:true}D{i:27;anchors_x:99;anchors_y:54}
D{i:29;anchors_x:99;anchors_y:54}D{i:32;anchors_width:100}D{i:36;anchors_height:22}
D{i:35;anchors_x:99;anchors_y:54}D{i:26;anchors_x:99;anchors_y:54}D{i:40;anchors_x:99;anchors_y:54}
D{i:9;anchors_height:200;anchors_width:200;anchors_x:0;anchors_y:0}D{i:44;anchors_x:99;anchors_y:54}
D{i:45;anchors_x:99;anchors_y:54}D{i:46;anchors_x:99;anchors_y:54}D{i:47;anchors_x:99;anchors_y:54}
D{i:43;anchors_x:99;anchors_y:54}D{i:49;invisible:true}D{i:50;invisible:true}D{i:51;invisible:true}
D{i:52;invisible:true}D{i:48;anchors_x:99;anchors_y:54}D{i:59;invisible:true}D{i:60;invisible:true}
D{i:61;invisible:true}D{i:58;invisible:true}D{i:42;anchors_x:99;anchors_y:54}D{i:41;anchors_x:99;anchors_y:54}
D{i:63;invisible:true}D{i:64;invisible:true}D{i:62;invisible:true}D{i:65;invisible:true}
D{i:8;anchors_height:200;anchors_width:200;anchors_x:0;anchors_y:0;invisible:true}
}
##^##*/

