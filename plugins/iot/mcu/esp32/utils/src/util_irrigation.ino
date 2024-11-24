#include "../util.h"

class UtilIrrigation : public Util
{
private:
    /*
    Number of the pin connected to the paint gun relay.
    */
    static constexpr const int pinPowerPaintGun = 27;

    /*
    Number of the pin connected to the paint gun pump relay.
    */
    static constexpr const int pinPowerPaintGunPump = 26;

    /*
    Activates the relay controlling the irrigation devices.
    */
    void powerOn()
    {
        digitalWrite(pinPowerPaintGun, HIGH);
        digitalWrite(pinPowerPaintGunPump, HIGH);
    }

    /*
    Powers off the relay controlling the irrigation devices.
    */
    void powerOff()
    {
        digitalWrite(pinPowerPaintGun, LOW);
        digitalWrite(pinPowerPaintGunPump, LOW);
    }

public:
    UtilIrrigation() {}

    void setup() override
    {
        Serial.println("Initialising irrigation system.");
        pinMode(pinPowerPaintGun, OUTPUT);
        pinMode(pinPowerPaintGunPump, OUTPUT);
        Serial.println("Powering on the irrigation system.");
        powerOn();
        // Leave the devices powered on for 10 seconds, then commence a short pause.
        delay(5000);
        Serial.println("Powering off the irrigation system.");
        powerOff();
        delay(2000);
        Serial.println("Irrigation initialisation complete.");
    }

    /*
    Activates the irrigation cycle process.

    The system is powered on for the specified duration,
    with pauses in the specified duration.
    */
    void cycle()
    {
        for (int i = 0; i < 2; i++)
        {
            Serial.println("Cycling the irrigation system.");
            powerOn();
            delay(30000);
            Serial.println("Cycle " + String(i) + " complete.");
            powerOff();
            delay(30000);
            Serial.println("Cycle " + String(i) + " end.");
        }
    }
};