
## Problem 1:  Diode Differences


Input a 0V to 3V (Use DC offset on function generator), 50% duty cycle, 10 kHz square wave to the anode of the following diodes (1N914, IN4007, and BAT85) and connect the cathode to ground via one resistor that will assure the diode’s current rating will not be exceeded for any of them.  Overlay the input voltage and voltage across the resistor (**no autoscale**) and print **between 1 and 2 cycles** for each.  Measure and provide reasons for the primary differences of these three diodes.  Show the circuit diagrams used for all three and the calculations made to verify the current limit was not exceeded for the 1N914 and BAT85 (Don’t worry about the IN4007 calculation).


### Circuit Setup:


[![diode-differences-1n914](http://codytaylor.cc/legacy-images/diode-differences-1n914.jpg)](http://codytaylor.cc/legacy-images/diode-differences-1n914.jpg)

[![bat85](http://codytaylor.cc/legacy-images/bat85.jpg)](http://codytaylor.cc/legacy-images/bat85.jpg)


### Current Limit Calculations & Voltage Drop:




#### 1N914




\(\frac{3v-1v}{1k\Omega} = 2mA << 75mA\) current limit




1v Voltage Drop




[![1N914-Voltage-Drop](http://codytaylor.cc/legacy-images/1N914-Voltage-Drop.jpg)](http://codytaylor.cc/legacy-images/1N914-Voltage-Drop.jpg)





#### 1N4007




\(\frac{3v-1v}{1k\Omega}=.2mA << 1A\) current limit




600mV Voltage Drop




[![1N4007-Voltage-Drop](http://codytaylor.cc/legacy-images/1N4007-Voltage-Drop.jpg)](http://codytaylor.cc/legacy-images/1N4007-Voltage-Drop.jpg)





#### BAT85




\(\frac{3v-.3v}{1k\Omega} = 2.7mA << 200mA\) current limit




300mV Voltage Drop




[![BAT85-Voltage-Drop](http://codytaylor.cc/legacy-images/BAT85-Voltage-Drop.jpg)](http://codytaylor.cc/legacy-images/BAT85-Voltage-Drop.jpg)





### Conclusion


The main thing to note about this lab exercise is that not all diodes adhere to the .7v drop assumption and that some diodes switch on and off more quickly than others.  The 1N914 signal diode and BAT85 schottky diode switch very quickly while the 1n4007 rectifier diode is slow, but has a relatively larger maximum current rating.


## Problem 2:  DC Diode Circuits




Design a circuit using only resistors, a potentiometer, and a red and green LED. The circuit must have only the red LED **brightly lit** (Make ID between 5 and 20 mA) when the potentiometer is turned all the way one direction and only the green LED brightly lit when the potentiometer is turned all the way in the other direction.  Measure the current and compare it to your calculations.





### Circuit Setup


[![problem-2](http://codytaylor.cc/legacy-images/problem-2.jpg)](http://codytaylor.cc/legacy-images/problem-2.jpg)




### Current Calculations & Measurements




$$I_D=\frac{15v-.7v}{1k\Omega} = 14.3mA; 5mA (minimum current) < 14.3mA < 20 (maximum current)$$




Measured current:  \(I_D = 13.7 mA\)





### Conclusion


In this circuit, a large potentiometer value was chosen in order to ensure most of the current in the circuit is directed through the selected LED.  Because the wiper of the potentiometer is connected between the two LEDs, it forms a variable voltage divider where that applies a fraction of the source voltage across each LED-resistor pair.  In the extreme positions of the potentiometer's range, the full 10K[latex]\Omega[/latex] drops the full 15v across one LED-resistor pair, while forming a short in parallel with the other LED-resistor pair.  In lab we confirmed our own curiosity that both LEDs could be turned on when the wiper was positioned in the center of its range.  In this position, 7.5v was applied across each LED-resistor pair and each passed about 7mA of current.


## Problem 3:  Clamper Circuit


Design a circuit that will convert a 50% duty cycle square wave that goes from - 3V to + 3V to a 50% duty cycle square wave that goes from 0V to – 6V (+/- 0.5V).


### Circuit Setup


[![clamper-circuit](http://codytaylor.cc/legacy-images/clamper-circuit.jpg)](http://codytaylor.cc/legacy-images/clamper-circuit.jpg)



The values for the resistor R and capacitor C should be determined from the time constant equation of the circuit, t = RC. The values must be large enough to make sure that the voltage across the capacitor C does not change significantly during the time interval the diode is non-conducting. In a good clamper circuit, the circuit time constant t = RC should be at least ten times the time period of the input signal voltage. (http://www.circuitstoday.com/diode-clamping-circuits)


### Measurement


[![clamper-circuit](http://codytaylor.cc/legacy-images/clamper-circuit1.jpg)](http://codytaylor.cc/legacy-images/clamper-circuit1.jpg)


### Conclusion


This is a negative clamper circuit.  It clamps the peak voltage to 0v while maintaining the same peak-to-peak voltage as the input signal.  Reversing the polarity of the schottky diode reverses the clamper circuit, now a positive clamper circuit, such that the minimum voltage is clamped to 0v while maintaining the original peak-to-peak voltage.


##  Problem 4:  Negative Rectifier


Design a circuit that will only pass through the negative cycles of 6 V p-p sine wave and reduce the negative peak voltage from -3 V to -1.6 V(+/- 0.2 V).  Show input and output on the plot.


### Circuit Setup


[![negative-rectifier](http://codytaylor.cc/legacy-images/negative-rectifier.jpg)](http://codytaylor.cc/legacy-images/negative-rectifier.jpg)



Thinking of R1 as the load of the rectifier, with a 3v peak sine wave being dropped across it, R2 and R3 form a voltage divider to drop the wave to the required -1.6v.


$$3\times\frac{11.4k\Omega}{10k\Omega+11.4k\Omega} = 1.59v$$





### Measurement


[![negative-rectifier](http://codytaylor.cc/legacy-images/negative-rectifier1.jpg)](http://codytaylor.cc/legacy-images/negative-rectifier1.jpg)

Note that in this image, the horizontal cursor is set at -1.4v.


### Conclusion


In this circuit the signal diode, 1N914, truncates the positive portion of the input sinewave.  The voltage divider comprised of R2 and R3 drop the -3v portion of the voltage swing to about -1.6v.


##  Problem 5:  Bridge Peak Rectifier


Design a peak bridge rectifier circuit with 1N4007 diodes to produce a 5 V DC (+/- 0.3 V) signal with ripple between (5 and 20%) from a 15V p-p sine wave input. You will have to use the subtract feature on the scope to show this on the scope since you are not using a transformer.


### Circuit Setup


[![bridge-peak-rectifier](http://codytaylor.cc/legacy-images/bridge-peak-rectifier.jpg)](http://codytaylor.cc/legacy-images/bridge-peak-rectifier.jpg)

Note that care must be taken to properly measure the voltage across the load of this circuit.  In Multisim, one probe and its reference may be intuitively applied across the load; however, when using the oscilloscopes in lab, two probes must be used in conjunction with the scope's 'math' function.  The ground leads of both scopes should be connected to the circuit's ground node, while the channel 1 probe should be connected to the high side of the load.  Likewise, the channel 2 probe should be connected to the low side of the load.  The voltage across the load is then channel 1 minus channel 2.

[![hand](http://codytaylor.cc/legacy-images/hand.jpg)](http://codytaylor.cc/legacy-images/hand.jpg)




### Measurement


[![bridge-peak-rectifier](http://codytaylor.cc/legacy-images/bridge-peak-rectifier1.jpg)](http://codytaylor.cc/legacy-images/bridge-peak-rectifier1.jpg)


## Problem 6:  Half Wave Peak Rectifier


Design a half wave peak rectifier circuit with BAT85 schottky diodes to produce a 9 V DC (+/- 0.3 V) signal with < 10% ripple from a 20V p-p sine wave input.


### Circuit Setup


[![6.2](http://codytaylor.cc/legacy-images/6.2.jpg)](http://codytaylor.cc/legacy-images/6.2.jpg)




### Measurement


[![6.3](http://codytaylor.cc/legacy-images/6.3.jpg)](http://codytaylor.cc/legacy-images/6.3.jpg)


###  Conclusion


Because the requirement for this problem was to have less than 10% ripple, we simply chose to use a relatively large capacitance in parallel with a voltage divider to bring the voltage across the load down to 9v.


##  Problem 7:  Zener Regulator


Design a zener regulator circuit that will provide a 9 V (+/- 0.5 V) regulated output from a 12V DC source. If we don’t have the exact zener diode you are looking for you will have to combine ones that we have. From the output of the 9V regulator circuit add a CdS cell into the circuit to dim (or turn off) an LED when you cover the CdS cell with your finger. Measure the voltage across the zener for each of the following: CdS circuit not added, CdS Cell uncovered, CdS Cell covered.


###  Circuit Setup


[![7](http://codytaylor.cc/legacy-images/7.jpg)](http://codytaylor.cc/legacy-images/7.jpg)

Note that 1N4732A has a reverse voltage drop of 4.7v.


### Measurements


Voltage across diodes with CDS uncovered:   9.3v

Voltage across diodes with CDS covered:        9.4v

CDS and LED removed from circuit:                 9.4v


### Conclusion


Using zener diodes in this way assures a very constant output voltage no matter the load attached to the circuit.


## Problem 8:  Limiter Circuit


Design a circuit that takes a sine wave that is symmetrical about the x-axis and limits the positive cycle to a predefined level. In other words it will clip positive cycles of the sine wave at the limit you set.   You must use a momentary switch in the circuit so that you can turn on or off the limiter.


### Circuit setup


[![8](http://codytaylor.cc/legacy-images/8.jpg)](http://codytaylor.cc/legacy-images/8.jpg)



This circuit clips the top half of the input waveform to no higher than .7v.




### Measurement


[![Limiter-Circuit](http://codytaylor.cc/legacy-images/Limiter-Circuit.jpg)](http://codytaylor.cc/legacy-images/Limiter-Circuit.jpg)




## Special Design Problem


Design a circuit using only diodes and resistors that implements the following digital logic circuit. Verify that all 8 possible input combinations turns a green LED on or off appropriately. For one of the states when the LED is on verify that the current is between 5 and 20 mA. You must use 3 slide toggle switches or a DIP switch in this problem (put them back in the bin when you are done). The inputs (switches) should always be forced to either ground or the positive rail voltage (i.e. don’t leave it “floating”).

[![Untitled Diagram](http://codytaylor.cc/legacy-images/Untitled-Diagram.jpg)](http://codytaylor.cc/legacy-images/Untitled-Diagram.jpg)




### Circuit Setup


[![9](http://codytaylor.cc/legacy-images/9.jpg)](http://codytaylor.cc/legacy-images/9.jpg)




### Conclusion


The most difficult part of designing this circuit, was adjusting component values just right to ensure that specific thresholds were exceeded by particular switch combinations.
