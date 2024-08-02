import QtQuick
import QtQuick.Layouts
import QtQuick.Controls


Window {
    id: window
    width: 800
    height: 480
    visible: true
    title: qsTr("Multi-Lingo")
    color: "lightgrey"


    property string lastTime: ""

    Text{
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 20
        text: "Preferred Language: "+ch.returnlan()
    }

    ColumnLayout{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 25
        spacing: 5
    Text{
        text: qsTr("Current Date & Time:")
        font.bold: true
        font.pixelSize: 24
    }
    Text{
        id: currentdt
        property string dt : ""
        text: dt
        font.pixelSize: 24
    }
    }
    Timer {
        interval: 1000 // Update time every 60 seconds
        running: true
        repeat: true
        onTriggered: {

                var timezone = ch.returnval();
                var url = "https://worldtimeapi.org/api/timezone/" + timezone;
                var request = new XMLHttpRequest();
                request.open("GET", url);
                request.onreadystatechange = function() {
                    if (request.readyState === XMLHttpRequest.DONE) {
                        if (request.status === 200) {
                            var response = JSON.parse(request.responseText);
                            var isoTimeString = response.utc_datetime;
                            var date = new Date(isoTimeString);
                            // Use the timezone offset provided by the API
                            var offset = response.utc_offset;
                            var offsetHours = parseInt(offset.substr(1, 2), 10);
                            var offsetMinutes = parseInt(offset.substr(4, 2), 10);
                            var totalOffsetMinutes = offsetHours * 60 + offsetMinutes;
                            if (offset[0] === '-') {
                                totalOffsetMinutes = -totalOffsetMinutes;
                            }
                            date.setMinutes(date.getMinutes() + totalOffsetMinutes);
                            var localDateTime = date.toISOString().substr(0, 16).replace("T", " "); // Extract date and time part
                            var datestack = new Date(localDateTime)
                                    // Prints "30 Jan 2016 12h"
                                    console.log(Qt.formatDateTime(datestack, "dd MMM yyyy h'h'"))
                            // Update the text property of the Text element
                            currentdt.dt = timezone+"\n"+Qt.formatDateTime(datestack, "dd MMM '-' h':'mm");
                        } else {
                            currentdt.dt = timezone+"\nError fetching time";
                        }
                    }
                };
                request.send();

        }
        }
RowLayout{
    anchors.centerIn: parent
spacing: 100
    ColumnLayout {
        x:50
        y:50
    spacing :20
    Text {
    text: qsTr("Enter timezone ")
    font.pixelSize: 18
    font.bold: true
}
        ComboBox {
                id: timeComboBox
               Layout.preferredHeight: 50
                   Layout.preferredWidth: 200

                model: timeModel
                delegate: ItemDelegate {
                    width: timeComboBox.width
                    text: model.name

                    onClicked: {
                        console.log("Selected timezone:", model.name)
                        ch.setval(model.name)
                        lastTime=model.name
                    }
                }

            }


            ListModel {
                id: timeModel
                ListElement { name: "Europe/Berlin" }
                ListElement { name: "America/New_York" }
                ListElement { name: "Asia/Tokyo" }
                ListElement { name: "Australia/Sydney" }
                ListElement { name: "Asia/Kolkata" }
            }
}
ColumnLayout{
      spacing : 20
        Text{
            text: qsTr("Enter your preferred language")
            color: "Black"
            font.pixelSize: 18
            font.bold: true
        }

        TextField {
            id: textFeild1
            Layout.preferredHeight: 50
                Layout.preferredWidth: 200
            placeholderText: qsTr("Language")
            echoMode: TextInput.Normal
            font.pixelSize: 20

            MouseArea{
                anchors.fill: parent
                //onClicked: popup.open()
                 onClicked: menu.open()
            }

        }

        Menu{
            id:menu
            width: textFeild1.width
            y: textFeild1.height

            MenuItem{
                text: "English"
                onClicked:{
                    textFeild1.text = "English"
                    ch.setlang("English")
                    menu.close();
                }
            }
            MenuItem{
                text: "Hindi"
                onClicked: {
                    textFeild1.text = "Hindi"
                    ch.setlang("Hindi")
                    menu.close();
                }
            }

        }
}


    }


    RoundButton{
        id: con_but
        width: 100
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        text: qsTr("Continue")
        onPressed: con_anim.start()
        onClicked:{
            console.log("back button clicked")
            // timeFetcherr.running=false
            popup.open()

        }
        SequentialAnimation {
            id: con_anim

            // Expand the button
            PropertyAnimation {
                target: con_but
                property: "scale"
                to: 1.3
                duration: 200
                easing.type: Easing.InOutQuad
            }

            // Shrink back to normal
            PropertyAnimation {
                target: con_but
                property: "scale"
                to: 1.0
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
    }
    Popup {
        id: popup
        anchors.centerIn: parent
        width: 340
        height: 160
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape

        Rectangle {
            anchors.fill: parent
            color: "#ffffff"
            border.color: "#d7d2c9"
            border.width: 1
            radius: 10
        ColumnLayout{
            anchors.fill: parent
            anchors.margins: 10
            spacing: 20
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        Text {
            id: selectfarm_popup_text
            font.pointSize: 16
            color: "black"
            text:qsTr("Restart application to store\ndate-time & language settings.")
        }
        RoundButton{
            id: selectfarm_popup_but
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            text: qsTr("OK")
            Layout.preferredHeight: 50
            Layout.preferredWidth: 100
           onClicked: {

                Qt.exit(Application)
           }
        }
        }
        }
        onOpened: {
            openAnimm.start()
        }

        onClosed: {
            closeAnimm.start()
        }
    }
    SequentialAnimation {
        id: openAnimm
        NumberAnimation {
            target: popup
            property: "opacity"
            from: 0
            to: 1
            duration: 300
            easing.type: Easing.InOutQuad
        }
    }

    SequentialAnimation {
        id: closeAnimm
        NumberAnimation {
            target: popup
            property: "opacity"
            from: 1
            to: 0
            duration: 300
            easing.type: Easing.InOutQuad
        }
    }



}
