/*
Web server running on this ESP32 device.

It's primary use is to handle and process HTTP network requests
in order to interface with the attached modules.
*/
class ServiceServer : public Service
{
private:
    /*
    Server services processor instance, subscribed to port 80.
    */
    static inline WiFiServer server{80};

    /*
    The name of the ESP32 device on the local network.
    */
    static constexpr const char *hostname = "gsap_esp32";

public:
    /*
    Public class constructor,
    may be initialised from any point in the program.
    */
    ServiceServer() {}

    void setup() override
    {
        if (!WiFi.setHostname(hostname))
        {
            Serial.println("Failed to set hostname!");
        }
        else
        {
            Serial.println("Hostname set to: " + String(hostname));
        }

        server.begin();
        Serial.println("Web server started.");
    }

    /*

    */
    void handleClients()
    {
        WiFiClient client = server.available();
        if (client)
        {
            Serial.println("New Client Connected.");
            String request = client.readStringUntil('\r');
            Serial.println("Request: " + request);
            client.flush();

            client.println("HTTP/1.1 200 OK");
            client.println("Content-Type: text/plain");
            client.println("Connection: close");
            client.println();
            client.println("ESP32 Web Server is running!");
            client.stop();
            Serial.println("Client disconnected.");
        }
    }
};