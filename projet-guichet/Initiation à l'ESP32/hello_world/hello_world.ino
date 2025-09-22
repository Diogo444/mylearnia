void setup() {
  // Initialisation de la communication série à 115200 bauds
  Serial.begin(115200);

  // Envoi d’un message de test
  Serial.println("Hello, World depuis ESP32 !");
}

void loop() {
  // Petit délai pour éviter le flood
  delay(1000);
}
