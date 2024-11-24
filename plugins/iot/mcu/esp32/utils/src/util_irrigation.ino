#include "../util.h"

#ifndef UTIL_IRRIGATION
#define UTIL_IRRIGATION

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
    The number of times the irrigaton cycle is set to run consecutively.

    This value should be set with an API call via the controlling device.

    If the value is 0, the irrigation functionality will not run
    until a different value is specified.
    */
    static inline int cycleRepeatTime = 0;

    /*
    The specified amount of time between the irrigation cycles.

    If the value is 0, the irrigation functionality is not specified.
    */
    static inline int cycleTimeOffsetMinutes = 0;

    /*
    The specified runtime duration of the irrigation functionality, in seconds.
    */
    static inline int cycleTimeSeconds = 0;

    /*
    The specified pause between service cycle runtimes.
    */
    static inline int cyclePauseTimeSeconds = 0;

    /*
    Activates the irrigation cycle process.

    The system is powered on for the specified duration,
    with pauses in the specified duration.
    */
    void cycle()
    {
        for (int i = 0; i < cycleRepeatTime; i++)
        {
            Serial.println("Cycling the irrigation system.");
            powerOn();
            delay(cycleTimeSeconds * 1000);
            Serial.println("Cycle " + String(i) + " complete.");
            powerOff();
            delay(cyclePauseTimeSeconds * 1000);
            Serial.println("Cycle " + String(i) + " end.");
        }
    }
};

#endif