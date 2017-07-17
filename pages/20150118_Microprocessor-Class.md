
Many of the topics covered in the first few assignments I was already familiar with through my prior Arduino experience;  however, it was refreshing to receive formal instruction on the things that I had learned from online tutorials and forum chatter.  Not only did this fill in gaps in my understanding and correct misconceptions but applying what I had already learned to a new embedded platform, the mbed itself, greatly expanded what I already knew about embedded system development.

**Assignment 1:  Morse Code Identifier**

In the first assignment, we were tasked with writing code that would used the mbed's onboard LEDs to spell out our initials followed by 'OK' in morse code.  This assignment was very straight forward.


      #include "mbed.h"

      DigitalOut led(LED1);
      DigitalIn  button1(p21);
      DigitalIn  button2(p22);

      float dotWait = .2;
      float dashWait = .6;
      float shortSpace = .2;
      float longSpace = .6;

      void dash(){
      led = 1;
      wait (dashWait);
      led = 0;
      }

      void dot(){
      led = 1;
      wait (dotWait);
      led = 0;
      }

      void OK(){
      //write 'O'
      dash();
      wait (shortSpace);
      dash();
      wait (shortSpace);
      dash();
      wait(longSpace);
      //write 'K'
      dash();
      wait (shortSpace);
      dot();
      wait (shortSpace);
      dash();
      wait(longSpace);
      }

      void CT(){
      //write 'C'
      dash();
      wait (shortSpace);
      dot();
      wait (shortSpace);
      dash();
      wait (shortSpace);
      dot();
      wait(longSpace);
      //write 'T'
      dash();
      wait(longSpace);
      }

      int main() {
      while(1) {
          if (button1 == 1){
              OK();    
          }
          if (button2 == 1){
              CT();
          }
      }
    }




**Assignment 2:  Movie Prop**

The second assignment was slightly more interesting.  We were tasked with creating what might be used as a movie prop.  The requirements were that we should blink the mbed's onboard LEDs such that they appear to fade back and forth using the mbed pulse width modulation class.  When the leftmost or right most LED was at its maximum brightness, a piezo buzzer should sound.  This light and sound combination was reminiscent of a heart monitor movie prop.




      #include "mbed.h"

      PwmOut led1(LED1);
      PwmOut led2(LED2);
      PwmOut led3(LED3);
      PwmOut led4(LED4);
      PwmOut piez(p21);

      void led1Func ( int i ){
      //    if ( i >= 0 && i < 25 ){      //this step caused brightness to be lowest at beginning of sequence
      //        led2 = led3 = led4 = 0;   //removed so that piezo sounds at max brightness only
      //        led1 = i / 25.0;
      //    }
      if ( i >= 25 && i < 50){
          led3 = led4 = 0;
          led1 = 2 - ( i / 25.0 );
      }
      }

      void led2Func ( int i ){
      if ( i >= 25 && i < 50 ){
          led3 = led4 = 0;
          led2 =  ( i / 25.0 ) - 1;
      }
      if ( i >= 50 && i < 75){
          led1 = led4 = 0;
          led2 = 3 - ( i / 25.0 );
      }
      }

      void led3Func ( int i ){
      if ( i >= 50 && i < 75 ){
          led1 = led4 = 0;
          led3 =  ( i / 25.0 ) - 2;
      }
      if ( i >= 75 && i < 100){
          led1 = led2 = 0;
          led3 = 4 - ( i / 25.0 );
      }
      }

      void led4Func ( int i ){
      if ( i >= 75 && i < 100 ){
          led1 = led2 = 0;
          led4 =  ( i / 25.0 ) - 3;
      }
      //    if ( i >= 100 && i < 125){        //this step caused brightness to fall at end of sequence
      //        led1 = led2 = led3 = 0;       //removed so that piezo sounds at max brightness
      //        led4 = 5 - ( i / 25.0 );
      //    }
      }

      void piez1046 ( ){
      piez.period( 1.0 / 1046 );
      piez = .5;
      wait ( .2 );
      piez = 0;
      }

      void piez880 ( ){
      piez.period( 1.0 / 880 );
      piez = .5;
      wait ( .2 );
      piez = 0;
      }

      int main() {
      led1.period( 1.0 / 50 );
      led1 = .5;
      while ( 1 ){
          for ( int i = 25; i < 100; i++){        //modified bounds from 0 - 100 to 25 - 100 so that piezo sounds at max brightness
              led1Func ( i );
              led2Func ( i );
              led3Func ( i );
              led4Func ( i );
              wait ( .032 );
          }
          piez1046 ( );
          for ( int i = 100; i > 25; i-- ){       //modified bounds from 0 - 100 to 25 - 100 so that piezo sounds at max brightness
              led1Func ( i );
              led2Func ( i );
              led3Func ( i );
              led4Func ( i );
              wait ( .032 );
          }
          piez880 ( );
      }
    }






