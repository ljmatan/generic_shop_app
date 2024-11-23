#include "../service.h"

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
    static inline WebServer server{80};

    /*
    The name of the ESP32 device on the local network.
    */
    static constexpr const char *hostname = "giotesp32";

    /*
    The endpoints defined for this server.
    */
    enum Endpoints
    {
        ROOT = 0,
        STATUS = 1,
        SET_IRRIGATION_CYCLE_TIME = 2
    };

    /*
    URL path assigned to a specific endpoint.
    */
    String endpointPath(Endpoints endpoint)
    {
        switch (endpoint)
        {
        case ROOT:
            return "/";
        case STATUS:
            return "/status";
        case SET_IRRIGATION_CYCLE_TIME:
            return "/irrigation/cycle-time";
        }
    }

    /*
    The type of the HTTP request handled by a specific endpoint.
    */
    HTTPMethod
    endpointType(Endpoints endpoint)
    {
        switch (endpoint)
        {
        case ROOT:
            return HTTP_GET;
        case STATUS:
            return HTTP_GET;
        case SET_IRRIGATION_CYCLE_TIME:
            return HTTP_POST;
        }
    }

    /*
    Defines the method used for handling a specific endpoint.
    */
    std::function<void()> handleEndpoint(Endpoints endpoint)
    {
        switch (endpoint)
        {
        case ROOT:
            return []()
            {
                server.send(200, "text/plain", "OK");
            };
        case STATUS:
            return []()
            {
                server.send(200, "text/plain", "STATUS OK");
            };
        case SET_IRRIGATION_CYCLE_TIME:
            return []() {

            };
        }
    }

public:
    /*
    Public class constructor,
    may be initialised from any point in the program.
    */
    ServiceServer() {}

    void setup() override
    {
        // Set the device hostname.
        if (MDNS.begin(hostname))
        {
            Serial.println("MDNS responder started");
        }
        else
        {
            Serial.println("Error starting mDNS");
        }
        if (!WiFi.setHostname(hostname))
        {
            Serial.println("Failed to set hostname!");
        }
        else
        {
            Serial.println("Hostname set to: " + String(hostname));
        }

        // Specify the server endpoint handling.
        for (int i = Endpoints::ROOT; i <= Endpoints::STATUS; ++i)
        {
            Endpoints endpoint = static_cast<Endpoints>(i);
            server.on(
                endpointPath(endpoint),
                endpointType(endpoint),
                handleEndpoint(endpoint));
        }

        // Start the web server service.
        server.begin();
        Serial.println("Web server started.");
    }
};