# H-1B visa (working permit) in United States

### Exploring dataset from kaggle.com on H-1B visas for froeign workers. 

The codes for the visualizations below are in the `h-1b_visa.R` file of this repository. This is my second time analyzing this type of data. The first time was more than a year ago with the data downloaded from United States Department of Labor. I used `tableau` then and the results are slightly different since that dataset included more variables and wider range of years. If interested for the difference between the two check [here](https://public.tableau.com/profile/elton.islamaj#!/vizhome/WhichforeignsareallowedtoworkinU_S_/Story1)  

### Few things to know before exploring the data.

#### H-1B is issued to foreign workers who:

1. In most cases have at least a college degree.
2. Are skilled workers, have expertise in the field being hired. 
3. Usually the skills they have are on demand.
4. Usually have finished their studies in US  

#### What are the criteria for a non U.S citizen to acuire the H-1B?

1. A job offer matching person's expertise/education
2. Salary for the job needs to match the job title/position & to be the same with what the other jobs in the area are paying.
3. There are no US citizens with the same skill sets for the job position.
4. The job position needs to be advertised online or on local newspaper etc.
5. A bachelor's degree or higher is required.   

I will explore the dataset only for the foreigns who were certified with H-1B (allowed to work) in United States. Also, I will try to explore the dataset based on the above points. 


#### In which states were the foreign workers able to find jobs?

Visualizing top 25 states for the total cases of H-1B visa issued between the years of 2011-2016.   

![topstates](https://cloud.githubusercontent.com/assets/22155935/24691368/086ddbba-19a1-11e7-90b8-7e9ad3552583.png)  

California seems to be the outlier among the other states.   
Let's plot again top 25 states hiring the most but for each year seperatly.  

![tstate](https://cloud.githubusercontent.com/assets/22155935/24711386/d3520e2c-19ed-11e7-8f8f-abc1beaf2eea.png)  


#### In which cities were the foreign workers able to find jobs?

Visualizing top 50 cities for total certified with H-1b cases were issued between years of 2011-2016.  

New York City seems to be the outlier with more than 57% difference from Houston ranked as the second city hiring the most. As we saw above, New York City alone surpases its state of New York by almost double for the total number of certified H-1B cases for all the years.  
![topcities](https://cloud.githubusercontent.com/assets/22155935/24691375/157dfd62-19a1-11e7-98ee-8fca2ace652b.png)  

#### Visualizing top 25 cities for each year.  


![tcities](https://cloud.githubusercontent.com/assets/22155935/24712098/e2be0dfa-19ef-11e7-8e91-6910969bae29.png)  


#### Map of top 10 states hiring the most.  


![mapstates1](https://cloud.githubusercontent.com/assets/22155935/24716881/730e8606-19fe-11e7-8ae8-3d1a492e5b43.png)  


#### Map of top 25 cities hiring the most.  

![mapcities2](https://cloud.githubusercontent.com/assets/22155935/24716888/7ab60b2c-19fe-11e7-93c5-74c488acbab4.png)  


#### What is the average salary for certified foreign workers with H-1B visas?  


![wage](https://cloud.githubusercontent.com/assets/22155935/24691433/6792d668-19a1-11e7-92ff-2ee41df139b6.png)  

#### What are the job titles for foreign workers certified with H-1B visas?  

Visualizing top 25 job titles for all the years together.  

![jobtitle](https://cloud.githubusercontent.com/assets/22155935/24691451/7c327af6-19a1-11e7-9078-9c8f92031dcf.png)  

Visualizing top 25 job titles for each given year.  


![jtitle](https://cloud.githubusercontent.com/assets/22155935/24712106/ea60e154-19ef-11e7-9cf9-9379bac5a6b1.png)  


#### What is the difference in average payment for 'Certified' & 'Denied' cases?  


![bplot1](https://cloud.githubusercontent.com/assets/22155935/24716898/82937c62-19fe-11e7-96d8-4616560860d6.png)  


#### What is the difference in average payment for 'Certified' & 'Denied' cases per each given year?  

![bplot2](https://cloud.githubusercontent.com/assets/22155935/24716904/87d29474-19fe-11e7-9650-320273c5b62c.png)  


#### Conclusion


* Most of the people certified with H-1B found jobs on metropolitan cities. 
* Eight out of top ten states are located on the east & west coast of U.S.
* These areas are also known as having a large number of businesses in technology.
* Top job titles were computer related skills. 
* Average wage per each given year for people certified with H-1B was always higher then those denied H-1B. 
* The last chart (boxplot) shows that certified cases are always at minimum payment more than 10k (but for the year of 2012) compare to denied that always start at 0, but for the year of 2013. 
* Average wage per each given year for certified people with H-1B matches the US average wage for US citizens with an advance degree.  

---
