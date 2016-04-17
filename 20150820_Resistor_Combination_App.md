Last semester during my Electronics Lab class, there were a few times that my partner and I needed a very specific resistor value. I got by at the time guessing values to combine and then running the numbers on my calculator to check how close the result was.  After several attempts using this method, I knew there must be a better way to find which values of resistors to combine to achieve a target value. I did find a calculator or two online that would do this but each had its own problems. One I recall wanted the user to enter all the resistor values they had on hand prior to each calculation, and another assumed that the user had all possible standard resistor values. -two extremes.

I decided to use only the resistor values provided to us in our lab kits.  I feel like those values make up the smallest range of resistors that someone serious about electronics might have on hand.  -by using the smallest range of reasonable resistor values, I'm not assuming much on the part of the user in terms of what they have access to.  Each point on the two lines below represents a possible resistor combination using the resistors in the following table.  The first line shows all possible values, and the second line shows values between 0 and 500K ohms in more detail as most combinations will fall within this range.  Note that the distribution of possible values is nearly continuous between 0 and 100K ohms and only slightly less continuous between 0 and 500K ohms.  Click on each image for a closer look.

[![Resistance-Density](http://codyalantaylor.com/wp-content/uploads/2015/08/Resistance-Density.png)](http://codyalantaylor.com/wp-content/uploads/2015/08/Resistance-Density.png)

[![Resistance-Density-Truncated](http://codyalantaylor.com/wp-content/uploads/2015/08/Resistance-Density-Truncated.png)](http://codyalantaylor.com/wp-content/uploads/2015/08/Resistance-Density-Truncated.png)



A table of resistor values used in this application is show below. All values, of course, are in ohms.


<table >
<tbody >
<tr >

10
100
1K
10K
100K
</tr>
<tr >
1.0

<td >10
</td>

<td >100
</td>

<td >1K
</td>

<td >10K
</td>

<td >100K
</td>
</tr>
<tr >
1.2

<td >12
</td>

<td >120
</td>

<td >1.2K
</td>

<td >12K
</td>

<td >120K
</td>
</tr>
<tr >
1.5

<td >15
</td>

<td >150
</td>

<td >1.5K
</td>

<td >15K
</td>

<td >150K
</td>
</tr>
<tr >
1.8

<td >18
</td>

<td >180
</td>

<td >1.8K
</td>

<td >18K
</td>

<td >180K
</td>
</tr>
<tr >
2.2

<td >22
</td>

<td >220
</td>

<td >2.2K
</td>

<td >22K
</td>

<td >220K
</td>
</tr>
<tr >
2.7

<td >27
</td>

<td >270
</td>

<td >2.7K
</td>

<td >27K
</td>

<td >270K
</td>
</tr>
<tr >
3.3

<td >33
</td>

<td >330
</td>

<td >3.3K
</td>

<td >33K
</td>

<td >330K
</td>
</tr>
<tr >
3.9

<td >39
</td>

<td >390
</td>

<td >3.9K
</td>

<td >39K
</td>

<td >390K
</td>
</tr>
<tr >
4.7

<td >47
</td>

<td >470
</td>

<td >4.7K
</td>

<td >47K
</td>

<td >470K
</td>
</tr>
<tr >
5.6

<td >56
</td>

<td >560
</td>

<td >5.6K
</td>

<td >56K
</td>

<td >560K
</td>
</tr>
<tr >
6.8

<td >68
</td>

<td >680
</td>

<td >6.8K
</td>

<td >68K
</td>

<td >680K
</td>
</tr>
<tr >
8.2

<td >82
</td>

<td >820
</td>

<td >8.2K
</td>

<td >82K
</td>

<td >820K
</td>
</tr>
<tr >
Misc.

<td >2K
</td>

<td >3K
</td>

<td >1M
</td>

<td >
</td>

<td >
</td>
</tr>
</tbody>
</table>

The application is fairly straight forward. It does not employ a fancy algorithm for efficiently determining combinations near the desired value. It simply brute forces all possible (two resistor) series and parallel combinations and displays the closest three of each configuration. It does determine which combination is nearest to the desired value and displays the results of the configuration first and its results in order from closest to farthest from the target value. That's it! Nothing fancy. Regardless of how inefficient this approach might be it returns results instantaneously when running on a Raspberry Pi.

    
    <span style="color: #919191;">#!/usr/bin/env python</span>
    <span style="color: #ff5600;">import</span> cgi
    <span style="color: #ff5600;">import</span> cgitb
    cgitb.enable() 
    
    form <span style="color: #ff5600;">=</span> cgi.FieldStorage()
    desired <span style="color: #ff5600;">=</span> <span style="color: #a535ae;">float</span>( form[<span style="color: #00a33f;">'desired'</span>].value ) <span style="color: #919191;">#form.getvalue('desired')</span>
    resistors_10 <span style="color: #ff5600;">=</span> [10, 100, 1000, 10000, 100000]
    resistors_12 <span style="color: #ff5600;">=</span> [12, 120, 1200, 12000, 120000]
    resistors_15 <span style="color: #ff5600;">=</span> [15, 150, 1500, 15000, 150000]
    resistors_18 <span style="color: #ff5600;">=</span> [18, 180, 1800, 18000, 180000]
    resistors_22 <span style="color: #ff5600;">=</span> [22, 220, 2200, 22000, 220000]
    resistors_27 <span style="color: #ff5600;">=</span> [27, 270, 2700, 27000, 270000]
    resistors_33 <span style="color: #ff5600;">=</span> [33, 330, 3300, 33000, 330000]
    resistors_39 <span style="color: #ff5600;">=</span> [39, 390, 3900, 39000, 390000]
    resistors_47 <span style="color: #ff5600;">=</span> [47, 470, 4700, 47000, 470000]
    resistors_56 <span style="color: #ff5600;">=</span> [56, 560, 5600, 56000, 560000]
    resistors_68 <span style="color: #ff5600;">=</span> [68, 680, 6800, 68000, 680000]
    resistors_82 <span style="color: #ff5600;">=</span> [82, 820, 8200, 82000, 820000]
    resistors_misc <span style="color: #ff5600;">=</span> [2000, 3000, 1000000]
    resistors_int <span style="color: #ff5600;">=</span> resistors_10 <span style="color: #ff5600;">+</span> resistors_12 <span style="color: #ff5600;">+</span> resistors_15 <span style="color: #ff5600;">+</span> resistors_18 <span style="color: #ff5600;">+</span> resistors_22 <span style="color: #ff5600;">+</span> resistors_27 <span style="color: #ff5600;">+</span>resistors_33 <span style="color: #ff5600;">+</span> resistors_39 <span style="color: #ff5600;">+</span> resistors_47 <span style="color: #ff5600;">+</span> resistors_56 <span style="color: #ff5600;">+</span> resistors_68 <span style="color: #ff5600;">+</span> resistors_82 <span style="color: #ff5600;">+</span> resistors_misc
    resistors <span style="color: #ff5600;">=</span> []  <span style="color: #919191;"># to contain float versions of resistor values</span>
    <span style="color: #ff5600;">for</span> i <span style="color: #ff5600;">in</span> resistors_int:
        resistors.append(<span style="color: #a535ae;">float</span>(i)) 
     
    <span style="color: #919191;"># In[2]:</span>
     
    series_combo <span style="color: #ff5600;">=</span> []
    series_val1 <span style="color: #ff5600;">=</span> []
    series_val2 <span style="color: #ff5600;">=</span> []
    <span style="color: #ff5600;">for</span> n, val <span style="color: #ff5600;">in</span> <span style="color: #a535ae;">enumerate</span>(resistors):
        <span style="color: #ff5600;">for</span> m, val <span style="color: #ff5600;">in</span> <span style="color: #a535ae;">enumerate</span>(resistors):
            series <span style="color: #ff5600;">=</span> resistors[n] <span style="color: #ff5600;">+</span> resistors[m]
            <span style="color: #ff5600;">if</span> ( desired <span style="color: #ff5600;"><=</span> (series <span style="color: #ff5600;">+</span> (series <span style="color: #ff5600;">*</span> .5)) ) <span style="color: #ff5600;">and</span> ( desired <span style="color: #ff5600;">>=</span> (series <span style="color: #ff5600;">-</span> (series <span style="color: #ff5600;">*</span> .5)) ):
                <span style="color: #ff5600;">if</span> series <span style="color: #ff5600;">not</span> <span style="color: #ff5600;">in</span> series_combo:
                    series_combo.append(series)
                    series_val1.append(n)
                    series_val2.append(m)
    series_combo <span style="color: #ff5600;">=</span> <span style="color: #a535ae;">zip</span>(series_combo, series_val1, series_val2)
    series_combo <span style="color: #ff5600;">=</span> <span style="color: #a535ae;">list</span>(<span style="color: #a535ae;">set</span>(series_combo))  <span style="color: #919191;">#set(creates set() of unique, unordered elements. list() creates a list from those elements</span>
     
     
    <span style="color: #919191;"># In[3]:</span>
     
    series_diff <span style="color: #ff5600;">=</span> []
    <span style="color: #ff5600;">for</span> p, val <span style="color: #ff5600;">in</span> <span style="color: #a535ae;">enumerate</span>(series_combo):
        series_diff.append( <span style="color: #a535ae;">abs</span>((series_combo[p][0] <span style="color: #ff5600;">-</span> desired) <span style="color: #ff5600;">/</span> desired) <span style="color: #ff5600;">*</span> 100 )
     
     
    <span style="color: #919191;"># In[4]:</span>
     
    series_values <span style="color: #ff5600;">=</span> <span style="color: #a535ae;">sorted</span>(<span style="color: #a535ae;">zip</span>(series_diff, series_combo) )
     
     
    <span style="color: #919191;"># In[5]:</span>
     
    series_opt <span style="color: #ff5600;">=</span> []
    <span style="color: #ff5600;">for</span> value <span style="color: #ff5600;">in</span> series_values[:3]:
        series_opt.append( [ <span style="color: #a535ae;">round</span>(value[0],4), <span style="color: #a535ae;">int</span>(value[1][0]), <span style="color: #a535ae;">int</span>(resistors[value[1][1]]), <span style="color: #a535ae;">int</span>(resistors[value[1][2]]) ] )
     
     
    <span style="color: #919191;"># In[6]:</span>
     
    parallel_combo <span style="color: #ff5600;">=</span> []
    parallel_val1 <span style="color: #ff5600;">=</span> []
    parallel_val2 <span style="color: #ff5600;">=</span> []
    <span style="color: #ff5600;">for</span> j, val <span style="color: #ff5600;">in</span> <span style="color: #a535ae;">enumerate</span>(resistors):
        <span style="color: #ff5600;">for</span> k, val <span style="color: #ff5600;">in</span> <span style="color: #a535ae;">enumerate</span>(resistors):
            parallel <span style="color: #ff5600;">=</span> (resistors[j] <span style="color: #ff5600;">*</span> resistors[k]) <span style="color: #ff5600;">/</span> (resistors[j] <span style="color: #ff5600;">+</span> resistors[k])
            <span style="color: #ff5600;">if</span> ( desired <span style="color: #ff5600;"><=</span> (parallel <span style="color: #ff5600;">+</span> (parallel <span style="color: #ff5600;">*</span> .5)) ) <span style="color: #ff5600;">and</span> ( desired <span style="color: #ff5600;">>=</span> (parallel <span style="color: #ff5600;">-</span> (parallel <span style="color: #ff5600;">*</span> .5)) ):
                <span style="color: #ff5600;">if</span> parallel <span style="color: #ff5600;">not</span> <span style="color: #ff5600;">in</span> parallel_combo:
                    parallel_combo.append(parallel)
                    parallel_val1.append(j)
                    parallel_val2.append(k)
    parallel_combo <span style="color: #ff5600;">=</span> <span style="color: #a535ae;">zip</span>(parallel_combo, parallel_val1, parallel_val2)
    parallel_combo <span style="color: #ff5600;">=</span> <span style="color: #a535ae;">list</span>(<span style="color: #a535ae;">set</span>(parallel_combo))  <span style="color: #919191;">#set(creates set() of unique, unordered elements. list() creates a list from those elements</span>
     
     
    <span style="color: #919191;"># In[7]:</span>
     
    parallel_diff <span style="color: #ff5600;">=</span> []
    <span style="color: #ff5600;">for</span> q,val <span style="color: #ff5600;">in</span> <span style="color: #a535ae;">enumerate</span>(parallel_combo):
        parallel_diff.append( <span style="color: #a535ae;">abs</span>((parallel_combo[q][0] <span style="color: #ff5600;">-</span> desired) <span style="color: #ff5600;">/</span> desired) <span style="color: #ff5600;">*</span> 100 )
     
     
    <span style="color: #919191;"># In[8]:</span>
     
    parallel_values <span style="color: #ff5600;">=</span> <span style="color: #a535ae;">sorted</span>(<span style="color: #a535ae;">zip</span>(parallel_diff, parallel_combo))
     
     
    <span style="color: #919191;"># In[9]:</span>
     
    parallel_opt <span style="color: #ff5600;">=</span> []
    <span style="color: #ff5600;">for</span> value <span style="color: #ff5600;">in</span> parallel_values[:3]:
        parallel_opt.append( [ <span style="color: #a535ae;">round</span>(value[0],4), <span style="color: #a535ae;">int</span>(value[1][0]), <span style="color: #a535ae;">int</span>(resistors[value[1][1]]), <span style="color: #a535ae;">int</span>(resistors[value[1][2]]) ] )
     
     
    <span style="color: #919191;"># In[10]:</span>
     
    <span style="color: #ff5600;">def</span> <span style="color: #21439c;">write_series</span>():
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<div class="container">'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<div class="row">'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<div class="one-half column" style="margin-top: 5%">'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<h2>Series</h2>'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<img src="http://codyalantaylor.com/wp-content/uploads/2015/06/resistor_series.svg" style="width: 100%;"></img>'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<table style="width: 100%;">'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<tr>'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td><b>Percent Difference</b></td>'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td><b>Value</b></td>'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td><b>R1</b></td>'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td><b>R2</b></td>'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</tr>'</span>
        <span style="color: #ff5600;">if</span> <span style="color: #a535ae;">len</span>(series_opt) <span style="color: #ff5600;">></span> 0:
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<tr>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(series_opt[0][0]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'%</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(series_opt[0][1]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(series_opt[0][2]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(series_opt[0][3]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</tr>'</span>
        <span style="color: #ff5600;">if</span> <span style="color: #a535ae;">len</span>(parallel_opt) <span style="color: #ff5600;">></span> 1:
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<tr>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(series_opt[1][0]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'%</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(series_opt[1][1]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(series_opt[1][2]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(series_opt[1][3]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</tr>'</span>
        <span style="color: #ff5600;">if</span> <span style="color: #a535ae;">len</span>(parallel_opt) <span style="color: #ff5600;">></span> 2:
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<tr>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(series_opt[2][0]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'%</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(series_opt[2][1]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(series_opt[2][2]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(series_opt[2][3]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</tr>'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</table>'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</div>'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</div>'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</div>'</span>
         
    <span style="color: #ff5600;">def</span> <span style="color: #21439c;">write_parallel</span>():
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<div class="container">'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<div class="row">'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<div class="one-half column" style="margin-top: 5%">'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<h2>Parallel</h2>'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<img src="http://codyalantaylor.com/wp-content/uploads/2015/06/resistor_parallel.svg" style="width: 100%;"></img>'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<table style="width: 100%;">'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<tr>'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td><b>Percent Difference</b></td>'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td><b>Value</b></td>'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td><b>R1</b></td>'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td><b>R2</b></td>'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</tr>'</span>
        <span style="color: #ff5600;">if</span> <span style="color: #a535ae;">len</span>(parallel_opt) <span style="color: #ff5600;">></span> 0:
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<tr>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(parallel_opt[0][0]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'%</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(parallel_opt[0][1]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(parallel_opt[0][2]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(parallel_opt[0][3]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</tr>'</span>
        <span style="color: #ff5600;">if</span> <span style="color: #a535ae;">len</span>(parallel_opt) <span style="color: #ff5600;">></span> 1:
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<tr>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(parallel_opt[1][0]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'%</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(parallel_opt[1][1]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(parallel_opt[1][2]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(parallel_opt[1][3]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</tr>'</span>
        <span style="color: #ff5600;">if</span> <span style="color: #a535ae;">len</span>(parallel_opt) <span style="color: #ff5600;">></span> 2:
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<tr>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(parallel_opt[2][0]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'%</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(parallel_opt[2][1]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(parallel_opt[2][2]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<td>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(parallel_opt[2][3]) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'</td>'</span>
            <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</tr>'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</table>'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</div>'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</div>'</span>
        <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</div>'</span>
     
     
    <span style="color: #919191;"># In[13]:</span>
     
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'Content-type:text/html\r\n\r\n'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<html lang="en">'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<head>'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<meta charset="utf-8">'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<title>Resistor Combination</title>'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<meta name="author" content="Cody Taylor">'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<meta name="viewport" content="width=device-width, initial-scale=1">'</span>
    <span style="color: #919191;">#print '<link href="//fonts.googleapis.com/css?family=Raleway:400,300,600" rel="stylesheet" type="text/css">')</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<link rel="stylesheet" href="http://codyalantaylor.com/wp-content/uploads/2015/06/resistor_normalize.css">'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<link rel="stylesheet" href="http://codyalantaylor.com/wp-content/uploads/2015/06/resistor_skeleton.css">'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</head>'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<body>'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<div class="container">'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<div class="row">'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<div class="one-half column" style="margin-top: 5%">'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<h1>'</span> <span style="color: #ff5600;">+</span> <span style="color: #a535ae;">str</span>(<span style="color: #a535ae;">int</span>(desired)) <span style="color: #ff5600;">+</span> <span style="color: #00a33f;">'</h1>'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</div>'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</div>'</span>
    
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</div>'</span>
    <span style="color: #ff5600;">if</span> <span style="color: #a535ae;">len</span>(series_opt) <span style="color: #ff5600;">></span> 0:
        <span style="color: #ff5600;">if</span> series_opt[0][0] <span style="color: #ff5600;"><=</span> parallel_opt[0][0]:
            write_series()
            write_parallel()
        <span style="color: #ff5600;">else</span>:
            write_parallel()
            write_series()
    <span style="color: #ff5600;">else</span>:
        write_parallel()
    
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</body>'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<div class="container">'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<div class="row">'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<footer>'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<a href="http://apps.codytaylor.cc:8080/omega/"><button type="button">Again?</button></a>'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<div class="row">'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'<a href="http://apps.codytaylor.cc:8080/omega/about.html">About</a>'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</div>'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</footer>'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</div>'</span>
    <span style="color: #ff5600;">print</span> <span style="color: #00a33f;">'</div>'</span>
    


I knew that this application would be handy to have in lab, but would be cumbersome to pull up and run on a computer, so I set out hoping to build this in the form of a smartphone application. I know nothing about Android or iOS development, but I am pretty comfortable building websites. Understanding this I set out to build this into a web-app. A web-app appears on a phone exactly like a regular app would except that when it opens it opens in a web browser whether or not the user knows it. Web browsers are incredibly flexible. With this in mind, I knew that Javascript would probably be the most appropriate language to use, but I don't know Javascript and have only been able to achieve the most elementary of tasks using it; however, I am growing continuously more comfortable with Python. Once I had the app working I created another version of it which used Common Gateway Interface to execute Python scripts over the internet and display results in a web browser. For this I set up a Raspberry Pi as a web server (deserving of its own post) that hosts and executes this script via CGI. Screenshots are below.

[![omega home2](http://codyalantaylor.com/wp-content/uploads/2015/08/omega-home2.png)](http://apps.codytaylor.cc:8080/omega/)

[![omega results2](http://codyalantaylor.com/wp-content/uploads/2015/08/omega-results2.png)](http://apps.codytaylor.cc:8080/omega/)

Please give it a try.  Keep in mind that it has no means of prompting users when they enter invalid information. It only accepts numbers and if you happen to choose an unreasonable number, one that it can't even come close to, you might also receive an error notice. 
  


[Take Me to the App!](http://apps.codytaylor.cc:8080/omega)



## Acknowledgements



Banner image credit: [Sparkfun Education](https://learn.sparkfun.com/tutorials/resistors)




## Tangent: Resistor Organizer


As an EE student I also carry a few tools and a tackle box full of electronic components in addition to my laptops, books, and sutff. When it became necessary for me to start carrying a kit of components, I was extremely picky about the box I chose and how it would be organized.  At Bass Pro I found a slim Plano tackle box whose compartments were large enough and numerous enough to hold resistors.  Excluding their multiples of ten and organizing resistors by their base values, makes retrieval easy and takes up far fewer compartments than allotting a compartment to each value.  When resistors are organized in this way it means only having to find the right compartment, and the third-band color that correspond to the value you're looking for as all resistors in any given compartment have the same first and second bands.  I created the chart below and taped it to the inside lid of my kit and use it as a quick reference.  It's time that I shared it.  I was very careful that the compartments in this chart match those in my kit, and that it is as easy to read as possible. -vivid colors, bold font.  In the blank space on this chart I have handwritten pin-outs, and other frequently referenced information.  It might be time that I revise this chart by recreating that information in a more legible way. Please click the image below to download the full-size PNG or download the Photoshop file in the link below. 

[![Resistor Organizer](http://codyalantaylor.com/wp-content/uploads/2015/08/Resistor-Organizer.png)](http://codyalantaylor.com/wp-content/uploads/2015/08/Resistor-Organizer.png)

[ResistorOrganizer.psd](http://codyalantaylor.com/wp-content/uploads/2015/08/Resistor-Organizer.psd)
