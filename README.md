# Project 4: Collaborative Filtering

### [Project Description](doc/project4_desc.md)

Term: Fall 2017

+ Team # 8
+ Projec title: Collaborative Filtering

+ Team members
	+ Chenyun Wu
	+ Sihui Shao
	+ Sijian Xuan
	+ Yajie Guo
	+ Yiran Li
	
+ Project summary: 
In this project, we implemented collaborative filtering to make automatic predictions (filtering) about the interests of a user by collecting preferences or taste information from many users (collaborating). We also evaluated and compared a pair of algorithms for collaborative filtering. Firstly, spearman correlation, entropy, mean-squared-difference and simrank were used to get the similarity matrix, at the same time, we added significance weighting or variance weighting to similarity. Secondly, neighbors were selected by combining weighting threshold and best-n-estimator. Once the neighborhood has been selected, the ratings from those neighbors are combined to compute a prediction, after possibly scaling the ratings to a common distribution. Besides, we also tried cluster models to conduct the similar process. For evaluation part, we used ranked scoring for the first data set, while mean absolute error(MAE) was used for the movie data set.

![image](figs/framework.png)

+ Result:
All in all, movie data has the lowest MAE 2.187 when conducted Entropy. Web data has the highest ranked score 72.09 when conducted under MSD & Neighbors. As for model-based algorithm, the lowest MAE achieved for movie data is 0.0004.

+ Please see ([main.Rmd](doc/main.Rmd)) in /doc for final report.

![image](figs/msweb.png)

![image](figs/movie.png)
	
**Contribution statement**: ([Contribution Statement](doc/a_note_on_contributions.md)) All team members collaborated closely, contributed equally in all stages of this project. All team members approve our work presented in this GitHub repository including this contributions statement. 

Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.