**Assignment 3:  Temperature Monitor**

In assignment three we were asked to create a temperature monitor.  The monitor would take the average of 1000 samples and display scroll the current temperature across a single seven segment display.  The assignment also called for the sketch to convert between Fahrenheit and Celsius units and display each when selected by a pushbutton switch.




    #include "mbed.h"
    AnalogIn tempSamp(p20);
    BusOut display(p5,p6,p7,p8,p9,p10,p11,p12);
    DigitalIn fahrenheit(p13);
    DigitalIn celsius(p14);
    //InterruptIn f(p13);
    //InterruptIn c(p14);
    Serial pc(USBTX,USBRX);

    float getTemp( char unit ){
      float tempAvg = 0;
      for (int i = 0; i < 1000; i++){
          tempAvg = tempAvg + ( tempSamp.read() * 3.3 * 100);
      }
      tempAvg = tempAvg / 1000.0;
      if ( unit == 'f' ){
          tempAvg = tempAvg * (9.0/5.0) + 32;
      }
      pc.printf("%f \n\r",tempAvg);
      return tempAvg;
    }
    void dispTemp( float tempAvg ){
      int temp1 = tempAvg / 10;
      int temp2 = tempAvg - ( temp1 * 10 );
      switch(temp1){
              case 0: display = 0x3F; break;                           
              case 1: display = 0x86; break;  
              case 2: display = 0x5B; break;
              case 3: display = 0x4F; break;  
              case 4: display = 0x66; break;  
              case 5: display = 0x6D; break;
              case 6: display = 0x7D; break;  
              case 7: display = 0x07; break;  
              case 8: display = 0x7F; break;
              case 9: display = 0x6F; break;
          }
          wait(1);
          display = 0x00;
          wait(.1);
          switch(temp2){
              case 0: display = 0x3F; break;                           
              case 1: display = 0x86; break;  
              case 2: display = 0x5B; break;
              case 3: display = 0x4F; break;  
              case 4: display = 0x66; break;  
              case 5: display = 0x6D; break;
              case 6: display = 0x7D; break;  
              case 7: display = 0x07; break;  
              case 8: display = 0x7F; break;
              case 9: display = 0x6F; break;
          }
          wait(1);
          display = 0x00;
          wait(.1);
    }

    int main() {
      fahrenheit.mode(PullUp);
      celsius.mode(PullUp);
      char unit = 'f';
      char flipflop = 'c';
      while(1) {
          if ( fahrenheit.read() == 0 ){
              dispTemp ( getTemp( unit = 'f' ) );
              display = 0x71;
              wait(1);
              flipflop = 'f';
          }
          if ( celsius.read() == 0 ) {
              dispTemp( getTemp( unit = 'c' ) );
              display = 0x39;
              wait(1);  
              flipflop = 'c';
          }     
          if ( flipflop == 'f' ){
              dispTemp ( getTemp( unit = 'f' ) );
              display = 0x71;
              wait(1);
          }
          if ( flipflop == 'c' ){
              dispTemp( getTemp( unit = 'c' ) );
              display = 0x39;
              wait(1);
          }
      }        
    }




