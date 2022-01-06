# Star Trek: The Analysis 🖖 <img width=90 align="right" src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Duke_University_logo.svg/1024px-Duke_University_logo.svg.png">
Statistical Analysis of Episode Ratings across four TV shows for [IDS702 class](https://ids702-f21.olanrewajuakande.com) @ Duke University.


Star Trek is a Science Fiction media franchise spanning several TV shows, movies, books, and video games. This analysis focused on four Star Trek TV shows that ran in sequence from 1987 through 2005, with significant overlaps in the years they each ran.

Checkout [./reports/report.pdf](https://github.com/satvikk/StarTrek_StatsFinalProject/blob/main/reports/report.pdf) for the full analysis.

## Data 
- IMDb Ratings and Episode information from https://datasets.imdbws.com (collected on Nov 23, 2021). This formed the source for the tabular data used in the analysis
- Script Data from www.chakoteya.net/StarTrek/. This was the source for the script of each episode in text form. This was used to calculate a proxy for each character's relative screentime in each episode. This proxy variable was then merged with the tabular data 
- Four TV Shows: 
  - Star Trek: The Next Generation (1987–1994)
  - Star Trek: Deep Space 9 (1993–1999)
  - Star Trek: Voyager (1995–2001)
  - Star Trek: Enterprise (2001–2005)
- 614 Episodes in all
- Relevant Variables: 
  - Name of Director(s)
  - Name of writer(s)
  - Episode Rating
  - Proxy Character Screentimes for main characters (33 in all)

## Research Question 🔬
- Which characters have the greatest influence on the ratings of episodes, either positive or negative?
- Are their differences in quality across the directors?
- Are their differences in quality across the four shows and their constituent seasons?

## Methodology 🛠️
- Data Cleaning

To answer these questions, I use the IMDb ratings of the episodes. I model the data using hierarchical linear regressions and answer the questions using the estimates from this model. The most important results were that there are significant differences in quality across the seasons of the shows. Some of the characters are found to have strong associations between their screentime and corresponding episode ratings. Screentime of Sisko from Star Trek: Deep Space 9 and Paris from Star Trek: Voyager have the strongest positive impact on episode ratings whereas screentime of Dr. Crusher, Troi, and Wesley from Star Trek: The Next Generation, and Dax from Star Trek: Deep Space 9 have the strongest negative impact on the ratings.


Sample Results:  


![Alt text](./reports/show_season_dotplot.png?raw=true)
![plot](./reports/screentime_coef.png?raw=true)


Here, ScreenTime Coefficient is the estimate of change in rating vs change in screentime of character by one percentage point


