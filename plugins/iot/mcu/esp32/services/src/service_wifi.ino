#include "../service.h"

class ServiceWifi : public Service
{
private:
    /*
    WiFi connection SSID / network name.
    */
    static constexpr const char *ssid = "gsa_iot";

    /*
    Wifi connection authentication password.
    */
    static constexpr const char *password = "gsaiot1234";

public:
    ServiceWifi() {}

    /*
    Tries connecting to the WiFi connection with specified [ssid] and [password] values.
    */
    void connectToWiFi()
    {
        // Try establishing a WiFi connection.
        Serial.print("Connecting to WiFi...");
        WiFi.begin(ssid, password);

        // Delay further program execution until connected.
        while (WiFi.status() != WL_CONNECTED)
        {
            delay(1000);
            Serial.print(".");
        }

        Serial.println("\nWiFi connected.");
        Serial.print("IP Address: ");
        Serial.println(WiFi.localIP());
    }

    void setup() override
    {
        connectToWiFi();
    }

    /*
    Checks the current connection and tries reconnecting in case of no connection.
    */
    void ensureConnection()
    {
        if (WiFi.status() != WL_CONNECTED)
        {
            Serial.println("Wi-Fi lost. Reconnecting...");
            connectToWiFi();
        }
    }
};
