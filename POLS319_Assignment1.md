# POLS 319 - Rishi Gummakonda

## Excel 1
#### first draft and submission 3/7

<p> For the Excel 1 assignment, you will: </p>

1. Review the Data Profile tables you downloaded for your Census Introduction.
2. Identify at least 5 indicators that stand out and that you feel really illustrate how the two geographies compare or contrast.
3. Write a 2-page reflection of these key indicators.  This should include why they stand out to you and why you think others should find them important, too.

The Excel 1 paper is due by 5pm on Sunday, February 13th.

### Introduction
I want to take the oppurtunity to take a look at the data from the local area. In particular, I want to focus on the city of Bethlehem, PA. The goal of the analysis will be to gain insights into how the area and the people in it function. A more specific goal would be to tell the story of the average Joe in Bethlehem.

By the time the semester ends I would like to compare and contrast the following :

1. Bethlehem and Northampton - city to county
2. Bethlehem to Allentown to Easton - major cities in the PA side of the Lehigh Valley
3. Northampton to PA - county to state
4. Lehigh Valley to PA - general region to state
5. Southside Bethlehem to other parts of Bethlehem 

The purpose of each comparision will be to highlight how Bethlehem may be unique to the surrounding area. If something stands out, hopefully there's a policy reason behind it.

Given the time constraint, I will compare the Lehigh Valley Area (designated as the MSA "Allentown-Bethlehem-Easton" by the Census) to Bethlehem and the surrounding area.

Due to already reviewing the Data Profiles for the Census Introduction assignment, I have a very general idea of what I would like to look at.

For now, I want to look at:
1. Percent of people in poverty
2. Estimated percentage of rentals
3. Percentage of Non-English Speaker
4. Theil Index or similar diversity index
5. Educational Attainment - at least high school dipolma
6. Food/Health metric (unknown for now)

Based on what we've discussed and learned about in class, these variables can be important indicators for quality of life of the people in the area, especially the less privileged.

Let's see what we find.

To my honest surprise, there are A LOT of ways to analyze the Census data in Python. I could (and would not mind at a later date) walking through all the ways in a notebook like this or in a presentation. Right now I'm just going to do the basic requirements for the assignment.

For now, I'm going to use the `cenpy` package that builds off the Census API which can be found at: [https://www.census.gov/data/developers/guidance/api-user-guide.Overview.html]


```python
import cenpy as c


# for data cleaning
import pandas as pd
import warnings
#warnings.simplefilter(action='ignore', category=FutureWarning)
import numpy as np
import matplotlib.pyplot as plt

#for some graphs
import seaborn as sns

CENSUS_API_KEY = 'c87521da53a7ba45c39194eac04695710c252672'

pd.set_option('display.max_colwidth', 0)
import warnings
warnings.simplefilter(action='ignore', category=FutureWarning)

```


```python
(c.explorer.available(verbose=True).filter(items=['ACSDT5Y2019'], axis=0)['description'])
```




    ACSDT5Y2019    The American Community Survey (ACS) is an ongoing survey that provides data every year -- giving communities the current information they need to plan investments and services. The ACS covers a broad range of topics about social, economic, demographic, and housing characteristics of the U.S. population. Summary files include the following geographies: nation, all states (including DC and Puerto Rico), all metropolitan areas, all congressional districts (116th Congress), all counties, all places, and all tracts and block groups. Summary files contain the most detailed cross-tabulations, many of which are published down to block groups. The data are population and housing counts. There are over 64,000 variables in this dataset.
    Name: description, dtype: object




```python
conn = c.remote.APIConnection('ACSDT5Y2019',apikey=CENSUS_API_KEY)
variables = conn.variables
```


```python
acs = c.products.ACS()
dectest= c.products.Decennial2010()
```


```python
valley_geoids = acs.from_msa(msa='Allentown-Bethlehem-Easton')
```


