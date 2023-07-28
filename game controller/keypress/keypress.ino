#include "Mouse.h"
#include <Keyboard.h>
#define BUTTON_PIN 4
#define SPEED 0.8

int currentPos = 0;
int mouseY = 0;

void setup() {

  // open the serial port:

  Serial.begin(9600);
  pinMode(A0, INPUT);
  pinMode(BUTTON_PIN, INPUT_PULLUP);
  // initialize control over the keyboard:
  Keyboard.begin();
  Mouse.begin();
  delay(5000);
  currentPos = analogRead(A0);
}

void loop() {
  int newPos = analogRead(A0);
  int distance = (newPos - currentPos) * SPEED;
  Serial.println(newPos);
  Serial.println(mouseY);

  if (newPos < 130) {
    Mouse.move(0, -mouseY, 0);
    mouseY = 0;
  } else {
    Mouse.move(0, distance, 0);
    mouseY += distance;
    currentPos = newPos;
  }

  if (digitalRead(BUTTON_PIN) == 1) {
    Keyboard.press(KEY_RIGHT_ARROW);
  } else {
    Keyboard.releaseAll();
  }
}