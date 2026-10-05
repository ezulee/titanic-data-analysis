# Titanic Survival Analysis

An interactive R Shiny application for exploring survival patterns among passengers and crew aboard the Titanic. Users can filter the data by passenger class, age group, and gender, then compare survivor counts and class-level survival rates.

## Live application

[Launch the Titanic Analysis Shiny app](https://jleenov.shinyapps.io/Titanic_Analysis/)

## Features

The application contains two analysis tabs:

1. **Demographic survival comparison**
   - Select 1st, 2nd, 3rd, or Crew class.
   - Select one or more age groups and genders.
   - View an interactive Plotly bar chart of survived versus not survived counts.
   - View the corresponding summary table.

2. **Class and survival rate**
   - Compare survival percentages across passenger classes and crew.
   - View a fitted linear trend for a simple visual summary of the pattern.

## Dataset

The project uses R's built-in `Titanic` contingency table. The table is converted to a data frame with five variables:

| Variable | Description |
| --- | --- |
| `Class` | 1st, 2nd, 3rd, or Crew |
| `Sex` | Male or Female |
| `Age` | Child or Adult |
| `Survived` | Yes or No |
| `Freq` | Number of people represented by the row |

Because the dataset is included with R, no external data download is required.

## Main observations

- First-class passengers have the highest overall survival rate among the passenger classes.
- Survival generally declines from 1st to 3rd class; crew members are included as a separate comparison group.
- Women and children in 1st and 2nd class show particularly high survival counts.
- Third-class children and women experienced substantially higher mortality than the same demographic groups in the upper classes.

The fitted line is intended as a descriptive trend only. Passenger class is ordinal rather than truly continuous, and crew members represent a distinct role rather than a fourth passenger class.

## Technologies

- R
- Shiny
- Plotly
- dplyr
- ggplot2
- R Markdown

## Repository contents

| File | Description |
| --- | --- |
| [`app.R`](app.R) | Complete Shiny application |
| [`titanic-analysis.Rmd`](titanic-analysis.Rmd) | Analysis narrative and documented application code |
| [`titanic-analysis.pdf`](titanic-analysis.pdf) | Rendered project report |
| `rsconnect/` | shinyapps.io deployment metadata |

## Run locally

Install the required packages in R:

```r
install.packages(c("shiny", "plotly", "dplyr", "ggplot2"))
```

Clone the repository, set the repository folder as the working directory, and run:

```r
shiny::runApp()
```

Alternatively, open `app.R` in RStudio and select **Run App**.

## Author

Jiyoo Lee  
DAT 301 Project