**Assignment 4:  One-Dimensional Pong**

In our fourth assignment we were asked to create a two-player game that that played much like a linear version of Pong, that is it only uses the mbed's four onboard LEDs.  Much like in the 'movie prop' assignment, the lights pulse back and forth.  When the light reaches one side it is the responsibility of the corresponding player to press a button before the light beings its trip towards that player's opponent.  Failing this, the opponent gains a point.  This cycle continues until one player wins twice.  When one player has won twice, the game ends.




    #include "mbed.h"

    DigitalOut one(LED1);
    DigitalOut two(LED2);
    DigitalOut three(LED3);
    DigitalOut four(LED4);

    int timebegin = 0;
    volatile int begin = 0;
    volatile int gamestatus1 = 1;
    volatile int gamestatus2 = 1;
    volatile int end1, end2;
    volatile int debounce;
    Timer timer;

    int score1 = 0;
    int score2 = 0;

    InterruptIn player1(p14);
    InterruptIn player2(p21);

    void stage(){
    one = 0;
    wait(1);
    four = 1;
    wait(1);
    four = 0;
    three = 1;
    wait(1);
    three = 0;
    two = 1;
    wait(1);
    two = 0;
    one = 1;
    timebegin = timer.read_ms();
    }

    void read1(){
     debounce = timer.read_ms();
     while (timer.read_ms() - debounce < 90) {
         wait(.075);            //if still low after .075 seconds, then count as button press
     }
     if (player1 == 0) {
        end1 = timer.read_ms();
        if ( end1 > 4000 ) {    //fair //allows for stage() to execute and timebegin to be set
            gamestatus1 = 1;
            begin = 3;          //initiated by player1
        }
        if ( end1 < 4000 ) {    //foul //allows for stage() to execute and timebegin to be set
            gamestatus1 = 0;
            begin = 3;          //initiated by player1
        }
    }
    }

    void read2(){
     debounce = timer.read_ms();
     while (timer.read_ms() - debounce < 90) {
         wait(.075);            //if still low after .075 seconds, then count as button press
     }
     if (player2 == 0) {
        end2 = timer.read_ms();
        if ( end2 > 4000 ) {   //fair  //allows for stage() to execute and timebegin to be set
            gamestatus2 = 1;
            begin = 4;         //initiated by player2
        }
        if ( end2 < 4000 ) {   //foul  //allows for stage() to execute and timebegin to be set
            gamestatus2 = 0;
            begin = 4;         //initiated by player2
        }
    }
    }
    void referee(){
    if (begin == 3) { //end1 < end2
        if (timebegin < end1) {
            score1 = score1 + 1;
    //               printf("Player1 FAIR PLAY \n\r");//fair play //1 winner
            printf("Player 1 won with a reaction time of only %d", end1 - timebegin);
            printf(" ms.\n\r");
            printf("Player 1: %d", score1);
            printf(" points, Player 2: %d", score2);
            printf(" points \n\r");
            printf(" \n\r"); //makes terminal easier to read

        }
        if (timebegin > end1) {
            score2 = score2 + 1;
    //               printf("Player1 FOUL PLAY \n\r");//foul play //1 forfiet
            printf("Player 1 was %d", timebegin - end1);
            printf(" ms too early and lost.\n\r");
            printf("Player 1: %d", score1);
            printf(" points, Player 2: %d", score2);
            printf(" points \n\r");
            printf(" \n\r"); //makes terminal easier to read
        }
    }
    if (begin == 4) {
        if (timebegin < end2) {
            score2 = score2 + 1;
    //               printf("Player2 FAIR PLAY \n\r");//fair play //2 winner
            printf("Player 2 won with a reaction time of only %d", end2 - timebegin);
            printf(" ms.\n\r");
            printf("Player 1: %d", score1);
            printf(" points, Player 2: %d", score2);
            printf(" points \n\r");
            printf(" \n\r"); //makes terminal easier to read
        }
        if (timebegin > end2) {
            score1 = score1 + 1;
    //               printf("Player2 FOUL PLAY \n\r");//foul play //2 forfiet
            printf("Player 2 was %d", timebegin - end2);
            printf(" ms too early and lost.\n\r");
            printf("Player 1: %d", score1);
            printf(" points, Player 2: %d", score2);
            printf(" points \n\r");
            printf(" \n\r"); //makes terminal easier to read
        }
    }
    }

    int main() {
    player1.mode(PullUp);
    player2.mode(PullUp);
    player1.fall(&read1);
    player2.fall(&read2);
    timer.start();
    while(1){
        gamestatus1 = 1; //1 == fair,  0 == foul
        gamestatus2 = 1;
        begin = 0;
        timer.reset();
        stage();
        wait(5);        //5 seconds between rounds
        referee();
    }
    }



