# **Google Case Study 2: Bellabeat Insights** 
<font size="2"> *Welcome to my analysis of Bellabeat data!* 😊 *This is  the final step in completing Coursera's Google Data Analytics Certificate program. If you have any questions or comments about my analysis, please comment or message me - I would love to hear your thoughts and ways for me to improve!*
-----    
# <font size="5"> Scope of Work </font>   
**Purpose**: The goal of this project is to analyze fitness data to discover opportunities for Bellabeat’s business. Specifically, I will observe smart device data to learn how consumers are using their devices, which will help guide Bellabeat’s marketing direction.
   
The goals of my research aim to answer the following questions:
- What are some trends in smart device usage?
- How could these trends apply to Bellabeat customers?
- How could these trends help influence Bellabeat marketing strategy?

By answering these questions I will be able to provide insight into how Bellabeat should market their fitness products to potential customers. 

**Scope/Major Point of Activities**:

- Define the terms: Fitness products include watches, necklaces, clips, water bottles
- Collect data - online searches from reliable organizations: Download provided FitBit fitness tracker data, consider finding other datasets on Medium, Kaggle, Github, etc. to use for further analysis. Make sure data is compatible - is it measuring the same units, timespans, etc.?
- Analyze - compare data across systems and compile them based on category: Analyze the data by comparing data sets, identifying what consistent items are being reported across the sets. Decide if anything is missing and account for that below. Finally, compile the data, grouping them into categories, clean, then analyze. 
- Report findings: Create visuals for stakeholders to assess and discuss the project. 

**Not Included**:

- This analysis does not include discussion of whether those who use smart fitness devices are healthier than those who do not. 
- This analysis does not relay any opinion as to whether everyone should have a fitness tracking device. 
- I will not myself be conducting any surveys or creating any new data. 

**Deliverables**:

- A clear summary of the business task
- A description of all data sources used
- Documentation of any cleaning or manipulation of data
- A summary of your analysis
- Supporting visualizations and key findings
- Your top high-level content recommendations based on your analysis

**Schedule Overview/Major Milestones**:

- Milestone 1 (08/13/2021): Terms are defined and all data is collected. Complete the gathering and combining of data and data sources.

- Milestone 2 (08/14/2021): All data is cleaned and processed. After meeting with the team, decide what will be analyzed and analyze it. 

- Milestone 3 (08/15/2021): Analyze data. 

- Milestone 4 (08/15/2021): Visualize and present. Create interactive dashboard that can be presented to and discussed with stakeholders. 

**Estimated Date of Completion**: August 16, 2021

# <font size="5"> Ask
The first step in any analysis is making sure you understand the problem at hand that the data is trying to solve. To do this we need to understand who the stakeholders are, as well as what exactly is the business problem. 
    
**Stakeholders** include Urška Sršen, Bellabeat’s cofounder and Chief Creative Officer; Sando Mur, Bellabeat’s other cofounder and key team member; and Bellabeat's marketing analytics team.

The **products** the analytics team can choose from to observe and analyze to improve their marketing initiatives include data collected from their Bellabeat app, their fitness tracker accessory Leaf, their Time watch, their Spring water bottles, and their subscription-based membership. 

Sršen has stated that the analytics team's **objective** is to analyze user data to derive insights into how consumers use fitness products. After uncovering these insights, the analytics team is to apply what they have learned to one Bellabeat product and recommend opportunities for improving or creating new marketing strategies. 

# <font size="5"> Prepare
The second step for analyzing data is the prepare phase. This phase involves determining what data is appropriate for our analysis, ensuring the data is credible and ethical, as well as properly accessing and organizing the data. 

