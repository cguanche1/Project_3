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

float r = 0;
float g = 0;
float b = 0;
float a = 0;
  
float w, h; //some value between 1 and 10

void setup(){
  udp= new UDP(this, PORT_RX, HOST_IP);
  udp.log(true);
  udp.listen(true);
  
  background(0,0,0);
  //fullScreen();
  size(400,400);
  noLoop();
}

void draw(){
  
} 

void receive(byte[] data, String HOST_IP, int PORT_RX){
 
  if(x == width || x == 0){
   x_adder = -1 * x_adder;
  }
  x = x + x_adder;
  
  String value=new String(data);
  String[] values = split(value,' ');
  
  for(int i = 0; i < values.length - 1; i++){
   print(values[i] + " " );
   currents[i][0] = float(values[i]);
   if(currents[i][0] > currents[i][1]){

     currents[i][1] = currents[i][0];
   }
   if(currents[i][0] < currents[i][2]){
     currents[i][2] = currents[i][0];
   }
  }
  
  Pe = float(values[6]);
  print(values[6] + " " + x + "\n");
  
  float rangeW1 = abs(currents[0][1] - currents[0][2]);
  float rangeW2 = abs(currents[1][1] - currents[1][2]);
  
  w = (currents[0][0]/rangeW1) * 10;
  h = (currents[1][0]/rangeW2) * height;
  
  if(Pe == 1.0){
    r = random(1,255);
    g = random(1,255);
    b = random(1,255);
    a = random(1,255);
  }
  else{
   float rangeR = abs(currents[3][1] - currents[3][2]);
   float rangeG = abs(currents[5][1] - currents[5][2]); 
   float rangeB = abs(currents[4][1] - currents[4][2]);
   float rangeA = abs(currents[2][1] - currents[2][2]);
   print(rangeR + " " + rangeG + " " + rangeB + " " + rangeA + " " + rangeW1 + " "+ rangeW2+"\n");
   
   if(rangeR != 0){
     r = ((currents[3][0] / rangeR) * 255)%255;
   }
   else{
     r = 127;
   }
   
   if(rangeG != 0){
     b = ((currents[5][0] / rangeG) * 255)%255;
   }
   else{
    b = 127; 
   }
   
   if(rangeB != 0){
     a = ((currents[4][0] / rangeB) * 255)%255;
   }
   else{
    a = 127; 
   }
   
   if(rangeA != 0){
     b = ((currents[2][0] / rangeA) * 255)%255;
   }
   else{
     b = 127;
   }
  }
  
  
  //line(x,0,x,h);
  
  
  //fill(255-r,255-g,255-b,255-a);
  //stroke(255-r,255-g,255-b,255-a);
  //line(x,h,x,height);
  
  print(r + " " + g + " " + b + " " + a+ " " + h+ " " + w+ "\n");
  
  
  fill(r,g,b,a);
  stroke(r,g,b,a);
  rect(0,0,width,height);
  //udp.listen(true);
  
  //draw();
}