```python
#the valley geocodes
valley_geoids.drop('geometry', axis=1)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>GEOID</th>
      <th>NAME</th>
      <th>state</th>
      <th>county</th>
      <th>tract</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>42077006303</td>
      <td>Census Tract 63.03, Lehigh County, Pennsylvania</td>
      <td>42</td>
      <td>077</td>
      <td>006303</td>
    </tr>
    <tr>
      <th>1</th>
      <td>42077006307</td>
      <td>Census Tract 63.07, Lehigh County, Pennsylvania</td>
      <td>42</td>
      <td>077</td>
      <td>006307</td>
    </tr>
    <tr>
      <th>2</th>
      <td>42077006304</td>
      <td>Census Tract 63.04, Lehigh County, Pennsylvania</td>
      <td>42</td>
      <td>077</td>
      <td>006304</td>
    </tr>
    <tr>
      <th>3</th>
      <td>42077002202</td>
      <td>Census Tract 22.02, Lehigh County, Pennsylvania</td>
      <td>42</td>
      <td>077</td>
      <td>002202</td>
    </tr>
    <tr>
      <th>4</th>
      <td>42077005800</td>
      <td>Census Tract 58, Lehigh County, Pennsylvania</td>
      <td>42</td>
      <td>077</td>
      <td>005800</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>174</th>
      <td>42095014200</td>
      <td>Census Tract 142, Northampton County, Pennsylvania</td>
      <td>42</td>
      <td>095</td>
      <td>014200</td>
    </tr>
    <tr>
      <th>175</th>
      <td>42095014700</td>
      <td>Census Tract 147, Northampton County, Pennsylvania</td>
      <td>42</td>
      <td>095</td>
      <td>014700</td>
    </tr>
    <tr>
      <th>176</th>
      <td>42095014400</td>
      <td>Census Tract 144, Northampton County, Pennsylvania</td>
      <td>42</td>
      <td>095</td>
      <td>014400</td>
    </tr>
    <tr>
      <th>177</th>
      <td>42095014500</td>
      <td>Census Tract 145, Northampton County, Pennsylvania</td>
      <td>42</td>
      <td>095</td>
      <td>014500</td>
    </tr>
    <tr>
      <th>178</th>
      <td>34041032102</td>
      <td>Census Tract 321.02, Warren County, New Jersey</td>
      <td>34</td>
      <td>041</td>
      <td>032102</td>
    </tr>
  </tbody>
</table>
<p>179 rows × 5 columns</p>
</div>




```python
# This gets Bethlehem and some of the surrounding area
bethlehem_geoids = acs.from_place(place='Bethlehem city, PA', place_type = 'Incorporated Place', strict_within=False)
```

    Matched: Bethlehem city, PA to Bethlehem city within layer Incorporated Places



```python
bethlehem_geoids.drop('geometry', axis=1)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>GEOID</th>
      <th>state</th>
      <th>county</th>
      <th>tract</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>42077000102</td>
      <td>42</td>
      <td>077</td>
      <td>000102</td>
    </tr>
    <tr>
      <th>1</th>
      <td>42095010800</td>
      <td>42</td>
      <td>095</td>
      <td>010800</td>
    </tr>
    <tr>
      <th>2</th>
      <td>42095010100</td>
      <td>42</td>
      <td>095</td>
      <td>010100</td>
    </tr>
    <tr>
      <th>3</th>
      <td>42095017901</td>
      <td>42</td>
      <td>095</td>
      <td>017901</td>
    </tr>
    <tr>
      <th>4</th>
      <td>42095017902</td>
      <td>42</td>
      <td>095</td>
      <td>017902</td>
    </tr>
    <tr>
      <th>5</th>
      <td>42095017604</td>
      <td>42</td>
      <td>095</td>
      <td>017604</td>
    </tr>
    <tr>
      <th>6</th>
      <td>42095017605</td>
      <td>42</td>
      <td>095</td>
      <td>017605</td>
    </tr>
    <tr>
      <th>7</th>
      <td>42077006702</td>
      <td>42</td>
      <td>077</td>
      <td>006702</td>
    </tr>
    <tr>
      <th>8</th>
      <td>42077006800</td>
      <td>42</td>
      <td>077</td>
      <td>006800</td>
    </tr>
    <tr>
      <th>9</th>
      <td>42077009200</td>
      <td>42</td>
      <td>077</td>
      <td>009200</td>
    </tr>
    <tr>
      <th>10</th>
      <td>42077006701</td>
      <td>42</td>
      <td>077</td>
      <td>006701</td>
    </tr>
    <tr>
      <th>11</th>
      <td>42077009300</td>
      <td>42</td>
      <td>077</td>
      <td>009300</td>
    </tr>
    <tr>
      <th>12</th>
      <td>42095017703</td>
      <td>42</td>
      <td>095</td>
      <td>017703</td>
    </tr>
    <tr>
      <th>13</th>
      <td>42077005902</td>
      <td>42</td>
      <td>077</td>
      <td>005902</td>
    </tr>
    <tr>
      <th>14</th>
      <td>42077009400</td>
      <td>42</td>
      <td>077</td>
      <td>009400</td>
    </tr>
    <tr>
      <th>15</th>
      <td>42095010300</td>
      <td>42</td>
      <td>095</td>
      <td>010300</td>
    </tr>
    <tr>
      <th>16</th>
      <td>42095010200</td>
      <td>42</td>
      <td>095</td>
      <td>010200</td>
    </tr>
    <tr>
      <th>17</th>
      <td>42095017800</td>
      <td>42</td>
      <td>095</td>
      <td>017800</td>
    </tr>
    <tr>
      <th>18</th>
      <td>42095011300</td>
      <td>42</td>
      <td>095</td>
      <td>011300</td>
    </tr>
    <tr>
      <th>19</th>
      <td>42077009600</td>
      <td>42</td>
      <td>077</td>
      <td>009600</td>
    </tr>
    <tr>
      <th>20</th>
      <td>42077009500</td>
      <td>42</td>
      <td>077</td>
      <td>009500</td>
    </tr>
    <tr>
      <th>21</th>
      <td>42095017704</td>
      <td>42</td>
      <td>095</td>
      <td>017704</td>
    </tr>
    <tr>
      <th>22</th>
      <td>42095011200</td>
      <td>42</td>
      <td>095</td>
      <td>011200</td>
    </tr>
    <tr>
      <th>23</th>
      <td>42095010400</td>
      <td>42</td>
      <td>095</td>
      <td>010400</td>
    </tr>
    <tr>
      <th>24</th>
      <td>42095018002</td>
      <td>42</td>
      <td>095</td>
      <td>018002</td>
    </tr>
    <tr>
      <th>25</th>
      <td>42095017606</td>
      <td>42</td>
      <td>095</td>
      <td>017606</td>
    </tr>
    <tr>
      <th>26</th>
      <td>42077009100</td>
      <td>42</td>
      <td>077</td>
      <td>009100</td>
    </tr>
    <tr>
      <th>27</th>
      <td>42095010700</td>
      <td>42</td>
      <td>095</td>
      <td>010700</td>
    </tr>
    <tr>
      <th>28</th>
      <td>42095010500</td>
      <td>42</td>
      <td>095</td>
      <td>010500</td>
    </tr>
    <tr>
      <th>29</th>
      <td>42095017603</td>
      <td>42</td>
      <td>095</td>
      <td>017603</td>
    </tr>
    <tr>
      <th>30</th>
      <td>42095018001</td>
      <td>42</td>
      <td>095</td>
      <td>018001</td>
    </tr>
    <tr>
      <th>31</th>
      <td>42095010900</td>
      <td>42</td>
      <td>095</td>
      <td>010900</td>
    </tr>
    <tr>
      <th>32</th>
      <td>42077006903</td>
      <td>42</td>
      <td>077</td>
      <td>006903</td>
    </tr>
    <tr>
      <th>33</th>
      <td>42095017607</td>
      <td>42</td>
      <td>095</td>
      <td>017607</td>
    </tr>
    <tr>
      <th>34</th>
      <td>42077000101</td>
      <td>42</td>
      <td>077</td>
      <td>000101</td>
    </tr>
    <tr>
      <th>35</th>
      <td>42095017702</td>
      <td>42</td>
      <td>095</td>
      <td>017702</td>
    </tr>
    <tr>
      <th>36</th>
      <td>42095011000</td>
      <td>42</td>
      <td>095</td>
      <td>011000</td>
    </tr>
    <tr>
      <th>37</th>
      <td>42095011100</td>
      <td>42</td>
      <td>095</td>
      <td>011100</td>
    </tr>
    <tr>
      <th>38</th>
      <td>42095010600</td>
      <td>42</td>
      <td>095</td>
      <td>010600</td>
    </tr>
  </tbody>
