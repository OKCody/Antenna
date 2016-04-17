
To begin the simulation, let's begin with the well known relationship,

$$area=\pi r^2$$.

To eliminate the radius component from this equation, let us assume that the circle we are integrating has a radius of one.  From this it is obvious that the area of a circle with a radius of one is equal to pi.

$$area=\pi$$

To find the area of a circle requires that we integrate its surface; however, because computers perform discrete, rather than continuous calculations, what would be an integration operation becomes a very large summation.  In the case of this example, we are going to start with a shape of known area.  -a square.  Because we're interested in the area of a circle we will inscribe the circle of interest inside the square which consequentially has a side length of twice the circle's radius.


![](http://codyalantaylor.com/images/circlesquare.svg)

Because we know the area of the square, we can find the area of the circle in terms of the square's area.  To begin our infinite sum let us randomly assign a value between 0 and 1 to each, the x and y-component of a coordinate pair.


    x = ( randNum1 = ( double ) random (randMax) / randMax );
    y = ( randNum2 = ( double ) random (randMax) / randMax );


If the resultant point happens to fall within the circle, count it.  The area of the circle will be the ratio of points that fall within the square to the total points generated.


    for( i = 0; i < points; i++ ){

      x = ( randNum1 = (double) random(randMax) / randMax );
      y = ( randNum2 = (double) random(randMax) / randMax );         
      if( sqrt( ( x * x ) + ( y * y ) ) <= 1 ){
        inCount++;
      }  
    }


In order to simplify the code we can exploit the symmetry of the problem and only generate points that fall within the first quadrant of the square.  Four times this ratio is our calculated value of pi.

[caption id="attachment_64" align="aligncenter" width="500"][![Pi_30K](http://codyalantaylor.com/wp-content/uploads/2014/10/Pi_30K.gif)](Image Credit: Wikimedia Commons CaitlinJo) [Image Credit: Wikimedia Commons CaitlinJo](http://commons.wikimedia.org/wiki/File:Pi_30K.gif)[/caption]

The complete Arduino sketch is below.  I've used it as an example because it's code shows the logic of this example most plainly.  I have performed this same example it C++, Javascript, and Python.  I will post those examples soon.


    #include <SoftwareSerial.h>

    SoftwareSerial comm(2,3);
    double points = 100000;
    double randMax = 1000;

    double piCalc (double points )
    	{
    		double x = 0;
    		double y = 0;
                    double i;
    		double inCount = 0;
    		double pi;
                    double randNum1;
                    double randNum2;


    		for ( i = 0; i < points; i++ )
    		{
    			x = ( randNum1 = ( double ) random (randMax) / randMax );
    			y = ( randNum2 = ( double ) random (randMax) / randMax );

    			if ( sqrt ( ( x * x ) + ( y * y ) ) <= 1 )
    			{
    				inCount++;
    			}
    		}

    		pi = ( inCount / points ) * 4.0;

    		Serial.print("inCount: ");
                    Serial.println(inCount);
                    Serial.print("total: ");
                    Serial.println(i);
                    Serial.println(pi);
                    Serial.println(" ");

    	}


    void setup() {    
      Serial.begin(9600);  
      randomSeed(analogRead(0));
      piCalc( points );
    }


    void loop() {

    }




As I mentioned at the beginning of this explanation, this is not a terribly efficient method for calculating pi.  One should not expect this to be terribly quick or accurate.  It is; however, very comprehensible and is a neat exercise.   My first attempt at coding this was in C++.  At the time I was an intern for the Air Force working at Tinker Air Force base.  I was tasked with learning how to write code that could be distributed across what most would call a supercomputer.  My most extravagant attempt at this calculation was executed on 240 compute nodes and did not yield results any more accurate than what can be done with an Arduino.  This calculation method is entirely dependent upon the algorithm used for randomly generating the point coordinates.  Because what I'm calling 'random numbers' here are truly pseudo-random numbers. The numbers generated are predictable and will eventually repeat.  The limiting factor here is how evenly distributed the generated random numbers are.  In the ideal case, each generated point will be just as likely to fall within the arc of the circle as outside. If this distribution is slightly off, so will be the estimated value of pi.

[caption id="attachment_103" align="alignnone" width="667"][![2014-01-02-15.20](http://codyalantaylor.com/wp-content/uploads/2014/10/2014-01-02-15.20.jpg)](http://codyalantaylor.com/wp-content/uploads/2014/10/2014-01-02-15.20.jpg) Results from 240 node high performance computer.[/caption]
