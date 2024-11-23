#include "../util.h"

/*
Methods and properties defined in order to handle the DS1302 clock module.

For further information, please see:

- https://www.velleman.eu/products/view/?id=435516&lang=en
*/
class UtilClock : public Util
{
private:
    /*
    Number of the pin connected to the DS1302 CE / EN / RST pins.
    */
    static constexpr const int pinEnable = 13;

    /*
    Number of the pin connected to the DS1302 DAT / IO pins.
    */
    static constexpr const int pinData = 12;

    /*
    Number of the pin connected to the DS1302 SCLK / CLK pins.
    */
    static constexpr const int pinClock = 14;

    /*
    Real time clock module support implemented by the DS1302.h library.
    */
    static inline DS1302 rtc{pinEnable, pinData, pinClock};

public:
    UtilClock() {}

    /*
    Returns the human-readable day information from the [Time::Day] object.
    */
    String dayAsString(const Time::Day day)
    {
        switch (day)
        {
        case Time::kSunday:
            return "Sunday";
        case Time::kMonday:
            return "Monday";
        case Time::kTuesday:
            return "Tuesday";
        case Time::kWednesday:
            return "Wednesday";
        case Time::kThursday:
            return "Thursday";
        case Time::kFriday:
            return "Friday";
        case Time::kSaturday:
            return "Saturday";
        }
        return "(unknown day)";
    }

    /*
    Outputs the current time to the console.
    */
    void printTime()
    {
        Time t = rtc.time();
        const String day = dayAsString(t.day);
        // Format the time and date and insert into the temporary buffer.
        char buf[50];
        snprintf(buf, sizeof(buf), "%s %04d-%02d-%02d %02d:%02d:%02d",
                 day.c_str(),
                 t.yr, t.mon, t.date, t.hr, t.min, t.sec);
        Serial.println(buf);
    }

    void setup() override
    {
        Serial.println("Initialising DS1302 clock module.");
        rtc.writeProtect(false);
        rtc.halt(false);
        Serial.println("Clock module initialised.");
        printTime();
    }
};