</table>
</div>



### Searching for the right data


```python
pd.set_option('display.max_rows', 100)
acs.filter_tables('EDUC', by='description').drop('columns', axis=1).sort_index()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>description</th>
    </tr>
    <tr>
      <th>table_name</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>B06009</th>
      <td>PLACE OF BIRTH BY EDUCATIONAL ATTAINMENT IN THE UNITED STATES</td>
    </tr>
    <tr>
      <th>B07009</th>
      <td>GEOGRAPHICAL MOBILITY IN THE PAST YEAR BY EDUCATIONAL ATTAINMENT FOR CURRENT RESIDENCE IN THE UNITED STATES</td>
    </tr>
    <tr>
      <th>B07409</th>
      <td>GEOGRAPHICAL MOBILITY IN THE PAST YEAR BY EDUCATIONAL ATTAINMENT FOR RESIDENCE 1 YEAR AGO IN THE UNITED STATES</td>
    </tr>
    <tr>
      <th>B13014</th>
      <td>WOMEN 15 TO 50 YEARS WHO HAD A BIRTH IN THE PAST 12 MONTHS BY MARITAL STATUS AND EDUCATIONAL ATTAINMENT</td>
    </tr>
    <tr>
      <th>B14005</th>
      <td>SEX BY SCHOOL ENROLLMENT BY EDUCATIONAL ATTAINMENT BY EMPLOYMENT STATUS FOR THE POPULATION 16 TO 19 YEARS</td>
    </tr>
    <tr>
      <th>B15001</th>
      <td>SEX BY AGE BY EDUCATIONAL ATTAINMENT FOR THE POPULATION 18 YEARS AND OVER</td>
    </tr>
    <tr>
      <th>B15002</th>
      <td>SEX BY EDUCATIONAL ATTAINMENT FOR THE POPULATION 25 YEARS AND OVER</td>
    </tr>
    <tr>
      <th>B15003</th>
      <td>EDUCATIONAL ATTAINMENT FOR THE POPULATION 25 YEARS AND OVER</td>
    </tr>
    <tr>
      <th>B16010</th>
      <td>EDUCATIONAL ATTAINMENT AND EMPLOYMENT STATUS BY LANGUAGE SPOKEN AT HOME FOR THE POPULATION 25 YEARS AND OVER</td>
    </tr>
    <tr>
      <th>B17003</th>
      <td>POVERTY STATUS IN THE PAST 12 MONTHS OF INDIVIDUALS BY SEX BY EDUCATIONAL ATTAINMENT</td>
    </tr>
    <tr>
      <th>B17018</th>
      <td>POVERTY STATUS IN THE PAST 12 MONTHS OF FAMILIES BY HOUSEHOLD TYPE BY EDUCATIONAL ATTAINMENT OF HOUSEHOLDER</td>
    </tr>
    <tr>
      <th>B20004</th>
      <td>MEDIAN EARNINGS IN THE PAST 12 MONTHS (IN 2017 INFLATION-ADJUSTED DOLLARS) BY SEX BY EDUCATIONAL ATTAINMENT FOR THE POPULATION 25 YEARS AND OVER</td>
    </tr>
    <tr>
      <th>B21003</th>
      <td>VETERAN STATUS BY EDUCATIONAL ATTAINMENT FOR THE CIVILIAN POPULATION 25 YEARS AND OVER</td>
    </tr>
    <tr>
      <th>B23006</th>
      <td>EDUCATIONAL ATTAINMENT BY EMPLOYMENT STATUS FOR THE POPULATION 25 TO 64 YEARS</td>
    </tr>
    <tr>
      <th>B25013</th>
      <td>TENURE BY EDUCATIONAL ATTAINMENT OF HOUSEHOLDER</td>
    </tr>
    <tr>
      <th>B26106</th>
      <td>GROUP QUARTERS TYPE [3] BY EDUCATIONAL ATTAINMENT</td>
    </tr>
    <tr>
      <th>B26206</th>
      <td>GROUP QUARTERS TYPE [5] BY EDUCATIONAL ATTAINMENT</td>
    </tr>
    <tr>
      <th>B27019</th>
      <td>HEALTH INSURANCE COVERAGE STATUS AND TYPE BY AGE BY EDUCATIONAL ATTAINMENT</td>
    </tr>
    <tr>
      <th>B28006</th>
      <td>EDUCATIONAL ATTAINMENT BY PRESENCE OF A COMPUTER AND TYPES OF INTERNET SUBSCRIPTION IN HOUSEHOLD</td>
    </tr>
    <tr>
      <th>B99151</th>
      <td>ALLOCATION OF EDUCATIONAL ATTAINMENT FOR THE POPULATION 25 YEARS AND OVER</td>
    </tr>
  </tbody>
</table>
</div>




```python
pd.DataFrame(acs.filter_variables('B15003')[['label', 'group']]).sort_index().head(20)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>label</th>
      <th>group</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>B15003_001E</th>
      <td>Estimate!!Total</td>
      <td>B15003</td>
    </tr>
    <tr>
      <th>B15003_002E</th>
      <td>Estimate!!Total!!No schooling completed</td>
      <td>B15003</td>
    </tr>
    <tr>
      <th>B15003_003E</th>
      <td>Estimate!!Total!!Nursery school</td>
      <td>B15003</td>
    </tr>
    <tr>
      <th>B15003_004E</th>
      <td>Estimate!!Total!!Kindergarten</td>
      <td>B15003</td>
    </tr>
    <tr>
      <th>B15003_005E</th>
      <td>Estimate!!Total!!1st grade</td>
      <td>B15003</td>
    </tr>
    <tr>
      <th>B15003_006E</th>
      <td>Estimate!!Total!!2nd grade</td>
      <td>B15003</td>
    </tr>
    <tr>
      <th>B15003_007E</th>
      <td>Estimate!!Total!!3rd grade</td>
      <td>B15003</td>
    </tr>
    <tr>
      <th>B15003_008E</th>
      <td>Estimate!!Total!!4th grade</td>
      <td>B15003</td>
    </tr>
    <tr>
      <th>B15003_009E</th>
      <td>Estimate!!Total!!5th grade</td>
      <td>B15003</td>
    </tr>
    <tr>
      <th>B15003_010E</th>
      <td>Estimate!!Total!!6th grade</td>
      <td>B15003</td>
    </tr>
    <tr>
      <th>B15003_011E</th>
      <td>Estimate!!Total!!7th grade</td>
      <td>B15003</td>
    </tr>
    <tr>
      <th>B15003_012E</th>
      <td>Estimate!!Total!!8th grade</td>
      <td>B15003</td>
    </tr>
    <tr>
      <th>B15003_013E</th>
      <td>Estimate!!Total!!9th grade</td>
      <td>B15003</td>
    </tr>
    <tr>
      <th>B15003_014E</th>
      <td>Estimate!!Total!!10th grade</td>
      <td>B15003</td>
    </tr>
    <tr>
      <th>B15003_015E</th>
      <td>Estimate!!Total!!11th grade</td>
      <td>B15003</td>
    </tr>
    <tr>
      <th>B15003_016E</th>
      <td>Estimate!!Total!!12th grade, no diploma</td>
      <td>B15003</td>
    </tr>
    <tr>
      <th>B15003_017E</th>
      <td>Estimate!!Total!!Regular high school diploma</td>
      <td>B15003</td>
    </tr>
    <tr>
      <th>B15003_018E</th>
      <td>Estimate!!Total!!GED or alternative credential</td>
      <td>B15003</td>
    </tr>
    <tr>
      <th>B15003_019E</th>
      <td>Estimate!!Total!!Some college, less than 1 year</td>
      <td>B15003</td>
    </tr>
    <tr>
      <th>B15003_020E</th>
      <td>Estimate!!Total!!Some college, 1 or more years, no degree</td>
      <td>B15003</td>
    </tr>
  </tbody>
