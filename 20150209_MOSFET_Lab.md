
Design a MOSFET inverter with a BS170 and use it to turn on an LED when you cover a CdS cell with your finger.


### Circuit Setup


[![Problem-1](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-1.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-1.jpg)



While building this circuit, we used several different CdS cells each with different ranges of resistances.  A rule of thumb that I found useful when designing this circuit was to make the bias resistor, R2, about half of the maximum of the range of the CdS cell.


## Problem 2: N-Channel MOSFET Switch


Build a circuit using the BS-170 n-channel MOSFET to switch a motor on when the light level increases.  Also, build a circuit that switches a motor off when the light level increases.  You MUST use a phototransistor for the light sensor.


## Circuit Setup


[![Problem-2](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-2.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-2.jpg)

For the purpose of clarity, some components in the diagrams above are merely stand-ins for parts that are not easily modeled in Multisim.  In both diagrams, the LED represents an infrared LED and the switch represents a phototransistor.  Also, in both circuits the 100[latex]\Omega[/latex] resistor, R2, represents a hobby motor.


### Configurations


a)     With light on CdS: Motor on     Without light on CdS: Motor off

b)     With light on CdS: Motor off     Without light on CdS: Motor on


## Problem 3: P-Channel MOSFET Switch


Repeat part 2) with a p-channel MOSFET (ZVP 3306).


### Circuit Setup


[![Problem-3](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-3.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-3.jpg)

For the purpose of clarity, some components in the diagrams above are merely stand-ins for parts that are not easily modeled in Multisim.  In both diagrams, the LED represents an infrared LED and the switch represents a phototransistor.  Also, in both circuits the 100 \(\Omega\) resistor, R2, represents a hobby motor.


### Configurations


a)     With light on CdS: Motor on     Without light on CdS: Motor off

b)     With light on CdS: Motor off     Without light on CdS: Motor on


## Problem 4: Bypassed Common Source Amplifier


Design a Bypassed Common Source MOSFET amplifier with one n-channel MOSFET to achieve a gain of 5 V/V (± 0.5 V/V). Calculate the theoretical gain of your circuit and compare it to the actual gain achieved.  You can use any biasing scheme other than the current mirror scheme.


### Circuit Setup


[![Problem-4](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-4.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-4.jpg)

[![Problem-4-Sim-Scope](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-4-Sim-Scope.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-4-Sim-Scope.jpg)

[![Problem-4-scope](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-4-scope.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-4-scope.jpg)

Note that the scales on the actual scope capture are not intuitively chosen.  I wish I could say this was done for a specific reason; however, I am afraid it was simply an oversight on my part.  The input signal is on channel 2 and the output is on channel 1.

During this problem we struggled to get the simulation correct before actually building the circuit.  After much struggling, we decided to go ahead and build the circuit anyway only to find that in reality the circuit performed much better than in simulation. -note the difference in scopes.  Lesson learned.

Input: 600mV peak

Output: 2.5 V peak

Gain: 4.7 V/V


## Problem 5:  Maximize the Gain


Modify the circuit in part 4) to achieve as much gain as you can.  Calculate the theoretical gain of your circuit and compare it to the actual gain achieved.


### Circuit Setup


[![Problem-5](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-5.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-5.jpg)

[![Problem-5-Sim-Scope 2](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-5-Sim-Scope-2.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-5-Sim-Scope-2.jpg)

[![Problem-5-Scope](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-5-Scope.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-5-Scope.jpg)



Again,  note that the scales on the actual scope capture are not intuitively chosen.  I wish I could say this was done for a specific reason; however, I am afraid it was simply an oversight on my part.  The input signal is on channel 2 and the output is on channel 1.

Input: 576mV peak

Output: 6V peak

Gain: 10.41V/V

I do realize that this gain is minimal compared to that achieved by other groups, but after spending a disproportionate amount of time on this problem, we decided to move on.  I admit, this problem does deserve to be revisited.


## Problem 6: Unbypassed Common Source Amplifier


Modify the circuit in part 5) to make it an Unbypassed Common-Source amplifier.  Use a potentiometer for Rs and comment on how the gain is affected at different resistance levels.  You will need to make Rs really small to get close to the same gain you achieved in part 6.  We should have 100 Ω potentiometers in the lab (if not just test it with a few different small resistors).  Be careful with power ratings on the potentiometer.  You can include a second source resistor that is bypassed to give you more control if you want to.


### Circuit Setup


[![Problem-6](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-6.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-6.jpg)

[![Problem-6-Sim-Scope](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-6-Sim-Scope.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-6-Sim-Scope.jpg)



[![Problem-6-Scope](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-6-Scope.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-6-Scope.jpg)



Input: 600mV

Output: 2.5V

Gain: 4.17 V/V


## Problem 7: Current Mirror Biasing Scheme


Build a Bypassed Common-Source amplifier using a current mirror for biasing to achieve a gain magnitude of 10 V/V (± 0.5 V/V).  Calculate the theoretical gain of your circuit and compare it to the actual gain achieved.


### Circuit Setup


[![Problem-7](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-7.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-7.jpg)



[![Problem-7-Sim-Scope](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-7-Sim-Scope.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-7-Sim-Scope.jpg)



[![Problem-7-Scope](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-7-Scope.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-7-Scope.jpg)

Input: 100mV

Output: 1V

Gain: 10V/V


## Problem 8: Hall Effect Latch Sensor


Design a circuit using a MOSFET and the SS400 series hall effect latch sensor to turn on and off an LED as a magnet is rotated (north pole facing the sensors to the south pole facing the sensor). Put the magnet on some sort of tether so you can spin it and use the oscilloscope to measure the rpm the magnet was spinning.


### Circuit Setup


[![halleffect-sensor](http://codyalantaylor.com/wp-content/uploads/2015/02/halleffect-sensor.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/halleffect-sensor.jpg)



[![Problem-8-Scope](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-8-Scope.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/Problem-8-Scope.jpg)



Frequency: 30Hz

Period: 33.33 mS

RPM: \(\frac{60sec}{period}=\frac{60sec}{33.33mS}=1800rev/min\)

Note we were able to achieve such a high RPM by fixing a magnet to the output shaft of a hobby motor while applying current to it and holding it over the hall effect sensor.


## Special Design Problem:  H-Bridge


Build a MOSFET H-Bridge and control a motor with it.  Demonstrate the forward, reverse, and braking modes.  **Bonus (+10):**  Using two IR LED/phototransistor pairs to make the motor go forward when the beam is broken on one of the IR LEDs and reverse when the beam is broken on the other IR LED.


### Circuit Setup


[![H-Bridge](http://codyalantaylor.com/wp-content/uploads/2015/02/H-Bridge.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/H-Bridge.jpg)
