class ServiceWifi : public Service
{
private:
    /*
    WiFi connection SSID / network name.
    */
    static constexpr const char *ssid = "gsap_iot";

    /*
    Wifi connection authentication password.
    */
    static constexpr const char *password = "gsap1234";

public:
    ServiceWifi() {}

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

    void ensureConnection()
    {
        if (WiFi.status() != WL_CONNECTED)
        {
            Serial.println("Wi-Fi lost. Reconnecting...");
            connectToWiFi();
        }
    }
};
