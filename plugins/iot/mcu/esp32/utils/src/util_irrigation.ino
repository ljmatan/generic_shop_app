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

public:
    UtilIrrigation() {}

    void powerOn()
    {
        digitalWrite(pinPowerPaintGun, HIGH);
        digitalWrite(pinPowerPaintGunPump, HIGH);
    }

    void powerOff()
    {
        digitalWrite(pinPowerPaintGun, LOW);
        digitalWrite(pinPowerPaintGunPump, LOW);
    }

    void setup() override
    {
        pinMode(pinPowerPaintGun, OUTPUT);
        pinMode(pinPowerPaintGunPump, OUTPUT);
        powerOn();
        // Leave the devices powered on for 10 seconds, the short pause.
        delay(10000);
        powerOff();
        delay(3000);
    }

    void cycle()
    {
        for (int i = 0; i < 2; i++)
        {
            powerOn();
            delay(30000);
            powerOff();
            delay(30000);
        }
    }
};