**Assignment 5:  Digital Combination Lock (part 1)**

This, the fifth assignment, was the first part of a two-part assignment.  This half of the assignment was to write code that would take input from a user and use it to scroll through digits displayed on a single seven-segment display  via a latching shift register.  Also in this assignment the code that would compare the entered value to the lock's actual combination needed to be developed.  The shift register used in this assignment was the SPI-controlled 74HC595.




    #include "mbed.h"

    SPI spi(p11, p12, p13); // mosi, miso, sclk

    Timer timer;

    InterruptIn upPin(p29);
    InterruptIn downPin(p28);
    InterruptIn enterPin(p27);

    DigitalOut cs(p14);
    DigitalOut led1(LED1);
    DigitalOut led2(LED2);
    DigitalOut led3(LED3);
    DigitalOut led4(LED4);

    int hex = 0;
    int timeBegin = 0;
    int code = 1234;
    volatile int codeAttempt = 0;
    volatile int digit = 1;
    volatile int current = 0;
    volatile int initial = 0;


    int display (volatile int n){
      switch(n) {
          case 0:
              hex = 0x3f;
              break;
          case 1:
              hex = 0x06;
              break;
          case 2:
              hex = 0x5B;
              break;
          case 3:
              hex = 0x4F;
              break;
          case 4:
              hex = 0x66;
              break;
          case 5:
              hex = 0x6D;
              break;
          case 6:
              hex = 0x7D;
              break;
          case 7:
              hex = 0x07;
              break;
          case 8:
              hex = 0x7F;
              break;
          case 9:
              hex = 0x67;
              break;
          case 10:
              hex = 0x38;
              break;
          case 11:
              hex = 0x3E;
              break;
      }
      return hex;
    }

    int debounce(){
      initial = timer.read_ms();
      while((timer.read_ms() - initial) < 10){
      }
      if((upPin == 1) || (downPin == 1) || (enterPin == 1)){
          return 1;
      }
    }

    void up(){
      if(debounce()){
          current = current + 1;
          cs = 0;
          spi.write(display(current));
          cs = 1;
          if(current > 9){
              current = 0;
              cs = 0;
              spi.write(display(current));
              cs = 1;
          }
      }
    }

    void down(){
      if(debounce()){
          current = current - 1;
          cs = 0;
          spi.write(display(current));
          cs = 1;
          if(current < 0){
              current = 9;
              cs = 0;
              spi.write(display(current));
              cs = 1;
          }
      }
    }

    void enter(){
      if(debounce()){
          switch(digit){
              case 1:
                  codeAttempt = (current * 1000) + codeAttempt;
                  led1 = 1;
                  digit = digit + 1;
              break;
              case 2:
                  codeAttempt = (current * 100) + codeAttempt;
                  led2 = 1;
                  digit = digit + 1;
              break;
              case 3:
                  codeAttempt = (current * 10) + codeAttempt;
                  led3 = 1;
                  digit = digit + 1;
              break;
              case 4:
                  codeAttempt = (current) + codeAttempt;
                  led4 = 1;
                  digit = digit + 1;
              break;
          }
      }
    }

    int main() {
      upPin.mode(PullDown);
      downPin.mode(PullDown);
      enterPin.mode(PullDown);
      upPin.rise(&up);
      downPin.rise(&down);
      enterPin.rise(&enter);
      timer.start();

      spi.format(8,0);
      spi.frequency(1000000);
      while(1){

          codeAttempt = 0;
          digit = 1;
          current = 0;
          initial = 0;

          led1 = led2 = led3 = led4 = 0;

          cs = 0;
          spi.write(display(0));
          cs = 1;

          while(digit < 5) {
          }

          printf("codeAttempt: %d", codeAttempt);
          printf(" \n\r");

          if((int)code == (int)codeAttempt) {
              cs = 0;
              spi.write(display(11));
              cs = 1;
              while(1) {
                  led1 = led2 = led3 = led4 = 1;
                  wait(.25);
                  led1 = led2 = led3 = led4 = 0;
                  wait(.25);
              }
          }
          cs = 0;
          spi.write(display(10));
          cs = 1;

          wait(3);

          cs = 0;
          spi.write(display(0));
          cs = 1;       

      }
    }



