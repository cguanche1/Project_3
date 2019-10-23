import hypermedia.net.*;

int PORT_RX=57222;
String HOST_IP = "192.168.1.2";//IP Address of the PC in which this App is running
UDP udp;//Create UDP object for recieving

float Fb_max = 0;
float Fb_min = 5000;

float Ft_max = 0;
float Ft_min = 5000;

float Pba_max = 0;
float Pba_min = 5000;

float Pr_max = 0;
float Pr_min = 5000;

float Pbu_max = 0;
float Pbu_min = 5000;

float Pg_max = 0;
float Pg_min = 5000;

float Fb, Ft, Pba, Pr, Pbu, Pg, Pe;
float[][] currents = {{Fb, Fb_max, Fb_min}, {Ft, Ft_max, Ft_min},
  {Pba, Pba_max, Pba_min}, {Pr, Pr_max, Pr_min}, {Pbu, Pbu_max, Pbu_min},
  {Pg, Pg_max, Pg_min}};

float x = 1;
int x_adder = 1;

void setup(){
  udp= new UDP(this, PORT_RX, HOST_IP);
  udp.log(true);
  udp.listen(true);
  
  noLoop();
}

void draw(){
  
} 

void receive(byte[] data, String HOST_IP, int PORT_RX){
 
  String value=new String(data);
  String[] values = split(value,' ');
  
  for(int i = 0; i < values.length; i++){
   print(values[i] + " " );
   currents[i][0] = float(values[i]);
   if(currents[i][0] > currents[i][1]){
     currents[i][1] = currents[i][0];
   }
   if(currents[i][0] < currents[i][2]){
     currents[i][2] = currents[i][0];
   }
  }
  print("\n");
  
  if(x == width || x == 0){
   x_adder = -1 * x_adder;
  }
  x += x_adder;
  
  analyze();
}

void analyze(){
  
}
