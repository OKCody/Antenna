[![PopcornSpectrogram](http://codyalantaylor.com/wp-content/uploads/2015/04/PopcornSpectrogram.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/04/PopcornSpectrogram.jpg)

Because mircowaves are noisy, I thought it best to filter out as much of that noise as possible such that only the popping of kernels is recorded.  To do this I recorded the sound of popcorn popping in a microwave and passed that audio file through a MatLab spectrogram function in order to determine which frequencies needed to be filtered out. I chose to make a pretty narrow filter centered around 2kHz in order to isolate the frequencies of a popping kernel as the pop seems to include nearly equal amounts of all audible frequencies as indicated by the red vertical lines in the spectrogram above.  Below is the response of the butterworth filter that I made.

[![BandpassFilter](http://codyalantaylor.com/wp-content/uploads/2015/04/BandpassFilter.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/04/BandpassFilter.jpg)





The code running on the microcontroller is pretty simple. It calculates a running average in order to tell a pop from noise.  It also prints its readings as text which can be pulled into a spreadsheet and visualized. The code is below.




    #include <math.h>

    int popLED = A4;
    int redLED = A3;
    int yellowLED = A2;
    int greenLED = A1;
    int popCount = 0;
    float sensorValue = 0;
    float n = 0;
    float mean = 0;
    float maxSample = 0;
    float buffer = 0;
    float oldMax = 0;
    float sample = 0;
    float stdDev = 0;
    float avgStdDev = 0;
    float sum = 0;
    unsigned long lastPop;

    void setup() {

    pinMode( popLED, OUTPUT );
    pinMode( redLED, OUTPUT );
    pinMode( yellowLED, OUTPUT );
    pinMode( greenLED, OUTPUT );

    Serial.begin(9600);

    Serial.print( "Time" );
    Serial.print( " " );
    Serial.print( "Sample" );
    Serial.print( " " );
    Serial.print( "Std.Devs." );
    Serial.print( " " );
    Serial.println( "Millis_Since_Pop" );

    //prime mean value

    for( int n = 0; n < 1000; n++ ){
    mean += analogRead(A0);    
    maxSample = analogRead(A0);
    if( maxSample > oldMax ){
      oldMax = maxSample;
    }
    }
    mean = mean / 1000.0;  
    Serial.print( "mean: " );
    Serial.println( mean );

    buffer = oldMax - mean;

    float n = 0.0;
    }

    void loop() {

    n++;

    sample = analogRead(A0);
    sum += sample;
    mean = sum / n;

    stdDev = sqrt( ( (sample - mean) * (sample - mean) ) / n);
    avgStdDev = (stdDev + avgStdDev) / n;

    if( sample <= (mean - (7)) || sample >= (mean + (7)) ){  //consider it a pop if between thresholds
    //    if( stdDev >= .25){
    lastPop = millis();
    digitalWrite( popLED, HIGH );
    delay( 50 );
    digitalWrite( popLED, LOW );
    popCount++;
    }
    if( (popCount <= 25) ){
    digitalWrite( greenLED, HIGH );
    digitalWrite( yellowLED, LOW );
    digitalWrite( redLED, LOW );
    }
    if( ( (popCount > 25) ) && ( (millis() - lastPop) < 2000 )){
    digitalWrite( greenLED, LOW );
    digitalWrite( yellowLED, HIGH );
    digitalWrite( redLED, LOW );
    }
    if( ( (popCount > 25) ) && ( (millis() - lastPop) > 2000 ) ){
    digitalWrite( greenLED, LOW );
    digitalWrite( yellowLED, LOW );
    digitalWrite( redLED, HIGH );
    }  

    Serial.print( millis() );
    Serial.print( " " );
    Serial.print( mean );
    Serial.print( " " );
    Serial.print( sample );
    Serial.print( " " );
    Serial.print( avgStdDev );
    Serial.print( " " );
    Serial.print( stdDev );  //( (sample - mean) / stdDev );
    Serial.print( " " );
    Serial.println( millis() - lastPop );
    }




The schematics for the filters are below

Highpass Filter:

[![HighpassSchem](http://codyalantaylor.com/wp-content/uploads/2015/04/HighpassSchem.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/04/HighpassSchem.jpg)

Lowpass Filter:

[![lowpass](http://codyalantaylor.com/wp-content/uploads/2015/04/lowpass.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/04/lowpass.jpg)



Gain Stage:

[![gainstage](http://codyalantaylor.com/wp-content/uploads/2015/04/gainstage.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/04/gainstage.jpg)

Although I received a low A grade for this project, it didn't work all that great. I suppose that most of the credit I earned lies in the design -that is using a spectrogram and designing filters because the actual implementation was a bit of a flop. I think that with more time this design could possibly be made to work a little better if not as intended. As it is, a larger than acceptable proportion of pops are missed by the device. This results in inaccurate timing and ultimately imperfectly cooked popcorn. I may revisit it at some point if I need a project to work on or happen to think of a better way to implement it.