**Assignment 6:  Digital Combination Lock (part 2)**

In the second half of the digital combination lock assignment we were to add functionality to our code that would allow our device to store its combination in EEPROM.  To do this we were asked to create two modes that would be selectable by a switch.  The 'service' mode was to set the lock's combination.  The user would use up and down arrows and an enter button to select each digit of the four-digit combination.  I chose to add a feature and used the mbed's four built-in LEDs to indicate which digit of the combination was currently being selected for.  After the fourth digit of the combination was selected, the combination would be displayed back to the user and written to and EEPROM chip using [latex]I^2C[/latex].  In 'user' mode the function developed in the previous assignment is deployed allowing the user to submit combination guesses while displaying the letters 'L' and 'U' for 'locked' and 'unlocked' respectively.




    #include "mbed.h"

    SPI spi(p11, p12, p13); // mosi, miso, sclk
    I2C i2c(p9,p10);

    Timer timer;

    InterruptIn upPin(p29);
    InterruptIn downPin(p28);
    InterruptIn enterPin(p27);

    DigitalOut cs(p14);
    DigitalOut led1(LED1);
    DigitalOut led2(LED2);
    DigitalOut led3(LED3);
    DigitalOut led4(LED4);

    DigitalIn  modePin(p26);

    int hex = 0;
    int timeBegin = 0;
    int mode = 0;
    //int code = 1234;
    volatile int codeAttempt = 0;
    volatile int digit = 1;
    volatile int current = 0;
    volatile int initial = 0;

    void i2cWrite(int byte, int value){
    i2c.start();
    i2c.write(0xA0);
    i2c.write(byte);
    i2c.write(value);
    i2c.stop();
    wait(.1);
    }

    int i2cRead(int byte){
    i2c.start();
    i2c.write(0xA0);
    i2c.write(byte);
    i2c.start();
    i2c.write(0xA1);
    int result = i2c.read(0);   // 1 to include acknowlegement bit
    i2c.stop();
    printf("%d\n\r",result);
    return result;
    }

    int getCode(){
    int code = 0;
    i2cRead(0);
    code = ( (i2cRead(1)) * 1000 ) + code;
    code = ( (i2cRead(2)) * 100 ) + code;
    code = ( (i2cRead(3)) * 10 ) + code;
    code = ( (i2cRead(4)) * 1 ) + code;  
    printf(" \n\r");
    printf("end code read");
    printf(" \n\r");
    return code;
    }

    int display (volatile int n){
    switch(n) {
        case 0:
            hex = 0x3f;
            break;
        case 1:
            hex = 0x06;
            break;
        case 2:
            hex = 0x5B;
            break;
        case 3:
            hex = 0x4F;
            break;
        case 4:
            hex = 0x66;
            break;
        case 5:
            hex = 0x6D;
            break;
        case 6:
            hex = 0x7D;
            break;
        case 7:
            hex = 0x07;
            break;
        case 8:
            hex = 0x7F;
            break;
        case 9:
            hex = 0x67;
            break;
        case 10:
            hex = 0x38;
            break;
        case 11:
            hex = 0x3E;
            break;
    }
    return hex;
    }

    int debounce(){
    initial = timer.read_ms();
    while((timer.read_ms() - initial) < 10){
    }
    if((upPin == 1) || (downPin == 1) || (enterPin == 1)){
        return 1;
    }
    }

    void up(){
    if(debounce()){
        current = current + 1;
        cs = 0;
        spi.write(display(current));
        cs = 1;
        if(current > 9){
            current = 0;
            cs = 0;
            spi.write(display(current));
            cs = 1;
        }
    }
    }

    void down(){
    if(debounce()){
        current = current - 1;
        cs = 0;
        spi.write(display(current));
        cs = 1;
        if(current < 0){
            current = 9;
            cs = 0;
            spi.write(display(current));
            cs = 1;
        }
    }
    }

    void enter(){
    if(mode == 0){
        if(debounce()){
            switch(digit){
                case 1:
                    codeAttempt = (current * 1000) + codeAttempt;
                    led1 = 1;
                    digit = digit + 1;
                break;
                case 2:
                    codeAttempt = (current * 100) + codeAttempt;
                    led2 = 1;
                    digit = digit + 1;
                break;
                case 3:
                    codeAttempt = (current * 10) + codeAttempt;
                    led3 = 1;
                    digit = digit + 1;
                break;
                case 4:
                    codeAttempt = (current) + codeAttempt;
                    led4 = 1;
                    digit = digit + 1;
                break;
            }
        }
    }
    if(mode == 1){
        if(debounce()){
            switch(digit){
                case 1:
                    i2cWrite(digit, current);
                    codeAttempt = (current * 1000) + codeAttempt;
                    led1 = 1;
                    digit = digit + 1;
                break;
                case 2:
                    i2cWrite(digit, current);
                    codeAttempt = (current * 100) + codeAttempt;
                    led2 = 1;
                    digit = digit + 1;

                break;
                case 3:
                    i2cWrite(digit, current);
                    codeAttempt = (current * 10) + codeAttempt;
                    led3 = 1;
                    digit = digit + 1;
                break;
                case 4:
                    i2cWrite(digit, current);
                    codeAttempt = (current) + codeAttempt;
                    led4 = 1;
                    digit = digit + 1;
                break;
            }
        }
    }
    }



    void userMode(){
    codeAttempt = 0;
    digit = 1;
    current = 0;
    initial = 0;
    mode = 0;
    int code = getCode();

    printf("code: %d", code);
    printf(" \n\r");

    led1 = led2 = led3 = led4 = 0;

    cs = 0;
    spi.write(display(0));
    cs = 1;

    while(digit < 5) {
    }


    printf("codeAttempt: %d", codeAttempt);
    printf(" \n\r");

    if((int)code == (int)codeAttempt) {
        cs = 0;
        spi.write(display(11));
        cs = 1;
        while(1) {
            led1 = led2 = led3 = led4 = 1;
            wait(.25);
            led1 = led2 = led3 = led4 = 0;
            wait(.25);
        }
    }
    cs = 0;
    spi.write(display(10));
    cs = 1;

    wait(3);

    cs = 0;
    spi.write(display(0));
    cs = 1;
    }

    void servMode(){
    codeAttempt = 0;
    digit = 1;
    current = 0;
    initial = 0;
    mode = 1;

    led1 = led2 = led3 = led4 = 0;

    cs = 0;
    spi.write(display(0));
    cs = 1;

    while(digit < 5) {
    }

    for(int digit = 1; digit < 5; digit++){
        cs = 0;
        spi.write(display(i2cRead(digit)));
        cs = 1;
        wait(1);
    }
    cs = 0;
    spi.write(0x00);
    cs = 1;
    while(1){
        //infinite loop
    }

    }



    int main() {
    upPin.mode(PullDown);
    downPin.mode(PullDown);
    enterPin.mode(PullDown);
    upPin.rise(&up);
    downPin.rise(&down);
    enterPin.rise(&enter);
    timer.start();

    spi.format(8,0);
    spi.frequency(1000000);
    while(1){
        if ( modePin == 1 ){
            servMode();
        }
        else{
            userMode();        
        }
    }
    }


