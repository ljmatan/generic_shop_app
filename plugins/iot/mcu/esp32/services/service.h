#ifndef SERVICE_H
#define SERVICE_H

class Service
{
public:
    virtual void setup() = 0;

    virtual ~Service() {}
};

#endif