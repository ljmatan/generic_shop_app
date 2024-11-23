#include "WiFi.h"
#include <ESPmDNS.h>
#include <WebServer.h>
#include <DS1302.h>
#include <ArduinoJson.h> 

#include "services/src/service_server.ino"
#include "services/src/service_wifi.ino"
#include "utils/src/util_clock.ino"
#include "utils/src/util_irrigation.ino"

ServiceWifi *serviceWifi = new ServiceWifi();
ServiceServer *serviceServer = new ServiceServer();

UtilClock *utilClock = new UtilClock();
UtilIrrigation *utilIrrigation = new UtilIrrigation();

void setup()
{
  Serial.begin(115200);

  serviceWifi->setup();
  serviceServer->setup();

  utilClock->setup();
  utilIrrigation->setup();
}

void loop()
{
  serviceWifi->ensureConnection();
}
