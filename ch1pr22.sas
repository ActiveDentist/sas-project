/*

Problem 22 - chp1
*/
option ls = 80 ps = 80;
data a;
infile 'ch01pr22.dat';
input y x; /*y = hardness in Brinell units, x =time*/
run;


/* regression model: y = 168.6 +2.03438(x)  
#2 - use proc plot.
#3 - finding the confidence interval. add option in the model.
#4 Saving residual into a SAS dataset - output out
#5 Histogram?
Menu: Solutions>Analyst>Open by SAS name>Libraries>Work
Select the regression data variable name.
Graph->Histrogram
Probability Plot: For checking normality assumption
#6 Confidence Interval for means response - when x = 24.
(215.5254 - 219.3246)
What about predictad value for x = 28?
Use the regression mode: y(hat) = 168.6 + 2.03438(28).
168.6 + 2.03(28) +/- t(1-alpha)/2,n-2 * SE(y-hat) /* need to find critical value/

#7 - Finding the t-value.

Variance calculation, used for #7 tvalue code.
var(y-hat) = var(b(0) +b(1)*28)
= var(b0) + 28^2*var(b1) + 2*28 * covar(b0,b1)

Format:
var(ax + by) = a^2*var(x) + b^2var(y) + 2*a*b*cov(x,y)

Covariance of Estimates:
7.059 = b0.


Bonferri simutaneous CI
SCI for B0, B1
B0 +/-t(1-alpha)/4, df * SE(B0)
b1+/-t(1-alpha),df * SE(b1)

F(1-alpha), df1,df2
finv(.95, 1, 14)
*/
proc reg data = a;
model y = x/covb clm cli p; /*clm = confidence interval, cli = prediction interval */
*plot y*x p.*x = 'p'/overlay; /*Plot: y*x = vertical prediction.*x = horizontal*/ 
output out = regouta p=pred r=res;
run;
proc print data = regouta;
quit;

/*

 #7 - finding the t-value *
data ci;
tvalue = tinv(0.975,14); /*(quantile, degree of freedom)*/
/*standard error when y = 28, use the variance calculation *
sey20 = sqrt(7.059 + 20*20*00817 + (2*20*-.2287));

/*(lower, upper)*/
/*lower bound confidence interval *
ciy20l = 168.6 + 2.03*20 - tvalue*sey20;
/* upper bound confidence interval *
ciy20u = 168.6 + 2.03*20 + tvalue*sey20; 

fvalue = finv(.95,1,14);
tvaly1 = tinv(1-.05/4, 14); /*will give the critical value *

put tvalue=sey20=; /*put into a Log file *
run; /*when run, check the Log file, there should be a value

proc print data = ci;
run;

*/
