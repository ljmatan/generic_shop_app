#include "../util.h"

#ifndef UTIL_CLOCK
#define UTIL_CLOCK

/*
Utility methods and properties related to the time-keeping functionality of this ESP32 device.
*/
class UtilClock : public Util
{
private:
    /*
    Currently-available year information.
    */
    static inline int year = 0;

    /*
    Currently-available month information.
    */
    static inline int month = 0;

    /*
    Currently-available day information.
    */
    static inline int day = 0;

    /*
    Currently-available hour information.
    */
    static inline int hour = 0;

    /*
    Currently-available minute information.
    */
    static inline int minute = 0;

    /*
    Currently-available second information.
    */
    static inline int second = 0;

    /*
    Time in milliseconds which has passed since the first update.
    */
    static inline int msSinceFirstUpdate = 0;

    /*
    Time in milliseconds which has passed since the latest update.
    */
    static inline int msSinceLastUpdate = 0;

    /*
    The first hour of the day the service is allowed to run.
    */
    static inline int startTime = 10;

    /*
    Hour of the day after which the service is not allowed to run.
    */
    static inline int endTime = 18;

    /*
    Date type represented with a day of the month and the month number.
    */
    struct Date
    {
        int day;
        int month;
    };

    /*
    The dates on which the service is specified to not be running.
    */
    static inline Date daysOff[] = {
        {25, 12},
        {26, 12},
        {31, 12},
        {1, 1},
        {2, 1},
        {10, 5},
    };

    static

        /*
        Records the time information to the static variable instances.
        */
        void
        setTime(
            int yearValue,
            int monthValue,
            int dayValue,
            int hourValue,
            int minuteValue,
            int secondValue)
    {
        year = yearValue;
        month = monthValue;
        day = dayValue;
        hour = hourValue;
        minute = minuteValue;
        second = secondValue;
        msSinceFirstUpdate = 0;
        msSinceLastUpdate = 0;
    }

public:
    UtilClock() {}

    void setup() override
    {
        Serial.println("Waiting for clock information.");
    }

    /*
    Function to parse the ISO 8601 time string.
    */
    static bool parseCurrentTimeIso8601(String iso8601)
    {
        // Expected format: YYYY-MM-DDTHH:MM:SSZ
        if (iso8601.length() < 20)
        {
            Serial.println("ISO time length must be at least 20 characters.");
            return false;
        }

        // Extract each part using substrings
        int yearValue = iso8601.substring(0, 4).toInt();
        int monthValue = iso8601.substring(5, 7).toInt();
        int dayValue = iso8601.substring(8, 10).toInt();
        int hourValue = iso8601.substring(11, 13).toInt();
        int minuteValue = iso8601.substring(14, 16).toInt();
        int secondValue = iso8601.substring(17, 19).toInt();

        if (yearValue < 2000)
        {
            Serial.println("Year less than 2000.");
            return false;
        }

        if (monthValue < 1)
        {
            Serial.println("Negative months.");
            return false;
        }

        if (monthValue > 12)
        {
            Serial.println("More than 12 months.");
            return false;
        }

        if (dayValue < 1)
        {
            Serial.println("Negative days.");
            return false;
        }

        if (dayValue > 31)
        {
            Serial.println("More than 31 days.");
            return false;
        }

        if (hourValue < 0)
        {
            Serial.println("Negative hours.");
            return false;
        }

        if (hourValue > 23)
        {
            Serial.println("More than 23 hours.");
            return false;
        }

        if (minuteValue < 0)
        {
            Serial.println("Negative minutes.");
            return false;
        }

        if (minuteValue > 59)
        {
            Serial.println("More than 59 minutes.");
            return false;
        }

        if (secondValue < 0)
        {
            Serial.println("Negative seconds.");
            return false;
        }

        if (secondValue > 59)
        {
            Serial.println("More than 59 seconds.");
            return false;
        }

        setTime(yearValue, monthValue, dayValue, hourValue, minuteValue, secondValue);

        // If the string was valid and parsing succeeded, return true
        return true;
    }

    /*
    Utilising the ESP32 RTOS features, a parallel task is defined
    which increments the recorded time values.
    */
    void updateTime()
    {
        // Ensures that the ESP32 device received the time information at some point.
        if (year != 0)
        {
            if (millis() - msSinceLastUpdate >= 1000)
            {
                msSinceLastUpdate = millis();

                // Get current time from the NTP server or system time.
                time_t now;
                struct tm timeinfo;
                time(&now);
                localtime_r(&now, &timeinfo); // Converts time to struct tm format.

                // Calculate milliseconds since epoch.
                msSinceFirstUpdate = now * 1000 + (millis() % 1000); // Adding the ms component.

                // Print the epoch time.
                Serial.print("Milliseconds since epoch: ");
                Serial.println(msSinceFirstUpdate);

                // Convert to a human-readable format.
                year = timeinfo.tm_year + 1900; // tm_year gives years since 1900.
                month = timeinfo.tm_mon + 1;    // tm_mon gives month (0-11).
                day = timeinfo.tm_mday;         // Day of the month.
                hour = timeinfo.tm_hour;        // Hour (0-23).
                minute = timeinfo.tm_min;       // Minute (0-59).
                second = timeinfo.tm_sec;       // Second (0-59).

                // Print human-readable date and time
                Serial.print("Time: ");
                Serial.print(year);
                Serial.print("-");
                Serial.print(month);
                Serial.print("-");
                Serial.print(day);
                Serial.print(" ");
                Serial.print(hour);
                Serial.print(":");
                Serial.print(minute);
                Serial.print(":");
                Serial.print(second);
                Serial.println();
            }
        }
        else
        {
            Serial.println("No date and time information available.");
        }
    }

    /*
    Method which checks the current time to verify if the irrigation service is currently enabled,
    and returns the status result.
    */
    bool isIrrigationAllowed()
    {
        // Check whether today's date is recorded as a day off.
        for (int i = 0; i < sizeof(daysOff) / sizeof(daysOff[0]); i++)
        {
            if (daysOff[i].day == day && daysOff[i].month == month)
            {
                return false;
            }
        }
        // Service is allowed to run in between these specified hours.
        return hour >= startTime && hour < endTime;
    }
};

#endif