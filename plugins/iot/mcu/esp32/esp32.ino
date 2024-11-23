#include "WiFi.h"

#include "services/service.h"
#include "services/src/service_server.ino"
#include "services/src/service_wifi.ino"
#include "utils/util.h"
#include "utils/src/util_irrigation.ino"
#include "utils/src/util_lightning.ino"
#include "utils/src/util_sensors.ino"
#include "models/model.h"
#include "models/src/model_pin.ino"

ServiceWifi *serviceWifi = new ServiceWifi();
ServiceServer *serviceServer = new ServiceServer();

void setup()
{
  Serial.begin(115200);
  serviceWifi->setup();
  serviceServer->setup();
}

void loop()
{
  serviceWifi->ensureConnection();
  serviceServer->handleClients();
}
