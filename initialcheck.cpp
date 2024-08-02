#include "initialcheck.h"

InitialCheck::InitialCheck() {}

//sets the chosen timezone to the variable.
Q_INVOKABLE void InitialCheck::setval(QString s){
    // Update or set a new QString for the next session
    time = s; // Replace with your actual QString
    settings.setValue("Timezone", time);
    qDebug() << "String stored for the next session:" <<time;
}

//return chosen timezone.
Q_INVOKABLE QString InitialCheck::returnval(){
    // Read the stored QString from the previous session
    time = settings.value("Timezone", time).toString();
    qDebug() << "String from the previous session:" << time;
    return time;
}

//checks if time variable is empty or non-empty.
Q_INVOKABLE bool InitialCheck::checktime(){
    time = settings.value("Timezone", time).toString();
    if(time!=""){
        qDebug()<<"checking time value "<<time;
        return false;
    }
    else{
        qDebug()<<"time is empty";
        return true;
    }
}

//clears language and timezone set variables to choose again.
Q_INVOKABLE void InitialCheck::reset(){
    time = ""; // Replace with your actual QString
    lang="";
    settings.setValue("Timezone", time);
    settings.setValue("Language", lang);
    qDebug() << "String stored for the next session time :" <<time;
    qDebug() << "String stored for the next session lang :" <<lang;
    qDebug()<<"reset done ";
}

//sets the chosen language to the variable.
Q_INVOKABLE void InitialCheck::setlang(QString s){
    // Update or set a new QString for the next session
    lang = s; // Replace with your actual QString
    settings.setValue("Language", lang);
    qDebug() << "String stored for the next session for language:" <<lang;
}

//return chosen language.
Q_INVOKABLE QString InitialCheck::returnlan(){
    lang = settings.value("Language", lang).toString();
    qDebug() << "String from the previous session:" << lang;
    return lang;
}







