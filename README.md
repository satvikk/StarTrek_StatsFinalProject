# StarTrek_StatsFinalProject

Star Trek is a Science Fiction media franchise spanning several TV shows, movies, books, and video games. This analysis focused on four Star Trek TV shows that ran in sequence from 1987 through 2005, with significant overlaps in the years they each ran. The questions of interest are:

- Which characters have the greatest influence on the ratings of episodes, either positive or negative?
- Are their differences in quality across the directors?
- Are their differences in quality across the four shows and their constituent seasons?

To answer these questions, I use the IMDb ratings of the episodes. I model the data using hierarchical linear regressions and answer the questions using the estimates from this model. The most important results were that there are significant differences in quality across the seasons of the shows. Some of the characters are found to have strong associations between their screentime and corresponding episode ratings. Screentime of Sisko from Star Trek: Deep Space 9 and Paris from Star Trek: Voyager have the strongest positive impact on episode ratings whereas screentime of Dr. Crusher, Troi, and Wesley from Star Trek: The Next Generation, and Dax from Star Trek: Deep Space 9 have the strongest negative impact on the ratings.


Sample Results:
![Alt text](report/show_season_dotplot.png?raw=true)
![](report/screentime_coef.png?raw=true)
Here, ScreenTime Coefficient is the estimate of change in rating vs change in screentime of character by one percentage point
Checkout ./reports/report.pdf for the full analysis
