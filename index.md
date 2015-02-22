BMR inspired Calorie Planner
========================================================
date: February 2015

*This App tries to help clarify some of the mystery around BMI, BMR, Calorie Deficits and continued weight loss.*

Simply put, this is the <u><b>Calorie Planner</b></u> I've always wanted.

Calorie Planner Steps
========================================================

- Start of by calculating a user's height specific **BMI** (Body Mass Index) table listing
not only the BMI score ranges but also the associated weight ranges
- Calculate the user's **BMR** (Basal Metabolic Rate) given their gender, weight, height, 
age and activity level
- Calculate the **Calorie Deficit** required to achive the user's weekly weight loss goal
- Tabulate the **Calorie Plan** taking into account that BMR declines as you lose weight

BMR Calculation
========================================================
type: section

At the heart of this <u><b>Calorie Planner</b></u> lies the gender specific BMR (Basal Metabolic Rate) calculation. A male calculation example is shown below.


```r
weightKg <- 94; heightCm <- 186; 
ageYears <- 36; activityFactor <- 1.2;

(66.47 + (13.75 * weightKg) + (5.003 * heightCm) - (6.755 * ageYears)) * activityFactor;
```

```
[1] 2456
```

Calorie Plan
========================================================

The following is a example of a guided **Calorie Plan** 
created for a female wanting to lose 5 kg at 0.5 kg per week.

<table>
  <tr>
    <th>Week</th>
    <th>Weight</th>
    <th>Lost kg</th>
    <th>BMR</th>
    <th>Calorie per day Diet</th>
  </tr>
  <tr>
    <td></td>
    <td>74</td>
    <td></td>
    <td>2078</td>
    <td>1528</td>
  </tr>
  <tr>
    <td>4</td>
    <td>72</td>
    <td>2</td>
    <td>2045</td>
    <td>1495</td>
  </tr>
  <tr>
    <td>8</td>
    <td>70</td>
    <td>4</td>
    <td>2012</td>
    <td>1462</td>
  </tr>
  <tr>
    <td>12</td>
    <td>69</td>
    <td>5</td>
    <td>1996</td>
    <td></td>
  </tr>
</table>

References
========================================================
type: section

<span style="font-size:smaller;">
<span style="font-size:smaller;">
Harris JA, Benedict FG. A biometric study of human basal metabolism. Proc Natl Acad Sci USA 1918;4(12):370-3.
</span>
</span>

<span style="font-size:smaller;">
<span style="font-size:smaller;">
McAuley, D. (2015, January 7). Harris Benedict equation - Determination of the basal metabolic rate (BMR). Retrieved February 22, 2015, from http://www.globalrph.com
</span>
</span>

***

<span style="font-size:smaller;">
<span style="font-size:smaller;">
Seltzer, C. (2013, July 17). BMI Chart For Men & Women: Is BMI Misleading? Retrieved February 22, 2015, from http://www.builtlean.com
</span>
</span>

<span style="font-size:smaller;">
<span style="font-size:smaller;">
Parker, K.T. (2013, November 24). How Many Calories Should Be Burned to Lose 2.2 Pounds? Retrieved February 22, 2015, from http://www.livestrong.com 
</span>
</span>