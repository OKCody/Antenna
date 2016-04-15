---
author: codyalantaylor
comments: true
date: 2015-01-18 18:36:46+00:00
layout: post
slug: microprocessor-class
title: Microprocessor Class
wordpress_id: 162
categories:
- Education
- Open
- Programming
---

With the fall semester and Christmas now out of the way, I finally have time to write a bit about what I worked on last semester.  My favorite class last semester was Microprocessor System Design and, so far, has been my favorite ECE (electrical and computer engineering) class in general.  The class was based on the mbed microcontroller.  During the class we completed seven assignments that walked us through how to use many of mbed classes that make interfacing C code to the physical world simple.  In addition to using the mbed classes, for our final assignment we used none of the mbed classes.  Instead we used direct register access to manipulate the pins of the mbed.

Many of the topics covered in the first few assignments I was already familiar with through my prior Arduino experience;  however, it was refreshing to receive formal instruction on the things that I had learned from online tutorials and forum chatter.  Not only did this fill in gaps in my understanding and correct misconceptions but applying what I had already learned to a new embedded platform, the mbed itself, greatly expanded what I already knew about embedded system development.

**Assignment 1:  Morse Code Identifier**

In the first assignment, we were tasked with writing code that would used the mbed's onboard LEDs to spell out our initials followed by 'OK' in morse code.  This assignment was very straight forward.

    
    #<span style="color: #ff5600;">include</span> <span style="color: #00a33f;">"mbed.h"</span>
    
    DigitalOut <span style="color: #21439c;">led</span>(LED1);
    DigitalIn  <span style="color: #21439c;">button1</span>(p21);
    DigitalIn  <span style="color: #21439c;">button2</span>(p22);
    
    <span style="color: #ff5600;">float</span> dotWait = .2;
    <span style="color: #ff5600;">float</span> dashWait = .6;
    <span style="color: #ff5600;">float</span> shortSpace = .2;
    <span style="color: #ff5600;">float</span> longSpace = .6;
    
    <span style="color: #ff5600;">void</span> <span style="color: #21439c;">dash</span>(){
        led = 1;
        wait (dashWait);
        led = 0;
    }
    
    <span style="color: #ff5600;">void</span> <span style="color: #21439c;">dot</span>(){
        led = 1;
        wait (dotWait);
        led = 0;
    }
    
    <span style="color: #ff5600;">void</span> <span style="color: #21439c;">OK</span>(){
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
    
    <span style="color: #ff5600;">void</span> <span style="color: #21439c;">CT</span>(){
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
    
    <span style="color: #ff5600;">int</span> <span style="color: #21439c;">main</span>() {
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



    
    #<span style="color: #ff5600;">include</span> <span style="color: #00a33f;">"mbed.h"</span>
    
    PwmOut <span style="color: #21439c;">led1</span>(LED1);
    PwmOut <span style="color: #21439c;">led2</span>(LED2);
    PwmOut <span style="color: #21439c;">led3</span>(LED3);
    PwmOut <span style="color: #21439c;">led4</span>(LED4);
    PwmOut <span style="color: #21439c;">piez</span>(p21);
    
    <span style="color: #ff5600;">void</span> <span style="color: #21439c;">led1Func</span> ( int i ){
    //    if ( i >= 0 && i < 25 ){      //this step caused brightness to be lowest at beginning of sequence
    //        led2 = led3 = led4 = 0;   //removed so that piezo sounds at max brightness only
    //        led1 = i / 25.0;
    //    }
        if ( i >= 25 && i < 50){
            led3 = led4 = 0;
            led1 = 2 - ( i / 25.0 );
        }
    }
    
    <span style="color: #ff5600;">void</span> <span style="color: #21439c;">led2Func</span> ( int i ){
        if ( i >= 25 && i < 50 ){
            led3 = led4 = 0;
            led2 =  ( i / 25.0 ) - 1;
        }
        if ( i >= 50 && i < 75){
            led1 = led4 = 0;
            led2 = 3 - ( i / 25.0 );
        }
    }
    
    <span style="color: #ff5600;">void</span> <span style="color: #21439c;">led3Func</span> ( int i ){
        if ( i >= 50 && i < 75 ){
            led1 = led4 = 0;
            led3 =  ( i / 25.0 ) - 2;
        }
        if ( i >= 75 && i < 100){
            led1 = led2 = 0;
            led3 = 4 - ( i / 25.0 );
        }
    }
    
    <span style="color: #ff5600;">void</span> <span style="color: #21439c;">led4Func</span> ( int i ){
        if ( i >= 75 && i < 100 ){
            led1 = led2 = 0;
            led4 =  ( i / 25.0 ) - 3;
        }
    //    if ( i >= 100 && i < 125){        //this step caused brightness to fall at end of sequence
    //        led1 = led2 = led3 = 0;       //removed so that piezo sounds at max brightness
    //        led4 = 5 - ( i / 25.0 );
    //    }
    }
    
    <span style="color: #ff5600;">void</span> <span style="color: #21439c;">piez1046</span> ( ){
        piez.<span style="color: #a535ae;">period</span>( 1.0 / 1046 );
        piez = .5;
        wait ( .2 );
        piez = 0;
    }
    
    <span style="color: #ff5600;">void</span> <span style="color: #21439c;">piez880</span> ( ){
        piez.<span style="color: #a535ae;">period</span>( 1.0 / 880 );
        piez = .5;
        wait ( .2 );
        piez = 0;
    }
    
    <span style="color: #ff5600;">int</span> <span style="color: #21439c;">main</span>() {
        led1.<span style="color: #a535ae;">period</span>( 1.0 / 50 );
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



    
    #<span style="color: #ff5600;">include</span> <span style="color: #00a33f;">"mbed.h"</span>
    AnalogIn <span style="color: #21439c;">tempSamp</span>(p20);
    BusOut <span style="color: #21439c;">display</span>(p5,p6,p7,p8,p9,p10,p11,p12);
    DigitalIn <span style="color: #21439c;">fahrenheit</span>(p13);
    DigitalIn <span style="color: #21439c;">celsius</span>(p14);
    <span style="color: #919191;">//InterruptIn f(p13);</span>
    <span style="color: #919191;">//InterruptIn c(p14);</span>
    Serial <span style="color: #21439c;">pc</span>(USBTX,USBRX);
    
    <span style="color: #ff5600;">float</span> <span style="color: #21439c;">getTemp</span>( char unit ){
        float tempAvg = 0;
        for (int i = 0; i < 1000; i++){
            tempAvg = tempAvg + ( tempSamp.<span style="color: #a535ae;">read</span>() * 3.3 * 100);
        }
        tempAvg = tempAvg / 1000.0;
        if ( unit == 'f' ){
            tempAvg = tempAvg * (9.0/5.0) + 32;
        }
        pc.<span style="color: #a535ae;">printf</span>("%f \n\r",tempAvg);
        return tempAvg;
    }
    <span style="color: #ff5600;">void</span> <span style="color: #21439c;">dispTemp</span>( float tempAvg ){
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
    
    <span style="color: #ff5600;">int</span> <span style="color: #21439c;">main</span>() {
        fahrenheit.<span style="color: #a535ae;">mode</span>(PullUp);
        celsius.<span style="color: #a535ae;">mode</span>(PullUp);
        char unit = 'f';
        char flipflop = 'c';
        while(1) {
            if ( fahrenheit.<span style="color: #a535ae;">read</span>() == 0 ){
                dispTemp ( getTemp( unit = 'f' ) );
                display = 0x71;
                wait(1);
                flipflop = 'f';
            }
            if ( celsius.<span style="color: #a535ae;">read</span>() == 0 ) {
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



    
    #<span style="color: #ff5600;">include</span> <span style="color: #00a33f;">"mbed.h"</span>
    
    DigitalOut <span style="color: #21439c;">one</span>(LED1);
    DigitalOut <span style="color: #21439c;">two</span>(LED2);
    DigitalOut <span style="color: #21439c;">three</span>(LED3);
    DigitalOut <span style="color: #21439c;">four</span>(LED4);
    
    <span style="color: #ff5600;">int</span> timebegin = 0; 
    <span style="color: #ff5600;">volatile</span> <span style="color: #ff5600;">int</span> begin = 0;
    <span style="color: #ff5600;">volatile</span> <span style="color: #ff5600;">int</span> gamestatus1 = 1;
    <span style="color: #ff5600;">volatile</span> <span style="color: #ff5600;">int</span> gamestatus2 = 1;
    <span style="color: #ff5600;">volatile</span> <span style="color: #ff5600;">int</span> end1, end2;
    <span style="color: #ff5600;">volatile</span> <span style="color: #ff5600;">int</span> debounce;
    Timer timer;
    
    <span style="color: #ff5600;">int</span> score1 = 0;
    <span style="color: #ff5600;">int</span> score2 = 0;
    
    InterruptIn <span style="color: #21439c;">player1</span>(p14);
    InterruptIn <span style="color: #21439c;">player2</span>(p21);
    
    <span style="color: #ff5600;">void</span> <span style="color: #21439c;">stage</span>(){
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
        timebegin = timer.<span style="color: #a535ae;">read_ms</span>();
    }
    
    <span style="color: #ff5600;">void</span> <span style="color: #21439c;">read1</span>(){
         debounce = timer.<span style="color: #a535ae;">read_ms</span>();
         while (timer.<span style="color: #a535ae;">read_ms</span>() - debounce < 90) {
             wait(.075);            //if still low after .075 seconds, then count as button press
         }
         if (player1 == 0) {
            end1 = timer.<span style="color: #a535ae;">read_ms</span>();
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
     
     <span style="color: #ff5600;">void</span> <span style="color: #21439c;">read2</span>(){
         debounce = timer.<span style="color: #a535ae;">read_ms</span>();
         while (timer.<span style="color: #a535ae;">read_ms</span>() - debounce < 90) {
             wait(.075);            //if still low after .075 seconds, then count as button press
         }
         if (player2 == 0) {
            end2 = timer.<span style="color: #a535ae;">read_ms</span>();
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
    <span style="color: #ff5600;">void</span> <span style="color: #21439c;">referee</span>(){
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
    
    <span style="color: #ff5600;">int</span> <span style="color: #21439c;">main</span>() {
        player1.<span style="color: #a535ae;">mode</span>(PullUp);
        player2.<span style="color: #a535ae;">mode</span>(PullUp);
        player1.<span style="color: #a535ae;">fall</span>(&read1);
        player2.<span style="color: #a535ae;">fall</span>(&read2);
        timer.<span style="color: #a535ae;">start</span>();
        while(1){
            gamestatus1 = 1; //1 == fair,  0 == foul
            gamestatus2 = 1;
            begin = 0;
            timer.<span style="color: #a535ae;">reset</span>();
            stage();
            wait(5);        //5 seconds between rounds
            referee();
        }
    }
    


**Assignment 5:  Digital Combination Lock (part 1)**

This, the fifth assignment, was the first part of a two-part assignment.  This half of the assignment was to write code that would take input from a user and use it to scroll through digits displayed on a single seven-segment display  via a latching shift register.  Also in this assignment the code that would compare the entered value to the lock's actual combination needed to be developed.  The shift register used in this assignment was the SPI-controlled 74HC595.



    
    #<span style="color: #ff5600;">include</span> <span style="color: #00a33f;">"mbed.h"</span>
     
    SPI <span style="color: #21439c;">spi</span>(p11, p12, p13); <span style="color: #919191;">// mosi, miso, sclk</span>
    
    Timer timer;
    
    InterruptIn <span style="color: #21439c;">upPin</span>(p29);
    InterruptIn <span style="color: #21439c;">downPin</span>(p28);
    InterruptIn <span style="color: #21439c;">enterPin</span>(p27);
    
    DigitalOut <span style="color: #21439c;">cs</span>(p14);
    DigitalOut <span style="color: #21439c;">led1</span>(LED1);
    DigitalOut <span style="color: #21439c;">led2</span>(LED2);
    DigitalOut <span style="color: #21439c;">led3</span>(LED3);
    DigitalOut <span style="color: #21439c;">led4</span>(LED4);
    
    <span style="color: #ff5600;">int</span> hex = 0;
    <span style="color: #ff5600;">int</span> timeBegin = 0;
    <span style="color: #ff5600;">int</span> code = 1234;
    <span style="color: #ff5600;">volatile</span> <span style="color: #ff5600;">int</span> codeAttempt = 0;
    <span style="color: #ff5600;">volatile</span> <span style="color: #ff5600;">int</span> digit = 1;
    <span style="color: #ff5600;">volatile</span> <span style="color: #ff5600;">int</span> current = 0;
    <span style="color: #ff5600;">volatile</span> <span style="color: #ff5600;">int</span> initial = 0;
    
    
    <span style="color: #ff5600;">int</span> <span style="color: #21439c;">display</span> (volatile int n){
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
    
    <span style="color: #ff5600;">int</span> <span style="color: #21439c;">debounce</span>(){
        initial = timer.<span style="color: #a535ae;">read_ms</span>();
        while((timer.<span style="color: #a535ae;">read_ms</span>() - initial) < 10){
        }
        if((upPin == 1) || (downPin == 1) || (enterPin == 1)){
            return 1;
        }
    }
    
    <span style="color: #ff5600;">void</span> <span style="color: #21439c;">up</span>(){
        if(<span style="color: #a535ae;">debounce</span>()){
            current = current + 1;
            cs = 0;
            spi.<span style="color: #a535ae;">write</span>(<span style="color: #a535ae;">display</span>(current));
            cs = 1;
            if(current > 9){
                current = 0;
                cs = 0;
                spi.<span style="color: #a535ae;">write</span>(<span style="color: #a535ae;">display</span>(current));
                cs = 1;
            }
        }
    }
    
    <span style="color: #ff5600;">void</span> <span style="color: #21439c;">down</span>(){
        if(<span style="color: #a535ae;">debounce</span>()){
            current = current - 1;
            cs = 0;
            spi.<span style="color: #a535ae;">write</span>(<span style="color: #a535ae;">display</span>(current));
            cs = 1;
            if(current < 0){
                current = 9;
                cs = 0;
                spi.<span style="color: #a535ae;">write</span>(<span style="color: #a535ae;">display</span>(current));
                cs = 1;
            }
        }
    }
    
    <span style="color: #ff5600;">void</span> <span style="color: #21439c;">enter</span>(){
        if(<span style="color: #a535ae;">debounce</span>()){
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
     
    <span style="color: #ff5600;">int</span> <span style="color: #21439c;">main</span>() {
        upPin.<span style="color: #a535ae;">mode</span>(PullDown);
        downPin.<span style="color: #a535ae;">mode</span>(PullDown);
        enterPin.<span style="color: #a535ae;">mode</span>(PullDown);
        upPin.<span style="color: #a535ae;">rise</span>(&up);
        downPin.<span style="color: #a535ae;">rise</span>(&down);
        enterPin.<span style="color: #a535ae;">rise</span>(&enter);
        timer.<span style="color: #a535ae;">start</span>();
     
        spi.<span style="color: #a535ae;">format</span>(8,0);
        spi.<span style="color: #a535ae;">frequency</span>(1000000);
        while(1){
            
            codeAttempt = 0;
            digit = 1;
            current = 0;
            initial = 0;
            
            led1 = led2 = led3 = led4 = 0;
            
            cs = 0;
            spi.<span style="color: #a535ae;">write</span>(<span style="color: #a535ae;">display</span>(0));
            cs = 1;
            
            while(digit < 5) {
            }
        
            printf("codeAttempt: %d", codeAttempt);
            printf(" \n\r");
        
            if((int)code == (int)codeAttempt) {
                cs = 0;
                spi.<span style="color: #a535ae;">write</span>(<span style="color: #a535ae;">display</span>(11));
                cs = 1;
                while(1) {
                    led1 = led2 = led3 = led4 = 1;
                    wait(.25);
                    led1 = led2 = led3 = led4 = 0;
                    wait(.25);
                }
            }
            cs = 0;
            spi.<span style="color: #a535ae;">write</span>(<span style="color: #a535ae;">display</span>(10));
            cs = 1;
        
            wait(3);
            
            cs = 0;
            spi.<span style="color: #a535ae;">write</span>(<span style="color: #a535ae;">display</span>(0));
            cs = 1;       
            
        }
    }
    


**Assignment 6:  Digital Combination Lock (part 2)**

In the second half of the digital combination lock assignment we were to add functionality to our code that would allow our device to store its combination in EEPROM.  To do this we were asked to create two modes that would be selectable by a switch.  The 'service' mode was to set the lock's combination.  The user would use up and down arrows and an enter button to select each digit of the four-digit combination.  I chose to add a feature and used the mbed's four built-in LEDs to indicate which digit of the combination was currently being selected for.  After the fourth digit of the combination was selected, the combination would be displayed back to the user and written to and EEPROM chip using [latex]I^2C[/latex].  In 'user' mode the function developed in the previous assignment is deployed allowing the user to submit combination guesses while displaying the letters 'L' and 'U' for 'locked' and 'unlocked' respectively.



    
    #<span style="color: #ff5600;">include</span> <span style="color: #00a33f;">"mbed.h"</span>
     
    SPI <span style="color: #21439c;">spi</span>(p11, p12, p13); <span style="color: #919191;">// mosi, miso, sclk</span>
    I2C <span style="color: #21439c;">i2c</span>(p9,p10); 
    
    Timer timer;
    
    InterruptIn <span style="color: #21439c;">upPin</span>(p29);
    InterruptIn <span style="color: #21439c;">downPin</span>(p28);
    InterruptIn <span style="color: #21439c;">enterPin</span>(p27);
    
    DigitalOut <span style="color: #21439c;">cs</span>(p14);
    DigitalOut <span style="color: #21439c;">led1</span>(LED1);
    DigitalOut <span style="color: #21439c;">led2</span>(LED2);
    DigitalOut <span style="color: #21439c;">led3</span>(LED3);
    DigitalOut <span style="color: #21439c;">led4</span>(LED4);
    
    DigitalIn  <span style="color: #21439c;">modePin</span>(p26);
    
    <span style="color: #ff5600;">int</span> hex = 0;
    <span style="color: #ff5600;">int</span> timeBegin = 0;
    <span style="color: #ff5600;">int</span> mode = 0;
    <span style="color: #919191;">//int code = 1234;</span>
    <span style="color: #ff5600;">volatile</span> <span style="color: #ff5600;">int</span> codeAttempt = 0;
    <span style="color: #ff5600;">volatile</span> <span style="color: #ff5600;">int</span> digit = 1;
    <span style="color: #ff5600;">volatile</span> <span style="color: #ff5600;">int</span> current = 0;
    <span style="color: #ff5600;">volatile</span> <span style="color: #ff5600;">int</span> initial = 0;
    
    <span style="color: #ff5600;">void</span> <span style="color: #21439c;">i2cWrite</span>(int byte, int value){
       i2c.<span style="color: #a535ae;">start</span>();
       i2c.<span style="color: #a535ae;">write</span>(0xA0);
       i2c.<span style="color: #a535ae;">write</span>(byte);
       i2c.<span style="color: #a535ae;">write</span>(value);
       i2c.<span style="color: #a535ae;">stop</span>();
       wait(.1);
    }
    
    <span style="color: #ff5600;">int</span> <span style="color: #21439c;">i2cRead</span>(int byte){
       i2c.<span style="color: #a535ae;">start</span>();
       i2c.<span style="color: #a535ae;">write</span>(0xA0);
       i2c.<span style="color: #a535ae;">write</span>(byte);
       i2c.<span style="color: #a535ae;">start</span>();
       i2c.<span style="color: #a535ae;">write</span>(0xA1);
       int result = i2c.<span style="color: #a535ae;">read</span>(0);   // 1 to include acknowlegement bit
       i2c.<span style="color: #a535ae;">stop</span>();
       printf("%d\n\r",result);
       return result;
    }
    
    <span style="color: #ff5600;">int</span> <span style="color: #21439c;">getCode</span>(){
        int code = 0;
        i2cRead(0);
        code = ( (<span style="color: #a535ae;">i2cRead</span>(1)) * 1000 ) + code;
        code = ( (<span style="color: #a535ae;">i2cRead</span>(2)) * 100 ) + code;
        code = ( (<span style="color: #a535ae;">i2cRead</span>(3)) * 10 ) + code;
        code = ( (<span style="color: #a535ae;">i2cRead</span>(4)) * 1 ) + code;  
        printf(" \n\r");
        printf("end code read");
        printf(" \n\r");
        return code;
    }
    
    <span style="color: #ff5600;">int</span> <span style="color: #21439c;">display</span> (volatile int n){
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
    
    <span style="color: #ff5600;">int</span> <span style="color: #21439c;">debounce</span>(){
        initial = timer.<span style="color: #a535ae;">read_ms</span>();
        while((timer.<span style="color: #a535ae;">read_ms</span>() - initial) < 10){
        }
        if((upPin == 1) || (downPin == 1) || (enterPin == 1)){
            return 1;
        }
    }
    
    <span style="color: #ff5600;">void</span> <span style="color: #21439c;">up</span>(){
        if(<span style="color: #a535ae;">debounce</span>()){
            current = current + 1;
            cs = 0;
            spi.<span style="color: #a535ae;">write</span>(<span style="color: #a535ae;">display</span>(current));
            cs = 1;
            if(current > 9){
                current = 0;
                cs = 0;
                spi.<span style="color: #a535ae;">write</span>(<span style="color: #a535ae;">display</span>(current));
                cs = 1;
            }
        }
    }
    
    <span style="color: #ff5600;">void</span> <span style="color: #21439c;">down</span>(){
        if(<span style="color: #a535ae;">debounce</span>()){
            current = current - 1;
            cs = 0;
            spi.<span style="color: #a535ae;">write</span>(<span style="color: #a535ae;">display</span>(current));
            cs = 1;
            if(current < 0){
                current = 9;
                cs = 0;
                spi.<span style="color: #a535ae;">write</span>(<span style="color: #a535ae;">display</span>(current));
                cs = 1;
            }
        }
    }
    
    <span style="color: #ff5600;">void</span> <span style="color: #21439c;">enter</span>(){
        if(mode == 0){
            if(<span style="color: #a535ae;">debounce</span>()){
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
            if(<span style="color: #a535ae;">debounce</span>()){
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
    
    
    
    <span style="color: #ff5600;">void</span> <span style="color: #21439c;">userMode</span>(){
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
        spi.<span style="color: #a535ae;">write</span>(<span style="color: #a535ae;">display</span>(0));
        cs = 1;
    
        while(digit < 5) {
        }
        
    
        printf("codeAttempt: %d", codeAttempt);
        printf(" \n\r");
    
        if((int)code == (int)codeAttempt) {
            cs = 0;
            spi.<span style="color: #a535ae;">write</span>(<span style="color: #a535ae;">display</span>(11));
            cs = 1;
            while(1) {
                led1 = led2 = led3 = led4 = 1;
                wait(.25);
                led1 = led2 = led3 = led4 = 0;
                wait(.25);
            }
        }
        cs = 0;
        spi.<span style="color: #a535ae;">write</span>(<span style="color: #a535ae;">display</span>(10));
        cs = 1;
    
        wait(3);
    
        cs = 0;
        spi.<span style="color: #a535ae;">write</span>(<span style="color: #a535ae;">display</span>(0));
        cs = 1;
    }
    
    <span style="color: #ff5600;">void</span> <span style="color: #21439c;">servMode</span>(){
        codeAttempt = 0;
        digit = 1;
        current = 0;
        initial = 0;
        mode = 1;
    
        led1 = led2 = led3 = led4 = 0;
    
        cs = 0;
        spi.<span style="color: #a535ae;">write</span>(<span style="color: #a535ae;">display</span>(0));
        cs = 1;
    
        while(digit < 5) {
        }
        
        for(int digit = 1; digit < 5; digit++){
            cs = 0;
            spi.<span style="color: #a535ae;">write</span>(<span style="color: #a535ae;">display</span>(<span style="color: #a535ae;">i2cRead</span>(digit)));
            cs = 1;
            wait(1);
        }
        cs = 0;
        spi.<span style="color: #a535ae;">write</span>(0x00);
        cs = 1;
        while(1){
            //infinite loop
        }
        
    }
    
    
     
    <span style="color: #ff5600;">int</span> <span style="color: #21439c;">main</span>() {
        upPin.<span style="color: #a535ae;">mode</span>(PullDown);
        downPin.<span style="color: #a535ae;">mode</span>(PullDown);
        enterPin.<span style="color: #a535ae;">mode</span>(PullDown);
        upPin.<span style="color: #a535ae;">rise</span>(&up);
        downPin.<span style="color: #a535ae;">rise</span>(&down);
        enterPin.<span style="color: #a535ae;">rise</span>(&enter);
        timer.<span style="color: #a535ae;">start</span>();
     
        spi.<span style="color: #a535ae;">format</span>(8,0);
        spi.<span style="color: #a535ae;">frequency</span>(1000000);
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

    
    <span style="color: #ff5600;">void</span> dip27high(){
        FIO0PIN |<span style="color: #ff5600;">=</span> (1<<11);
        __DSB();
    }
    


which wrote a 1 to the eleventh bit of of the FIO0 register.  I realize now that a more proper way to implement this functionality would have been to created a function that accepted as its parameters the pin to be manipulated and the state to write to that pin much like the built-in mbed library; however, this worked perfectly well for this assignment and was a nice exercise in understanding how libraries work.

    
    #include <span style="color: #00a33f;">"mbed.h"</span>
    
    #define FIO0PIN (<span style="color: #ff5600;">*</span>(volatile unsigned <span style="color: #ff5600;">int</span> <span style="color: #ff5600;">*</span>)0x2009c014)
    #define FIO0DIR (<span style="color: #ff5600;">*</span>(volatile unsigned <span style="color: #ff5600;">int</span> <span style="color: #ff5600;">*</span>)0x2009c000)
    #define FIO1PIN (<span style="color: #ff5600;">*</span>(volatile unsigned <span style="color: #ff5600;">int</span> <span style="color: #ff5600;">*</span>)0x2009c034)
    #define FIO1DIR (<span style="color: #ff5600;">*</span>(volatile unsigned <span style="color: #ff5600;">int</span> <span style="color: #ff5600;">*</span>)0x2009c020)
    #define PINMODE0 (<span style="color: #ff5600;">*</span>(volatile unsigned <span style="color: #ff5600;">int</span> <span style="color: #ff5600;">*</span>)0x4002c040)
    #define PINMODE1 (<span style="color: #ff5600;">*</span>(volatile unsigned <span style="color: #ff5600;">int</span> <span style="color: #ff5600;">*</span>)0x4002c044)
    #define PINMODE3 (<span style="color: #ff5600;">*</span>(volatile unsigned <span style="color: #ff5600;">int</span> <span style="color: #ff5600;">*</span>)0x4002c04c)
    #define PINSEL0 (<span style="color: #ff5600;">*</span>(volatile unsigned <span style="color: #ff5600;">int</span> <span style="color: #ff5600;">*</span>)0x4002c000)
    #define PINSEL1 (<span style="color: #ff5600;">*</span>(volatile unsigned <span style="color: #ff5600;">int</span> <span style="color: #ff5600;">*</span>)0x4002c004)
    #define PINSEL3 (<span style="color: #ff5600;">*</span>(volatile unsigned <span style="color: #ff5600;">int</span> <span style="color: #ff5600;">*</span>)0x4002c00c)
    #define PCONP (<span style="color: #ff5600;">*</span>(volatile unsigned <span style="color: #ff5600;">int</span> <span style="color: #ff5600;">*</span>)0x400fc0c4)
    #define PCLKSEL0 (<span style="color: #ff5600;">*</span>(volatile unsigned <span style="color: #ff5600;">int</span> <span style="color: #ff5600;">*</span>)0x400fc1a8)
    #define AD0CR (<span style="color: #ff5600;">*</span>(volatile unsigned <span style="color: #ff5600;">int</span> <span style="color: #ff5600;">*</span>)0x40034000)
    #define AD0GDR (<span style="color: #ff5600;">*</span>(volatile unsigned <span style="color: #ff5600;">int</span> <span style="color: #ff5600;">*</span>)0x40034004)
    
    <span style="color: #919191;">//DIP5    P0.9</span>
    <span style="color: #919191;">//DIP6    P0.8</span>
    <span style="color: #919191;">//DIP27   P0.11</span>
    <span style="color: #919191;">//DIP28   P0.10</span>
    <span style="color: #919191;">//DIP29   P0.5</span>
    <span style="color: #919191;">//DIP30   P0.4</span>
    
    Timer timer;
    
    <span style="color: #ff5600;">float</span> delay <span style="color: #ff5600;">=</span> .20;
    
    <span style="color: #ff5600;">int</span> status <span style="color: #ff5600;">=</span> 0;
    <span style="color: #ff5600;">int</span> hit <span style="color: #ff5600;">=</span> 1;
    <span style="color: #ff5600;">int</span> miss <span style="color: #ff5600;">=</span> 0;
    <span style="color: #ff5600;">float</span> shift <span style="color: #ff5600;">=</span> 3.0;
    <span style="color: #ff5600;">int</span> points1 <span style="color: #ff5600;">=</span> 0;
    <span style="color: #ff5600;">int</span> points2 <span style="color: #ff5600;">=</span> 0;
    <span style="color: #ff5600;">int</span> <span style="color: #a535ae;">play</span> <span style="color: #ff5600;">=</span> 0;
    
    
    <span style="color: #ff5600;">void</span> setup(<span style="color: #ff5600;">void</span>){
        <span style="color: #919191;">//Digital inputs</span>
        FIO0DIR <span style="color: #ff5600;">&</span><span style="color: #ff5600;">=</span> ~(1<<9);   <span style="color: #919191;">//set to 0</span>
        __DSB();
        FIO0DIR <span style="color: #ff5600;">&</span><span style="color: #ff5600;">=</span> ~(1<<8);   <span style="color: #919191;">//set to 0</span>
        
        <span style="color: #919191;">//Digital outputs</span>
        FIO0DIR |<span style="color: #ff5600;">=</span> (1<<11) | (1<<10) | (1<<5) | (1<<4);    <span style="color: #919191;">//set to 1</span>
        __DSB();
        FIO1DIR |<span style="color: #ff5600;">=</span> (1<<18) | (1<<20) | (1<<21) | (1<<23);
        
        PINMODE0 |<span style="color: #ff5600;">=</span> (3<<18);   <span style="color: #919191;">//pull-down resistor on DIP5</span>
        __DSB();
        PINMODE0 |<span style="color: #ff5600;">=</span> (3<<16);   <span style="color: #919191;">//Pull-down resistor on DIP6</span>
        
    }
    
    <span style="color: #ff5600;">int</span> button1(<span style="color: #ff5600;">void</span>){
        <span style="color: #ff5600;">if</span>(FIO0PIN <span style="color: #ff5600;">&</span> (1<<9))
            <span style="color: #ff5600;">return</span> 1;
        <span style="color: #ff5600;">else</span>
            <span style="color: #ff5600;">return</span> 0;
    }
    
    <span style="color: #ff5600;">int</span> button2(<span style="color: #ff5600;">void</span>){
        <span style="color: #ff5600;">if</span>(FIO0PIN <span style="color: #ff5600;">&</span> (1<<8))
            <span style="color: #ff5600;">return</span> 1;
        <span style="color: #ff5600;">else</span>
            <span style="color: #ff5600;">return</span> 0;
    }
    
    <span style="color: #ff5600;">void</span> dip27high(){
        FIO0PIN |<span style="color: #ff5600;">=</span> (1<<11);
        __DSB();
    }
    
    <span style="color: #ff5600;">void</span> dip27low(){
        FIO0PIN <span style="color: #ff5600;">&</span><span style="color: #ff5600;">=</span> ~(1<<11);
        __DSB();
    }
    
    <span style="color: #ff5600;">void</span> dip28high(){
        FIO0PIN |<span style="color: #ff5600;">=</span> (1<<10);
        __DSB();
    }
    
    <span style="color: #ff5600;">void</span> dip28low(){
        FIO0PIN <span style="color: #ff5600;">&</span><span style="color: #ff5600;">=</span> ~(1<<10);
        __DSB();
    }
    
    <span style="color: #ff5600;">void</span> dip29high(){
        FIO0PIN |<span style="color: #ff5600;">=</span> (1<<5);
        __DSB();
    }
    
    <span style="color: #ff5600;">void</span> dip29low(){
        FIO0PIN <span style="color: #ff5600;">&</span><span style="color: #ff5600;">=</span> ~(1<<5);
        __DSB();
    }
    
    <span style="color: #ff5600;">void</span> dip30high(){
        FIO0PIN |<span style="color: #ff5600;">=</span> (1<<4);
        __DSB();
    }
    
    <span style="color: #ff5600;">void</span> dip30low(){
        FIO0PIN <span style="color: #ff5600;">&</span><span style="color: #ff5600;">=</span> ~(1<<4);
        __DSB();
    }
    
    <span style="color: #ff5600;">void</span> led1high(){
        FIO1PIN |<span style="color: #ff5600;">=</span> (1<<18);
        __DSB();
    }
    
    <span style="color: #ff5600;">void</span> led1low(){
        FIO1PIN <span style="color: #ff5600;">&</span><span style="color: #ff5600;">=</span> ~(1<<18);
        __DSB();
    }
    
    <span style="color: #ff5600;">void</span> led2high(){
        FIO1PIN |<span style="color: #ff5600;">=</span> (1<<20);
        __DSB();
    }
    
    <span style="color: #ff5600;">void</span> led2low(){
        FIO1PIN <span style="color: #ff5600;">&</span><span style="color: #ff5600;">=</span> ~(1<<20);
        __DSB();
    }
    
    <span style="color: #ff5600;">void</span> led3high(){
        FIO1PIN |<span style="color: #ff5600;">=</span> (1<<21);
        __DSB();
    }
    
    <span style="color: #ff5600;">void</span> led3low(){
        FIO1PIN <span style="color: #ff5600;">&</span><span style="color: #ff5600;">=</span> ~(1<<21);
        __DSB();
    }
    
    <span style="color: #ff5600;">void</span> led4high(){
        FIO1PIN |<span style="color: #ff5600;">=</span> (1<<23);
        __DSB();
    }
    
    <span style="color: #ff5600;">void</span> led4low(){
        FIO1PIN <span style="color: #ff5600;">&</span><span style="color: #ff5600;">=</span> ~(1<<23);
        __DSB();
    }
    
    <span style="color: #ff5600;">void</span> leftRight(){
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
    
    <span style="color: #ff5600;">void</span> rightLeft(){
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
    
    <span style="color: #ff5600;">void</span> point1(){
        points1 <span style="color: #ff5600;">=</span> points1 <span style="color: #ff5600;">+</span> 1;
        <span style="color: #ff5600;">if</span>( points1 <span style="color: #ff5600;">=</span><span style="color: #ff5600;">=</span> 1 ){
            dip27high();
        }
        <span style="color: #ff5600;">if</span>( points1 <span style="color: #ff5600;">=</span><span style="color: #ff5600;">=</span> 2 ){
            dip28high();
            <span style="color: #ff5600;">while</span>(1){
                dip27high();
                wait(.10);
                dip27low();
                dip28high();
                wait(.10);
                dip28low();
            }
        }
    }
    
    <span style="color: #ff5600;">void</span> point2(){
        points2 <span style="color: #ff5600;">=</span> points2 <span style="color: #ff5600;">+</span> 1;
        <span style="color: #ff5600;">if</span>( points2 <span style="color: #ff5600;">=</span><span style="color: #ff5600;">=</span> 1 ){
            dip29high();
        }
        <span style="color: #ff5600;">if</span>( points2 <span style="color: #ff5600;">=</span><span style="color: #ff5600;">=</span> 2 ){
            dip30high();
            <span style="color: #ff5600;">while</span>(1){
                dip29high();
                wait(.10);
                dip29low();
                dip30high();
                wait(.10);
                dip30low();
            }
        }
    }
    
    
    <span style="color: #ff5600;">int</span> main() {
        setup();
        <span style="color: #ff5600;">while</span>(1){
            shift <span style="color: #ff5600;">=</span> 0;
            status <span style="color: #ff5600;">=</span> 0;
            <span style="color: #ff5600;">if</span>( (<span style="color: #a535ae;">play</span> <span style="color: #ff5600;">=</span><span style="color: #ff5600;">=</span> 0) ){<span style="color: #919191;">// || (status == 0)</span>
                <span style="color: #ff5600;">while</span>( button1() <span style="color: #ff5600;">=</span><span style="color: #ff5600;">=</span> 0 ){
                    <span style="color: #919191;">//wait</span>
                }
            }
            leftRight();
            timer.start();
            timer.reset();
            <span style="color: #ff5600;">while</span>( (timer.read_ms() <span style="color: #ff5600;">+</span> shift) < delay <span style="color: #ff5600;">*</span> 1000){
                <span style="color: #ff5600;">if</span>( button1() ){
                    status <span style="color: #ff5600;">=</span> hit;
                    shift <span style="color: #ff5600;">=</span> 1001;
                }
            }
            led4low();
            <span style="color: #ff5600;">if</span>(status){
            }
            <span style="color: #ff5600;">else</span>{
                point2();
                <span style="color: #ff5600;">while</span>( button1() <span style="color: #ff5600;">=</span><span style="color: #ff5600;">=</span> 0 ){
                    <span style="color: #919191;">//wait</span>
                }
            }
            
            
            shift <span style="color: #ff5600;">=</span> 0;
            status <span style="color: #ff5600;">=</span> 0;
            rightLeft();
            timer.reset();
            <span style="color: #ff5600;">while</span>( (timer.read_ms() <span style="color: #ff5600;">+</span> shift) < delay <span style="color: #ff5600;">*</span> 1000){
                <span style="color: #ff5600;">if</span>( button2() ){
                    status <span style="color: #ff5600;">=</span> hit;
                    shift <span style="color: #ff5600;">=</span> 1001;    
                }    
            }
            led1low();
            <span style="color: #ff5600;">if</span>(status){
            }
            <span style="color: #ff5600;">else</span>{
                point1();
                <span style="color: #ff5600;">while</span>( <span style="color: #ff5600;">!</span>button2() ){
                    <span style="color: #919191;">//wait</span>
                }
            }
            <span style="color: #a535ae;">play</span><span style="color: #ff5600;">+</span><span style="color: #ff5600;">+</span>;
            
        }
    }
    
    