</table>
</div>




```python
#POPULATION
total_pop = 'B01003_001E'
```


```python
#RACE
total_racial_makeup_vars = conn.varslike('B02001*', engine='fnmatch').sort_index().index.tolist()
total_racial_makeup_vars
```




    ['B02001_001E',
     'B02001_002E',
     'B02001_003E',
     'B02001_004E',
     'B02001_005E',
     'B02001_006E',
     'B02001_007E',
     'B02001_008E',
     'B02001_009E',
     'B02001_010E']




```python
#MEDIAN SELECTED MONTHLY OWNER COSTS AS A PERCENTAGE OF HOUSEHOLD INCOME IN THE PAST 12 MONTHS
all_B25092 = conn.varslike('B25092*', engine='fnmatch').sort_index().index.tolist()
all_B25092
```




    ['B25092_001E', 'B25092_002E', 'B25092_003E']




```python
#POVERTY STATUS BY EDUCATION
total_pov_vars = conn.varslike('B17003*', engine='fnmatch').sort_index().index.tolist()
total_pov_vars
```




    ['B17003_001E',
     'B17003_002E',
     'B17003_003E',
     'B17003_004E',
     'B17003_005E',
     'B17003_006E',
     'B17003_007E',
     'B17003_008E',
     'B17003_009E',
     'B17003_010E',
     'B17003_011E',
     'B17003_012E',
     'B17003_013E',
     'B17003_014E',
     'B17003_015E',
     'B17003_016E',
     'B17003_017E',
     'B17003_018E',
     'B17003_019E',
     'B17003_020E',
     'B17003_021E',
     'B17003_022E',
     'B17003_023E']




