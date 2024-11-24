#include "../util.h"

class UtilClock : public Util
{
private:
    static constexpr const int msSinceEpoch = 0;

public:
    UtilClock() {}

    void setup() override
    {
        Serial.println("Waiting for clock information.");
    }
};