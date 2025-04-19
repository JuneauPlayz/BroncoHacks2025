#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_ADXL345_U.h>

Adafruit_ADXL345_Unified accel = Adafruit_ADXL345_Unified();

String condV = "stand";
String condH = "neuteral";
double vertical;
double z;

void setup(void)
{
    Serial.begin(9600);
    if (!accel.begin())
    {
        Serial.println("No ADXL345 sensor detected.");
        while (1)
            ;
    }
    accel.setRange(ADXL345_RANGE_8_G);
}
void loop(void)
{
    sensors_event_t event;
    accel.getEvent(&event);
    vertical = sqrt(sq(event.acceleration.y) + sq(event.acceleration.z)) / 9.8;
    z = event.acceleration.z / 9.8;
    //  Serial.print(millis());
    //  Serial.print(",");
    //  Serial.print(vertical);
    //  Serial.print(",");
    //  Serial.println(z);

    if (z > 0.6)
    {
        condH = "foward";
        Serial.print(condH);
    }
    else if (z < -.3)
    {
        condH = "backward";
        Serial.print(condH);
    }
    else
    {
        condH = "neuteral";
        Serial.print(condH);
    }

    Serial.print(",");
    if (vertical < 0.5)
    {
        delay(100);
    }
    if (vertical < 0.35)
    {
        condV = "crouch";
        Serial.println(condV);
        delay(1000);
    }
    else if (vertical > 2.3)
    {
        condV = "jump";
        Serial.println(condV);
        delay(600);
        condV = "stand";
    }
    else if (condV == "crouch" && vertical > 1.3)
    {
        condV = "stand";
        Serial.print(condV);
        delay(1000);
    }
    else
    {
        Serial.println(condV);
    }
}