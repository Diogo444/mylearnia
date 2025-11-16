#include <Wire.h>
#include <LiquidCrystal_I2C.h>

// Adresse I2C (souvent 0x27 ou 0x3F, ça dépend du module)
LiquidCrystal_I2C lcd(0x27, 16, 2);

void setup() {
  lcd.init();        // Initialisation
  lcd.backlight();   // Allume le rétroéclairage
  lcd.setCursor(0,0); 
  lcd.print("Hello, World!");
}

void loop() {
  // Rien à faire ici pour l'instant
}
