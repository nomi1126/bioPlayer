//Graph MyArduinoGraph = new Graph(150, 80, 500, 300, color (200, 20, 20));
//float[] gestureOne=null;
//float[] gestureTwo = null;
//float[] gestureThree = null;
//
//float[][] gesturePoints = new float[4][2];
//float[] gestureDist = new float[4];
//String[] names = {"Nothing", "Touch", "Grab","In water"};
//void setup() {
//
//  size(1000, 500); 
//
//  MyArduinoGraph.xLabel="Readnumber";
//  MyArduinoGraph.yLabel="Amp";
//  MyArduinoGraph.Title=" Graph";  
//  noLoop();
//  PortSelected=7;      /* ====================================================================
//   adjust this (0,1,2...) until the correct port is selected 
//   In my case 2 for COM4, after I look at the Serial.list() string 
//   println( Serial.list() );
//   [0] "COM1"  
//   [1] "COM2" 
//   [2] "COM4"
//   ==================================================================== */
//  SerialPortSetup();      // speed of 115200 bps etc.
//}
//
//
//void draw() {
//
//  background(255);
//
//  /* ====================================================================
//   Print the graph
//   ====================================================================  */
//
//  if ( DataRecieved3 ) {
//    pushMatrix();
//    pushStyle();
//    MyArduinoGraph.yMax=300;      
//    MyArduinoGraph.yMin=-10;      
//    MyArduinoGraph.xMax=int (max(Time3));
//    MyArduinoGraph.DrawAxis();    
//    MyArduinoGraph.smoothLine(Time3, Voltage3);
//    popStyle();
//    popMatrix();
//
//    float gestureOneDiff =0;
//    float gestureTwoDiff =0;
//    float gestureThreeDiff =0;
//
//    /* ====================================================================
//     Gesture compare
//     ====================================================================  */
//    float totalDist = 0;
//    int currentMax = 0;
//    float currentMaxValue = -1;
//    for (int i = 0; i < 4;i++)
//
//    {
//
//      //  gesturePoints[i][0] = 
//      if (mousePressed && mouseX > 750 && mouseX<800 && mouseY > 100*(i+1) && mouseY < 100*(i+1) + 50)
//      {
//        fill(255, 0, 0);
//
//        gesturePoints[i][0] = Time3[MyArduinoGraph.maxI];
//        gesturePoints[i][1] = Voltage3[MyArduinoGraph.maxI];
//      }
//      else
//      {
//        fill(255, 255, 255);
//      }
//
//   //calucalte individual dist
//      gestureDist[i] = dist(Time3[MyArduinoGraph.maxI], Voltage3[MyArduinoGraph.maxI], gesturePoints[i][0], gesturePoints[i][1]);
//      totalDist = totalDist + gestureDist[i];
//      if(gestureDist[i] < currentMaxValue || i == 0)
//      {
//         currentMax = i;
//        currentMaxValue =  gestureDist[i];
//      }
//    }
//    totalDist=totalDist /3;
//
//    for (int i = 0; i < 4;i++)
//    {
//      float currentAmmount = 0;
//      currentAmmount = 1-gestureDist[i]/totalDist;
//      if(currentMax == i)
//       {
//         fill(0,0,0);
//    //       text(names[i],50,450);
//       fill(currentAmmount*255.0f, 0, 0);
//     
//
//       }
//       else
//       {
//         fill(255,255,255);
//       }
//
//      stroke(0, 0, 0);
//      rect(750, 100 * (i+1), 50, 50);
//      fill(0,0,0);
//      textSize(30);
//      text(names[i],810,100 * (i+1)+25);
//
//      fill(255, 0, 0);
//   //   rect(800,100* (i+1), max(0,currentAmmount*50),50);
//    }
//
//
//  }
//}
//
//void stop()
//{
//
//  myPort.stop();
//  super.stop();
//}


/*
 * Touche for Arduino
 * Vidualization Example 00
 *
 */
 
float voltageMax; //電圧の最大値
float timeMax; //電圧が最大値だったときの時間
 
void setup() {
  //画面サイズ
  size(800, 600); 
  noLoop();
  //ポートを設定
  PortSelected=7; 
  //シリアルポートを初期化
  SerialPortSetup();
}
 
void draw() {
  background(63);
  fill(255);
 
  //最大値を0に初期化
  voltageMax = timeMax = 0;
 
  if ( DataRecieved3 ) {
    //電圧の最大値と、そのときの時間を取得
    for (int i = 0; i < Voltage3.length; i++) {
      if (voltageMax < Voltage3[i]) {
        voltageMax = Voltage3[i];
        timeMax = Time3[i];
      }
    }
 
//    //時間と電圧の範囲(最小値と最大値)を表示
//    text("Time range: " +  min(Time3) + " - " + max(Time3), 20, 20);
//    text("Voltage range: " +  min(Voltage3) + " - " + max(Voltage3), 20, 40);
// 
//    //電圧の最大値と、その時の時間を表示
//    text("Time: " + timeMax, 20, 80);
//    text("Voltage: " + voltageMax, 20, 100);
    
    fill(#3399ff);
    noStroke();
    ellipse(max(Time3), max(Voltage3), timeMax, voltageMax);
  }
}
 
void stop() {
  myPort.stop();
  super.stop();
}
