just a test. global script and works in vanilla too. need to use ``>`` 
```
Begin mmm_casters

float timer1
float timer2
float timer3
float timer4

set timer1 to timer1 + getsecondspassed
set timer2 to timer2 + getsecondspassed
set timer3 to timer3 + getsecondspassed
set timer4 to timer4 + getsecondspassed

if timer1 > 10
	"eldafire"->cast "fireball" "fargoth"
	set timer1 to 0
endif

if timer2 > 20
	"vodunius nuccius"-> cast "soul trap" "eldafire" 
	set timer2 to 0
endif

if timer3 > 15
	"fargoth"-> cast "sleep" "vodunius nuccius"
	set timer3 to 0
endif

if timer4 > 30
	"indrele rathryon"-> cast "strong fire shield" "fargoth"
	set timer4 to 0
endif

End mmm_casters
```
