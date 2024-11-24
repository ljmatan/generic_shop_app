#include "../util.h"

class UtilAirTemperatureHumiditySensor : public Util
{
private:
    /*
    Number of the pin connected to the DHT11 data pin.
    */
    static constexpr const int pinSensor0 = 19;

    /*
    Number of the pin connected to the DHT11 data pin.
    */
    static constexpr const int pinSensor1 = 18;

    /*
    Number of the pin connected to the DHT11 data pin.
    */
    static constexpr const int pinSensor2 = 5;

    /*
    One of the 3 available DHT11 sensors connected to the ESP32 device.
    */
    static inline DHT sensor0{pinSensor0, DHT11};

    /*
    One of the 3 available DHT11 sensors connected to the ESP32 device.
    */
    static inline DHT sensor1{pinSensor1, DHT11};

    /*
    One of the 3 available DHT11 sensors connected to the ESP32 device.
    */
    static inline DHT sensor2{pinSensor2, DHT11};

    // Function to read a single sensor
    bool readSensor(DHT &sensor, float &temp, float &hum)
    {
        temp = sensor.readTemperature();
        hum = sensor.readHumidity();

        // Check if readings are valid
        if (isnan(temp) || isnan(hum))
        {
            Serial.println("Temperature is " + String(isnan(temp) ? "" : "not ") + "null");
            Serial.println("Humidity is " + String(isnan(hum) ? "" : "not ") + "null");
            return false; // Sensor failed
        }
        // Verify ranges for DHT11
        if (temp < 0 || temp > 50 || hum < 20 || hum > 90)
        {
            Serial.println("False temp: " + String(temp));
            Serial.println("False humidity: " + String(hum));
            return false; // Invalid data
        }
        return true;
    }

public:
    UtilAirTemperatureHumiditySensor() {}

    void setup() override
    {
        pinMode(pinSensor0, INPUT);
        pinMode(pinSensor1, INPUT);
        pinMode(pinSensor2, INPUT);
        sensor0.begin();
        sensor1.begin();
        sensor2.begin();
    }

    /*
    Globally-accessible latest-recorded temperature value.
    */
    static int temperatureCelsius;

    /*
    Globally-accessible latest-recorded humidity value.
    */
    static int humidityPercent;

    /*
    Reads all sensors and calculates the average value.
    */
    void readAllSensors()
    {
        float temp1, hum1, temp2, hum2, temp3, hum3;
        int validSensors = 0;

        // Variables to store valid readings
        float sumTemp = 0;
        float sumHum = 0;

        // Read each sensor and collect valid data
        if (readSensor(sensor0, temp1, hum1))
        {
            sumTemp += temp1;
            sumHum += hum1;
            validSensors++;
        }
        else
        {
            Serial.println("Sensor 1 failed or gave invalid data.");
        }

        if (readSensor(sensor1, temp2, hum2))
        {
            sumTemp += temp2;
            sumHum += hum2;
            validSensors++;
        }
        else
        {
            Serial.println("Sensor 2 failed or gave invalid data.");
        }

        if (readSensor(sensor2, temp3, hum3))
        {
            sumTemp += temp3;
            sumHum += hum3;
            validSensors++;
        }
        else
        {
            Serial.println("Sensor 3 failed or gave invalid data.");
        }

        // Calculate averages if valid data is available
        if (validSensors > 0)
        {
            float avgTemp = sumTemp / validSensors;
            float avgHum = sumHum / validSensors;
            temperatureCelsius = avgTemp;
            humidityPercent = avgHum;
            Serial.print("Average Temperature: ");
            Serial.print(avgTemp);
            Serial.println(" °C");
            Serial.print("Average Humidity: ");
            Serial.print(avgHum);
            Serial.println(" %");
        }
        else
        {
            Serial.println("All sensors failed or provided invalid data!");
        }
    }
};