#ifndef INITIALCHECK_H
#define INITIALCHECK_H
#include<QObject>
#include<QSettings>
class InitialCheck: public QObject
{
    Q_OBJECT
public:
    InitialCheck();
    Q_INVOKABLE QString returnval();//return chosen timezone.
    Q_INVOKABLE QString returnlan();//return chosen language.
    Q_INVOKABLE void setval(QString);//sets the chosen timezone to the variable.
    Q_INVOKABLE bool checktime();//checks if time variable is empty or non-empty.
    Q_INVOKABLE void reset();//clears language and timezone set variables to choose again.
    Q_INVOKABLE void setlang(QString);//sets the chosen language to the variable.
private:
    QSettings settings;
    QString time;
    QString lang;
    QString currentval;
};

#endif // INITIALCHECK_H