```python
#ALLOCATION OF FOOD STAMPS BY POVERTY STATUS
foodstamps_bypov = conn.varslike('B22003*', engine='fnmatch').sort_index().index.tolist()
foodstamps_bypov
```




    ['B22003_001E',
     'B22003_002E',
     'B22003_003E',
     'B22003_004E',
     'B22003_005E',
     'B22003_006E',
     'B22003_007E']




```python
#EDUCATION STATUS
education = conn.varslike('B15003*', engine='fnmatch').sort_index().index.tolist()
education
```




    ['B15003_001E',
     'B15003_002E',
     'B15003_003E',
     'B15003_004E',
     'B15003_005E',
     'B15003_006E',
     'B15003_007E',
     'B15003_008E',
     'B15003_009E',
     'B15003_010E',
     'B15003_011E',
     'B15003_012E',
     'B15003_013E',
     'B15003_014E',
     'B15003_015E',
     'B15003_016E',
     'B15003_017E',
     'B15003_018E',
     'B15003_019E',
     'B15003_020E',
     'B15003_021E',
     'B15003_022E',
     'B15003_023E',
     'B15003_024E',
     'B15003_025E']



### Putting the data together and looking at it


```python
valley_pop = acs.from_msa(msa='Allentown-Bethlehem-Easton', variables=total_pop).sort_values(by = 'GEOID')
bethlehem_pop = acs.from_msa(msa='Allentown-Bethlehem-Easton', variables=total_pop).sort_values(by = 'GEOID')
```


```python
valley_pop.drop('geometry', axis=1).describe()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>B01003_001E</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>179.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>4652.458101</td>
    </tr>
    <tr>
      <th>std</th>
      <td>1713.124041</td>
    </tr>
    <tr>
      <th>min</th>
      <td>1648.000000</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>3370.500000</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>4421.000000</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>5823.500000</td>
    </tr>
    <tr>
      <th>max</th>
      <td>11085.000000</td>
    </tr>
  </tbody>
</table>
</div>




```python
f, ax = plt.subplots(1,1,figsize=(20,20))
valley_pop.plot('B01003_001E', ax=ax, cmap='YlGn')
ax.set_facecolor('k')
```


    
![png](output_24_0.png)
    



```python
sns.set(rc = {'figure.figsize':(40,20)})
sns.barplot( x = 'GEOID', y = 'B01003_001E', data=valley_pop)
```




    <AxesSubplot:xlabel='GEOID', ylabel='B01003_001E'>




    
![png](output_25_1.png)
    



```python

```
