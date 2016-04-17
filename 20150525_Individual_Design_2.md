[![PopcornSpectrogram](http://codyalantaylor.com/wp-content/uploads/2015/04/PopcornSpectrogram.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/04/PopcornSpectrogram.jpg)

Because mircowaves are noisy, I thought it best to filter out as much of that noise as possible such that only the popping of kernels is recorded.  To do this I recorded the sound of popcorn popping in a microwave and passed that audio file through a MatLab spectrogram function in order to determine which frequencies needed to be filtered out. I chose to make a pretty narrow filter centered around 2kHz in order to isolate the frequencies of a popping kernel as the pop seems to include nearly equal amounts of all audible frequencies as indicated by the red vertical lines in the spectrogram above.  Below is the response of the butterworth filter that I made.

[![BandpassFilter](http://codyalantaylor.com/wp-content/uploads/2015/04/BandpassFilter.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/04/BandpassFilter.jpg)





The code running on the microcontroller is pretty simple. It calculates a running average in order to tell a pop from noise.  It also prints its readings as text which can be pulled into a spreadsheet and visualized. The code is below.



    
    #include <math.h>
    
    <span style="color: #cc6600;">int</span> popLED = A4;
    <span style="color: #cc6600;">int</span> redLED = A3;
    <span style="color: #cc6600;">int</span> yellowLED = A2;
    <span style="color: #cc6600;">int</span> greenLED = A1;
    <span style="color: #cc6600;">int</span> popCount = 0;
    <span style="color: #cc6600;">float</span> sensorValue = 0;
    <span style="color: #cc6600;">float</span> n = 0;
    <span style="color: #cc6600;">float</span> mean = 0;
    <span style="color: #cc6600;">float</span> maxSample = 0;
    <span style="color: #cc6600;">float</span> buffer = 0;
    <span style="color: #cc6600;">float</span> oldMax = 0;
    <span style="color: #cc6600;">float</span> sample = 0;
    <span style="color: #cc6600;">float</span> stdDev = 0;
    <span style="color: #cc6600;">float</span> avgStdDev = 0;
    <span style="color: #cc6600;">float</span> sum = 0;
    <span style="color: #cc6600;">unsigned</span> <span style="color: #cc6600;">long</span> lastPop;
    
    <span style="color: #cc6600;">void</span> <span style="color: #cc6600;"><b>setup</b></span>() {
        
      <span style="color: #cc6600;">pinMode</span>( popLED, <span style="color: #006699;">OUTPUT</span> );
      <span style="color: #cc6600;">pinMode</span>( redLED, <span style="color: #006699;">OUTPUT</span> );
      <span style="color: #cc6600;">pinMode</span>( yellowLED, <span style="color: #006699;">OUTPUT</span> );
      <span style="color: #cc6600;">pinMode</span>( greenLED, <span style="color: #006699;">OUTPUT</span> );
      
      <span style="color: #cc6600;"><b>Serial</b></span>.<span style="color: #cc6600;">begin</span>(9600);
      
      <span style="color: #cc6600;"><b>Serial</b></span>.<span style="color: #cc6600;">print</span>( <span style="color: #006699;">"Time"</span> );
      <span style="color: #cc6600;"><b>Serial</b></span>.<span style="color: #cc6600;">print</span>( <span style="color: #006699;">" "</span> );
      <span style="color: #cc6600;"><b>Serial</b></span>.<span style="color: #cc6600;">print</span>( <span style="color: #006699;">"Sample"</span> );
      <span style="color: #cc6600;"><b>Serial</b></span>.<span style="color: #cc6600;">print</span>( <span style="color: #006699;">" "</span> );
      <span style="color: #cc6600;"><b>Serial</b></span>.<span style="color: #cc6600;">print</span>( <span style="color: #006699;">"Std.Devs."</span> );
      <span style="color: #cc6600;"><b>Serial</b></span>.<span style="color: #cc6600;">print</span>( <span style="color: #006699;">" "</span> );
      <span style="color: #cc6600;"><b>Serial</b></span>.<span style="color: #cc6600;">println</span>( <span style="color: #006699;">"Millis_Since_Pop"</span> );
      
      <span style="color: #7e7e7e;">//prime mean value</span>
      
      <span style="color: #cc6600;">for</span>( <span style="color: #cc6600;">int</span> n = 0; n < 1000; n++ ){
        mean += <span style="color: #cc6600;">analogRead</span>(A0);    
        maxSample = <span style="color: #cc6600;">analogRead</span>(A0);
        <span style="color: #cc6600;">if</span>( maxSample > oldMax ){
          oldMax = maxSample;
        }
      }
      mean = mean / 1000.0;  
      <span style="color: #cc6600;"><b>Serial</b></span>.<span style="color: #cc6600;">print</span>( <span style="color: #006699;">"mean: "</span> );
      <span style="color: #cc6600;"><b>Serial</b></span>.<span style="color: #cc6600;">println</span>( mean );
      
      buffer = oldMax - mean;
      
      <span style="color: #cc6600;">float</span> n = 0.0;
    }
    
    <span style="color: #cc6600;">void</span> <span style="color: #cc6600;"><b>loop</b></span>() {
      
      n++;
    
      sample = <span style="color: #cc6600;">analogRead</span>(A0);
      sum += sample;
      mean = sum / n;
      
      stdDev = <span style="color: #cc6600;">sqrt</span>( ( (sample - mean) * (sample - mean) ) / n);
      avgStdDev = (stdDev + avgStdDev) / n;
      
      <span style="color: #cc6600;">if</span>( sample <= (mean - (7)) || sample >= (mean + (7)) ){  <span style="color: #7e7e7e;">//consider it a pop if between thresholds</span>
    <span style="color: #7e7e7e;">//    if( stdDev >= .25){</span>
        lastPop = <span style="color: #cc6600;">millis</span>();
        <span style="color: #cc6600;">digitalWrite</span>( popLED, <span style="color: #006699;">HIGH</span> );
        <span style="color: #cc6600;">delay</span>( 50 );
        <span style="color: #cc6600;">digitalWrite</span>( popLED, <span style="color: #006699;">LOW</span> );
        popCount++;
      } 
      <span style="color: #cc6600;">if</span>( (popCount <= 25) ){
        <span style="color: #cc6600;">digitalWrite</span>( greenLED, <span style="color: #006699;">HIGH</span> );
        <span style="color: #cc6600;">digitalWrite</span>( yellowLED, <span style="color: #006699;">LOW</span> );
        <span style="color: #cc6600;">digitalWrite</span>( redLED, <span style="color: #006699;">LOW</span> );
      }
      <span style="color: #cc6600;">if</span>( ( (popCount > 25) ) && ( (<span style="color: #cc6600;">millis</span>() - lastPop) < 2000 )){
        <span style="color: #cc6600;">digitalWrite</span>( greenLED, <span style="color: #006699;">LOW</span> );
        <span style="color: #cc6600;">digitalWrite</span>( yellowLED, <span style="color: #006699;">HIGH</span> );
        <span style="color: #cc6600;">digitalWrite</span>( redLED, <span style="color: #006699;">LOW</span> );
      }
      <span style="color: #cc6600;">if</span>( ( (popCount > 25) ) && ( (<span style="color: #cc6600;">millis</span>() - lastPop) > 2000 ) ){
        <span style="color: #cc6600;">digitalWrite</span>( greenLED, <span style="color: #006699;">LOW</span> );
        <span style="color: #cc6600;">digitalWrite</span>( yellowLED, <span style="color: #006699;">LOW</span> );
        <span style="color: #cc6600;">digitalWrite</span>( redLED, <span style="color: #006699;">HIGH</span> );
      }  
      
      <span style="color: #cc6600;"><b>Serial</b></span>.<span style="color: #cc6600;">print</span>( <span style="color: #cc6600;">millis</span>() );
      <span style="color: #cc6600;"><b>Serial</b></span>.<span style="color: #cc6600;">print</span>( <span style="color: #006699;">" "</span> );
      <span style="color: #cc6600;"><b>Serial</b></span>.<span style="color: #cc6600;">print</span>( mean );
      <span style="color: #cc6600;"><b>Serial</b></span>.<span style="color: #cc6600;">print</span>( <span style="color: #006699;">" "</span> );
      <span style="color: #cc6600;"><b>Serial</b></span>.<span style="color: #cc6600;">print</span>( sample );
      <span style="color: #cc6600;"><b>Serial</b></span>.<span style="color: #cc6600;">print</span>( <span style="color: #006699;">" "</span> );
      <span style="color: #cc6600;"><b>Serial</b></span>.<span style="color: #cc6600;">print</span>( avgStdDev );
      <span style="color: #cc6600;"><b>Serial</b></span>.<span style="color: #cc6600;">print</span>( <span style="color: #006699;">" "</span> );
      <span style="color: #cc6600;"><b>Serial</b></span>.<span style="color: #cc6600;">print</span>( stdDev );  <span style="color: #7e7e7e;">//( (sample - mean) / stdDev );</span>
      <span style="color: #cc6600;"><b>Serial</b></span>.<span style="color: #cc6600;">print</span>( <span style="color: #006699;">" "</span> );
      <span style="color: #cc6600;"><b>Serial</b></span>.<span style="color: #cc6600;">println</span>( <span style="color: #cc6600;">millis</span>() - lastPop );
    }
    
    


The schematics for the filters are below

Highpass Filter:

[![HighpassSchem](http://codyalantaylor.com/wp-content/uploads/2015/04/HighpassSchem.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/04/HighpassSchem.jpg)

Lowpass Filter:

[![lowpass](http://codyalantaylor.com/wp-content/uploads/2015/04/lowpass.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/04/lowpass.jpg)



Gain Stage:

[![gainstage](http://codyalantaylor.com/wp-content/uploads/2015/04/gainstage.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/04/gainstage.jpg)

Although I received a low A grade for this project, it didn't work all that great. I suppose that most of the credit I earned lies in the design -that is using a spectrogram and designing filters because the actual implementation was a bit of a flop. I think that with more time this design could possibly be made to work a little better if not as intended. As it is, a larger than acceptable proportion of pops are missed by the device. This results in inaccurate timing and ultimately imperfectly cooked popcorn. I may revisit it at some point if I need a project to work on or happen to think of a better way to implement it.
