#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QTranslator>
#include <QQmlEngine>
#include <QQmlContext>
#include<initialcheck.h>

int main(int argc, char *argv[])
{

    QGuiApplication app(argc, argv);
    QCoreApplication::setOrganizationName("CodeWorld");
    QCoreApplication::setApplicationName("Multilingo");
    InitialCheck ch;//Creating Object
    if(ch.returnlan()=="Hindi"){
        auto translator = new QTranslator;
        // translator->load(":/i18n/main_hi" );
        if(translator->load(":/i18n/main_hi" ))
            app.installTranslator(translator);
        else qDebug()<<"error";
    }
    QQmlApplicationEngine engine;
     engine.rootContext()->setContextProperty("ch", &ch);//object variable to use anywhere in Qml.
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Delete", "Main");

    return app.exec();
}
