#include "WiFi.h"
#include <ESPmDNS.h>
#include <WebServer.h>
#include <DS1302.h>
#include <ArduinoJson.h>
#include <DHT.h>
#include <cmath>
#include <time.h>

#include "services/src/service_server.ino"
#include "services/src/service_wifi.ino"
#include "utils/src/util_clock.ino"
#include "utils/src/util_irrigation.ino"
#include "utils/src/util_air_t_h_sensor.ino"

ServiceWifi *serviceWifi = new ServiceWifi();
ServiceServer *serviceServer = new ServiceServer();

UtilClock *utilClock = new UtilClock();
UtilIrrigation *utilIrrigation = new UtilIrrigation();
UtilAirTemperatureHumiditySensor *utilAirTHSensor = new UtilAirTemperatureHumiditySensor();

void setup() {
  Serial.begin(115200);

  serviceWifi->setup();
  serviceServer->setup();

  utilClock->setup();
  utilIrrigation->setup();
  utilAirTHSensor->setup();
}

void loop() {
  utilClock->updateTime();
  serviceWifi->ensureConnection();
  utilAirTHSensor->readAllSensors();
  serviceServer->handleClient();
  delay(1000);
}
