#include "../service.h"
#include "../../utils/src/util_clock.ino"
#include "../../utils/src/util_irrigation.ino"
#include "../../utils/src/util_air_t_h_sensor.ino"

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
        STATUS = 0,
        SET_DATA = 1
    };

    /*
    URL path assigned to a specific endpoint.
    */
    String endpointPath(Endpoints endpoint)
    {
        switch (endpoint)
        {
        case STATUS:
            return "/status";
        case SET_DATA:
            return "/data";
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
        case STATUS:
            return HTTP_GET;
        case SET_DATA:
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
        case STATUS:
            return []()
            {
                server.send(200, "text/plain", "STATUS OK");
            };
        case SET_DATA:
            return []()
            {
                String body = server.arg("plain");
                StaticJsonDocument<1024> jsonBody;
                DeserializationError error = deserializeJson(jsonBody, body);
                if (error)
                {
                    server.send(400, "text/plain", "Failed to parse JSON");
                }
                if (jsonBody.containsKey("timeIso8601"))
                {
                    String timeIso8601 = jsonBody["timeIso8601"];
                    Serial.println("Received time: " + timeIso8601);
                    if (UtilClock::parseCurrentTimeIso8601(timeIso8601) != true)
                    {
                        server.send(400, "text/plain", "Invalid ISO 8601 time format");
                    }
                }
                else
                {
                    server.send(400, "text/plain", "Missing 'timeIso8601' key");
                }
                if (jsonBody.containsKey("irrigationRules"))
                {
                    JsonObject irrigationRules = jsonBody["irrigationRules"];
                    if (irrigationRules.containsKey("cycle_repeat_time"))
                    {
                        int cycleRepeatTime = irrigationRules["cycle_repeat_time"];
                        UtilIrrigation::cycleRepeatTime = cycleRepeatTime;
                        int cycleTimeOffsetMinutes = irrigationRules["cycle_time_offset_minutes"];
                        UtilIrrigation::cycleTimeOffsetMinutes = cycleTimeOffsetMinutes;
                        int cycleTimeSeconds = irrigationRules["cycle_time_seconds"];
                        UtilIrrigation::cycleTimeSeconds = cycleTimeSeconds;
                        int cyclePauseTimeSeconds = irrigationRules["pause_time_seconds"];
                        UtilIrrigation::cyclePauseTimeSeconds = cyclePauseTimeSeconds;
                        Serial.print("Received Irrigation Rules:\n");
                        Serial.print(String(cycleRepeatTime) + ":\n");
                        Serial.print(String(cycleTimeOffsetMinutes) + ":\n");
                        Serial.print(String(cycleTimeSeconds) + ":\n");
                        Serial.println(String(cyclePauseTimeSeconds));
                    }
                }
                server.send(
                    200,
                    "text/plain",
                    "{\"temperature\":\"" +
                        String(UtilAirTemperatureHumiditySensor::temperatureCelsius) +
                        "\", \"humidity\":\"" +
                        String(UtilAirTemperatureHumiditySensor::humidityPercent) +
                        "\"}");
            };
        }
    }

    /*
    Method implemented for handling root server address logic.

    Useful for testing if the WebServer.h service is functioning properly.
    */
    static void handleRootEndpoint()
    {
        server.send(200, "text/html", "OK");
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

        server.on("/", HTTP_GET, handleRootEndpoint);

        // Specify the server endpoint handling.
        for (int i = Endpoints::STATUS; i <= Endpoints::SET_DATA; ++i)
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

    void handleClient()
    {
        server.handleClient();
    }
};