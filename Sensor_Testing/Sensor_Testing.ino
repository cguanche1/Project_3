void setup() {
  // put your setup code here, to run once:

  pinMode(33,INPUT);
  pinMode(32,INPUT);

  Serial.begin(9600);

}

void loop() {
  // put your main code here, to run repeatedly:

  float x = analogRead(33);
  float y = analogRead(32);

  Serial.print("x: " + String(x) + " y: " + String(y) + "\n");
}