The data I will be using for this analysis was already provided to me, so I will not be collecting any additional data for this project. Knowing where the data is **stored** and who created it is an important step in validating the data. The dataset for this project was created by Möbius and is publicly availble on Kaggle, found [here](https://www.kaggle.com/arashnic/fitbit).

In terms of **credibility**, on the surface this data shows some concerns. For instance, the data only has 30 unique identifiers, which is an extremely small sample of the entire population. However, in order to fully assess the validity of this dataset, let's see if it "ROCCCs." Below the acronym is filled out, along with a spectrum of ratings where 1 represents a weak aspect of the data and 5 represents a strong aspect of the data. 
    
**R - Reliability**<span style="color:crimson;"> (2 out of 5). </span>: It is unclear as to whether the data collected was randomly distributed. In addition, with data collected from only 30 participants, our dataset is quite small and thus possibly not representative of the true population. However, the data seems to be collected from a well-established company (see "Cited" below), which lends it some credibility.
 
**O - Originality**<span style="color:crimson;"> (2 out of 5). </span>: The data was collected from a third-party entity, Amazon Mechanical Turk. There is limited information on how the surveys were collected or distributed, so we can not be sure if they are random. This could be problematic because of its potential for bias - without random sampling we are not getting a true picture of the overall population. 
    
**C - Comprehensive**<span style="color:crimson;"> (2 out of 5). </span>: The dataset is not very comprehensive - it only encompasses the data from 30 individuals. Additionally, with the data being collected only over a span of two months, it is not comprehensive. In other words, we are unable to determine whether fitness tech usage changes month-over-month as we are missing 10 months' worth of data. 
    
**C - Current**<span style="color:orange;"> (3 out of 5). </span>: The dataset was released on Kaggle in January 2021, about six months before writing this project. However, the data itself was taken from March 12, 2016 through May 12, 2016. This means the data is 5 years outdated and, subsequently, may not be reliable. 
    
**C - Cited**<span style="color:green;"> (4 out of 5). </span>: The dataset is cited from a place called Zenodo which, after a brief Google search, seems to be a fairly reputable website where large data can be shared publicly and used by anyone interested in accessing it. In addition, the data is said to be collected from researchers (Robert Furberg, Julia Brinton, Michael Keating, and Alexa Ortiz) from RTI International, a well-established non-profit organization providing research and technical services. 

The dataset clearly is not the most comprehensive, so my analysis likely will not fully represent the population. The data provided will help identify trends in Bellabeat users specifically, which is what Bellabeat is looking for; however, the analysis would likely be more representative and insightful if used alongside another dataset and/or additional information collected by Bellabeat. 
   
After identifying the data' integrity, it is time to prepare the data for analysis. 

# <font size="5"> Process
When processing the data, I first changed all the date-related columns to the date data type "YYY-MM-DD" as this is how MySQL Workbench marks dates. I also looked briefly at some columns in the Weight and Minutes_Sleep tables as I knew I wouldn't need and deleted those. 

I then cleaned data in SQL by:

- Ensuring the data type matched the data (eg SleepDay and Activty Date were both of the date data type)
- Dropping columns that were either duplicative or something I would not need to use, including the columns "Fat, WeightKg, and LogId" from the Weight table, as well as dropping the date and id columns after joining tables
- Removing rows where TotalSteps = 0, which indicated that the user was not wearing their tracker that day

# <font size="5"> Analyze
After joining the daily_activity, minutes_sleep, and weight tables I learned a few things: 

**Stats**:
- On average, the users were inactive 78% of the time
- The average number of calories burned per day by all users is 2,343
- Average distance users walked per day is 5.98 miles
- Only 8 of 33 users recorded their weight
- Users spent an average of about 6.8 hours asleep each night
- The average weight recorded was 158.8 lbs, with a minimum weight recording of 116 lbs and a maximum weight of 294.3 lbs
- 9 of 33 users did not record their sleep data, and 2 of 33 users had non-conclusive recordings (i.e. their average time asleep was < 2 hr per night)

**Observations**:
- Weight isn't being recorded frequently by users
- Many users aren't recording their sleep data

**Correlations**:
- Average steps taken per day doesn't necessarily correlate with the average amount of calories burned per day
- More time asleep is not necessarily correlated with the amount of calories one burns in a day
- For those who recorded their weight, users who weight < 200 lbs are much more likely to exercise than those who weight > 200 lbs

# <font size="5"> Share
After analyzing the data, I would share my analysis with Bellabeat stakeholders. The recommendations I would make to them based off of my findings include:

- Record ages of customers so more data can be collected based on age, which can then translate to targeted marketing strategies for specific age groups.
- Find ways to encourage users to be more active throughout the day as, on average, users were only active 22% during the day. This could possibly be done by showing users, perhaps upon signing up to the subscription or buying a product, how those who are more active weigh less (however, it's important to note that of the 8 people who recorded weight from this dataset, only one user recorded being very overweight).
- Prompt users to record their weight, perhaps by building an in-app graphic that shows weight progress from the data. In addition, Bellabeat could create a scale that has some bluetooth connectivity with their app to record this data so users don't have to enter the information manually. This would also give Bellabeat another product on the market that could bring in additional revenue.
- Find a way to make Leaf more comfortable so users are more likely to wear it to bed, or create a better product users can wear to track their sleep.
- Before bedtime, prompt users to charge their devices so all sleep data will be collected throughout the night. 
- Build in competitions into the app or membership subscription where users can connect with each other, compete against friends and/or the community, etc. to make users more active and engage more with Bellabeat products. 

# <font size="5"> Act
While it is up to Bellabeat to act on my findings, I am open to providing further insight or answering additional questions that were missed in our discussion during the Share phase. Perhaps the company will ask me to analyze the data further or ask me for help on future projects. 

**Going forward**:
- Visualization tools (e.g. Tableau) are needed to better identify trends and convey ideas to stakeholders
- This dataset was quite small; a larger dataset would be better at identifying true population trends and correlations
- Collecting data from longer periods of time would be useful for further analysis
