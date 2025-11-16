#include <WiFi.h>
#include <ESP32_MySQL.h>
#include <map>

// ===========================
// ⚙️ CONFIG
// ===========================
#define ESP32_MYSQL_DEBUG_PORT Serial
#define _ESP32_MYSQL_LOGLEVEL_ 1

// Wi-Fi
const char* WIFI_SSID = "Pasteis de nata";
const char* WIFI_PASS = "password";

// MySQL
IPAddress DB_SERVER(10, 143, 110, 61);
uint16_t  DB_PORT = 3306;
char DB_USER[] = "root";
char DB_PASS[] = "root";
char DB_NAME[] = "projet_guichet";

// ===========================
// 🔧 OBJETS GLOBAUX
// (⚠️ NE PAS redéclarer WiFiClient client; la lib le fait déjà)
// ===========================
ESP32_MySQL_Connection conn((Client*)&client);   // 'client' vient de la lib
ESP32_MySQL_Query sql_query(&conn);
std::map<String, String> latestResult;

// ===========================
// 🧩 FONCTIONS
// ===========================

void connectWiFi() {
  Serial.println("\n=== [WIFI] Connexion... ===");
  WiFi.begin(WIFI_SSID, WIFI_PASS);
  int tries = 0;
  while (WiFi.status() != WL_CONNECTED && tries < 40) {
    delay(500);
    Serial.print(".");
    tries++;
  }

  if (WiFi.status() == WL_CONNECTED) {
    Serial.println("\n✅ Wi-Fi OK");
    Serial.print("IP : ");
    Serial.println(WiFi.localIP());
  } else {
    Serial.println("\n❌ Wi-Fi KO");
  }
}

bool connectMySQL() {
  Serial.println("\n=== [MYSQL] Connexion au serveur... ===");
  // la lib veut des char* pas des const char*
  Connection_Result res = conn.connectNonBlocking(DB_SERVER, DB_PORT, DB_USER, DB_PASS, DB_NAME);
  if (res == RESULT_FAIL) {
    Serial.println("❌ Connexion MySQL échouée");
    return false;
  }
  Serial.println("✅ MySQL connecté");
  return true;
}

// petite fonction générique pour exécuter et afficher
void execQuery(const String &sql) {
  Serial.println("\n📝 Requête : " + sql);

  if (!sql_query.execute(sql.c_str())) {
    Serial.println("❌ Erreur d'exécution");
    return;
  }

  column_names* cols = sql_query.get_columns();
  row_values* row = nullptr;
  int rowNum = 0;

  while ((row = sql_query.get_next_row()) != nullptr) {
    rowNum++;
    Serial.print("🔹 Ligne ");
    Serial.println(rowNum);
    for (int i = 0; i < cols->num_fields; i++) {
      Serial.print("  ");
      Serial.print(cols->fields[i]->name);
      Serial.print(" : ");
      Serial.println(row->values[i]);
      // stockage dernier résultat si tu veux le réutiliser
      latestResult[cols->fields[i]->name] = row->values[i];
    }
  }

  if (rowNum == 0) {
    Serial.println("⚠️ Aucun résultat");
  }
}

// ===========================
// 🚀 SETUP / LOOP
// ===========================
void setup() {
  Serial.begin(115200);
  delay(1000);
  Serial.println("\n=== DEMARRAGE ESP32 ===");
  connectWiFi();
}

void loop() {
  if (WiFi.status() == WL_CONNECTED) {
    if (connectMySQL()) {

      // 1) combien de clients ?
      execQuery("SELECT COUNT(*) AS total_clients FROM clients;");

      // 2) premiers produits
      execQuery("SELECT id_produit, nom_produit FROM produits LIMIT 5;");

      // 3) modes de paiement
      execQuery("SELECT id_mode, libelle_mode FROM mode_paiement LIMIT 5;");

      conn.close();
      Serial.println("🔚 Connexion MySQL fermée");
    }
  } else {
    Serial.println("⚠️ Wi-Fi perdu → reconnexion");
    connectWiFi();
  }

  Serial.println("\n⏳ On attend 15s puis on refait");
  Serial.println("====================================");
  delay(15000);
}