**Assignment 7: Direct Register Access**

The final assignment of the semester was to recreate a previous assignment, One-Dimensional Pong, while using none of the bulit-in mbed libraries.  That is, we were to dig into the mbed's datasheet and directly manipulate the registers of the microprocessor to achieve all desired functionality.  This means that if a pin needed to be set HIGH, we were to locate the appropriate register and the appropriate bit and write a 1 to that bit.  Likewise we were to set certain bits as inputs and others as outputs using a similar approach.  This assignment was indeed more difficult than the others; however, it provided much welcome insight to what goes on behind the scenes when using library functions.  Personally, I found remembering which pins corresponded to which registers and which byte in each register corresponded to which pin difficult to keep track of so I created a function for each operation that might be called for each pin.  -a rudimentary library.  I do suppose that it could have been written a bit more elegantly, but at the time while working under a deadline that apparently did not occur to me.  For example, any time that I needed to write digital pin 27 HIGH I called dip27high(),


      void dip27high(){
          FIO0PIN |= (1<<11);
          __DSB();
      }



which wrote a 1 to the eleventh bit of of the FIO0 register.  I realize now that a more proper way to implement this functionality would have been to created a function that accepted as its parameters the pin to be manipulated and the state to write to that pin much like the built-in mbed library; however, this worked perfectly well for this assignment and was a nice exercise in understanding how libraries work.


    #include "mbed.h"

    #define FIO0PIN (*(volatile unsigned int *)0x2009c014)
    #define FIO0DIR (*(volatile unsigned int *)0x2009c000)
    #define FIO1PIN (*(volatile unsigned int *)0x2009c034)
    #define FIO1DIR (*(volatile unsigned int *)0x2009c020)
    #define PINMODE0 (*(volatile unsigned int *)0x4002c040)
    #define PINMODE1 (*(volatile unsigned int *)0x4002c044)
    #define PINMODE3 (*(volatile unsigned int *)0x4002c04c)
    #define PINSEL0 (*(volatile unsigned int *)0x4002c000)
    #define PINSEL1 (*(volatile unsigned int *)0x4002c004)
    #define PINSEL3 (*(volatile unsigned int *)0x4002c00c)
    #define PCONP (*(volatile unsigned int *)0x400fc0c4)
    #define PCLKSEL0 (*(volatile unsigned int *)0x400fc1a8)
    #define AD0CR (*(volatile unsigned int *)0x40034000)
    #define AD0GDR (*(volatile unsigned int *)0x40034004)

    //DIP5    P0.9
    //DIP6    P0.8
    //DIP27   P0.11
    //DIP28   P0.10
    //DIP29   P0.5
    //DIP30   P0.4

    Timer timer;

    float delay = .20;

    int status = 0;
    int hit = 1;
    int miss = 0;
    float shift = 3.0;
    int points1 = 0;
    int points2 = 0;
    int play = 0;


    void setup(void){
    //Digital inputs
    FIO0DIR &= ~(1<<9);   //set to 0
    __DSB();
    FIO0DIR &= ~(1<<8);   //set to 0

    //Digital outputs
    FIO0DIR |= (1<<11) | (1<<10) | (1<<5) | (1<<4);    //set to 1
    __DSB();
    FIO1DIR |= (1<<18) | (1<<20) | (1<<21) | (1<<23);

    PINMODE0 |= (3<<18);   //pull-down resistor on DIP5
    __DSB();
    PINMODE0 |= (3<<16);   //Pull-down resistor on DIP6

    }

    int button1(void){
    if(FIO0PIN & (1<<9))
        return 1;
    else
        return 0;
    }

    int button2(void){
    if(FIO0PIN & (1<<8))
        return 1;
    else
        return 0;
    }

    void dip27high(){
    FIO0PIN |= (1<<11);
    __DSB();
    }

    void dip27low(){
    FIO0PIN &= ~(1<<11);
    __DSB();
    }

    void dip28high(){
    FIO0PIN |= (1<<10);
    __DSB();
    }

    void dip28low(){
    FIO0PIN &= ~(1<<10);
    __DSB();
    }

    void dip29high(){
    FIO0PIN |= (1<<5);
    __DSB();
    }

    void dip29low(){
    FIO0PIN &= ~(1<<5);
    __DSB();
    }

    void dip30high(){
    FIO0PIN |= (1<<4);
    __DSB();
    }

    void dip30low(){
    FIO0PIN &= ~(1<<4);
    __DSB();
    }

    void led1high(){
    FIO1PIN |= (1<<18);
    __DSB();
    }

    void led1low(){
    FIO1PIN &= ~(1<<18);
    __DSB();
    }

    void led2high(){
    FIO1PIN |= (1<<20);
    __DSB();
    }

    void led2low(){
    FIO1PIN &= ~(1<<20);
    __DSB();
    }

    void led3high(){
    FIO1PIN |= (1<<21);
    __DSB();
    }

    void led3low(){
    FIO1PIN &= ~(1<<21);
    __DSB();
    }

    void led4high(){
    FIO1PIN |= (1<<23);
    __DSB();
    }

    void led4low(){
    FIO1PIN &= ~(1<<23);
    __DSB();
    }

    void leftRight(){
    led1high();
    wait(delay);
    led2high();
    led1low();
    wait(delay);
    led3high();
    led2low();
    wait(delay);
    led4high();
    led3low();
    }

    void rightLeft(){
    led4high();
    wait(delay);
    led3high();
    led4low();
    wait(delay);
    led2high();
    led3low();
    wait(delay);
    led1high();
    led2low();
    }

    void point1(){
    points1 = points1 + 1;
    if( points1 == 1 ){
        dip27high();
    }
    if( points1 == 2 ){
        dip28high();
        while(1){
            dip27high();
            wait(.10);
            dip27low();
            dip28high();
            wait(.10);
            dip28low();
        }
    }
    }

    void point2(){
    points2 = points2 + 1;
    if( points2 == 1 ){
        dip29high();
    }
    if( points2 == 2 ){
        dip30high();
        while(1){
            dip29high();
            wait(.10);
            dip29low();
            dip30high();
            wait(.10);
            dip30low();
        }
    }
    }


    int main() {
    setup();
    while(1){
        shift = 0;
        status = 0;
        if( (play == 0) ){// || (status == 0)
            while( button1() == 0 ){
                //wait
            }
        }
        leftRight();
        timer.start();
        timer.reset();
        while( (timer.read_ms() + shift) < delay * 1000){
            if( button1() ){
                status = hit;
                shift = 1001;
            }
        }
        led4low();
        if(status){
        }
        else{
            point2();
            while( button1() == 0 ){
                //wait
            }
        }


        shift = 0;
        status = 0;
        rightLeft();
        timer.reset();
        while( (timer.read_ms() + shift) < delay * 1000){
            if( button2() ){
                status = hit;
                shift = 1001;    
            }    
        }
        led1low();
        if(status){
        }
        else{
            point1();
            while( !button2() ){
                //wait
            }
        }
        play++;

    }
    }
