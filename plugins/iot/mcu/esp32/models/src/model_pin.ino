
/*
Development board GPIO pin definition.
*/
class MfaPin
{
private:
    /*
     */
    int pinNumber;

    /*
     */
    bool analog;

    /*
     */
    bool input;

public:
    /*
     */
    MfaPin(
        int number,
        bool isAnalog = false,
        bool isInput = false)
        : pinNumber(number),
          analog(isAnalog),
          input(isInput)
    {
        if (input)
        {
            pinMode(number, isAnalog ? INPUT : INPUT_PULLUP);
        }
        else
        {
            pinMode(number, OUTPUT);
        }
    }

    void write(int value)
    {
        if (input)
        {
            Serial.println("Error: Attempt to write to input pin: " + String(pinNumber));
            return;
        }
        if (analog)
        {
            analogWrite(pinNumber, value);
        }
        else
        {
            digitalWrite(pinNumber, value);
        }
    }

    int read()
    {
        if (!input)
        {
            Serial.println("Error: Attempt to read from output pin: " + String(pinNumber));
            return -1;
        }
        if (analog)
        {
            return analogRead(pinNumber);
        }
        else
        {
            return digitalRead(pinNumber);
        }
    }
};