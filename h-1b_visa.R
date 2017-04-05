library(ggplot2)
library(stringr)
library(dplyr)
library(sp)
library(RgoogleMaps)

data <- read.csv('h1b_kaggle.csv', stringsAsFactors = F)
# check dataset 
dim(data)
data <- na.omit(data)
dim(data)
names(data)
str(data)

# Separate cities from states into two different columns
data$City <- str_replace(data$WORKSITE, '(.+),.+', '\\1')
data$State <- str_replace(data$WORKSITE, '.+,(.+)', '\\1')

# Select only the 'Certified' with h1b visa cases
certified_df <- data%>%
      filter(CASE_STATUS == 'CERTIFIED')

# Select the states where the certified with 
# h1b visa where issued in total per year
# top 25 states
bar_df <- certified_df%>%
      group_by(State)%>%
      summarize(Total_Certified = n())%>%
      arrange(desc(Total_Certified))

topStates <- bar_df$State[1:25]

df2 <- certified_df%>%
      filter(State %in% topStates)

df2$State <- factor(df2$State, levels = topStates)

# bar chart of top 25 states for the last 6 years.
# visualizing total number of certified per each top 25 States
ggplot()+
      geom_bar(data = df2, aes(x = State), color = 'red')+
      scale_y_continuous(limits = c(0, 500000), 
                         breaks = seq(0, 500000, 50000))+
      ylab("Total Certified")+
      ggtitle("Top 25 states hiring the most")+
      theme(
            plot.title = element_text(size = rel(2)),
            panel.background = element_rect(fill = '#e0e0d1'),
            axis.text.x=element_text(angle = -90, hjust = 0),
            panel.grid.major.x = element_line(linetype = 'blank'), 
            panel.grid.major = element_line(colour = "#e8e8e8"),
            panel.grid.minor = element_line(linetype = 'blank')
      )

# top 25 states hiring the most but for each year seperatly.  
ggplot()+
      geom_bar(data = df2, aes(x = State), color = 'red')+
      scale_y_continuous(limits = c(0, 110000), 
                         breaks = seq(0, 110000, 10000))+
      ylab("Total Certified")+
      ggtitle("Top 25 states hiring the most")+
      facet_wrap(~ YEAR, ncol = 2)+
      theme(
            plot.title = element_text(size = rel(2)),
            panel.background = element_rect(fill = '#e0e0d1'),
            axis.text.x=element_text(angle = -90, hjust = 0),
            panel.grid.major.x = element_line(linetype = 'blank'), 
            panel.grid.major = element_line(colour = "#e8e8e8"),
            panel.grid.minor = element_line(linetype = 'blank')
      )

# select total number of certified per city
bar_city <- certified_df%>%
      group_by(City)%>%
      summarize(Count = n())%>%
      arrange(desc(Count))

topCities <- bar_city$City[1:50]

df_city <- certified_df%>%
      filter(City %in% topCities)

df_city$City <- factor(df_city$City, levels = topCities)

# plot total number of applications per each top 25 States
# for all years together
ggplot()+
      geom_bar(data = df_city, aes(x = City), color = 'black', fill = '#ffbf00')+
      scale_y_continuous(limits = c(0, 165000),
                         breaks = seq(0, 165000, 10000))+
      ylab("Total Certified")+
      ggtitle('Top 50 cities hiring the most')+
      theme(
            plot.title = element_text(size = rel(2)),
            panel.background = element_rect(fill = "#777777"),
            axis.text.x=element_text(angle = -90, hjust = 0),
            panel.grid.major.x = element_line(linetype = "blank"),
            panel.grid.major = element_line(colour = "#888888"),
            panel.grid.minor = element_line(linetype = "blank")
      )

topCities <- bar_city$City[1:25]

df_city <- certified_df%>%
      filter(City %in% topCities)

df_city$City <- factor(df_city$City, levels = topCities)

# plot total number of applications per each top 25 States
# for each separate years
ggplot()+
      geom_bar(data = df_city, aes(x = City), color = 'black', fill = '#ffbf00')+
      scale_y_continuous(limits = c(0, 35000),
                         breaks = seq(0, 35000, 5000))+
      ylab("Total Certified")+
      facet_wrap(~ YEAR, ncol = 2)+
      ggtitle('Top 25 cities hiring the most')+
      theme(
            plot.title = element_text(size = rel(2)),
            panel.background = element_rect(fill = "#777777"),
            axis.text.x=element_text(angle = -90, hjust = 0),
            panel.grid.major.x = element_line(linetype = "blank"),
            panel.grid.major = element_line(colour = "#888888"),
            panel.grid.minor = element_line(linetype = "blank")
      )

# Map of top 10 states hiring the most. 
bar_df <- certified_df%>%
      group_by(State)%>%
      summarize(Total_Certified = n())%>%
      arrange(desc(Total_Certified))

topStates <- bar_df$State[1:10]

df2 <- certified_df%>%
      filter(State %in% topStates)

h1b_df <- df2
h1b_df$lat <- as.numeric(h1b_df$lat)
h1b_df$lon <- as.numeric(h1b_df$lon)
coordinates(h1b_df) <- ~ lon + lat
proj4string(h1b_df) <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84")

map <- MapBackground(lat = h1b_df$lat, lon = h1b_df$lon)

PlotOnStaticMap(map, lat = h1b_df$lat, lon = h1b_df$lon, 
                GRAYSCALE = F, NEWMAP = T, pch = 21, 
                col = "#29a329", cex = 1.1, zoom = 1, FUN = points)

# Map of top 25 cities hiring the most. 
bar_city <- certified_df%>%
      group_by(City)%>%
      summarize(Count = n())%>%
      arrange(desc(Count))

topCities <- bar_city$City[1:25]

df_city <- certified_df%>%
      filter(City %in% topCities)

h1b_df2 <- df_city
h1b_df2$lat <- as.numeric(h1b_df2$lat)
h1b_df2$lon <- as.numeric(h1b_df2$lon)
coordinates(h1b_df2) <- ~ lon + lat
proj4string(h1b_df2) <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84")

map <- MapBackground(lat = h1b_df2$lat, lon = h1b_df2$lon)

PlotOnStaticMap(map, lat = h1b_df2$lat, lon = h1b_df2$lon, 
                GRAYSCALE = F, NEWMAP = T, pch = 19, 
                col = "#29a329", cex = 1.5, zoom = 1, FUN = points)

# preparing data for a line chart based on the
# per year mean of wage of total certified h1b visa cases
certified_pay <- certified_df%>%
      group_by(YEAR, CASE_STATUS)%>%
      summarize(avgPay = mean(PREVAILING_WAGE, na.rm = T))%>%
      arrange(desc(avgPay))

# line chart for certified foreign workers with h1b visas
ggplot()+
      geom_line(data = certified_pay, aes(x = YEAR, y = avgPay), 
                size = 1.5, colour = "#cb0000")+
      geom_point(data = certified_pay, aes(x = YEAR, y = avgPay), 
                 size = 1.5, colour = "black")+
      ylab("Average Payment")+
      scale_y_continuous(limits = c(65000, 80000), 
                         breaks = seq(65000, 80000, 2500))+
      ggtitle("Average salary for certified H-1B cases")+
      theme(
            plot.title = element_text(size = rel(2)),
            panel.background = element_rect(fill = '#eeeedd'),
            panel.grid.major.x = element_line(linetype = 'blank'),
            panel.grid.minor = element_line(linetype = 'blank')
      )

# bar chart of top 25 job titles
bar_title <- certified_df%>%
      group_by(JOB_TITLE)%>%
      summarize(Job_titles = n())%>%
      arrange(desc(Job_titles))

topJobs <- bar_title$JOB_TITLE[1:25]

job_title <- certified_df%>%
      filter(JOB_TITLE %in% topJobs)

job_title$JOB_TITLE <- factor(job_title$JOB_TITLE, levels = topJobs)

# visualizing total number of applications per each top 25 job titles
ggplot()+
      geom_bar(data = job_title, aes(x = JOB_TITLE), color = 'black', 
               fill = '#29a329')+ 
      scale_y_continuous(limits = c(0, 220000),
                         breaks = seq(0, 220000, 10000))+
      ggtitle('Top 25 job titles between 2011-2016')+
      theme(
            plot.title = element_text(size = rel(2)),
            panel.background = element_rect(fill = '#f0f0f0'),
            axis.text.x=element_text(angle = -90, hjust = 0),
            panel.grid.major.x = element_line(linetype = 'blank'),
            panel.grid.major = element_line(colour = "#e8e8e8"),
            panel.grid.minor = element_line(linetype = 'blank')
      )

# visualizing total number of applications per each top 25 job titles
# for every given year.
ggplot()+
      geom_bar(data = job_title, aes(x = JOB_TITLE), color = 'black', 
               fill = '#29a329')+ 
      scale_y_continuous(limits = c(0, 50000),
                         breaks = seq(0, 50000, 10000))+
      facet_wrap(~ YEAR, ncol = 2)+
      ggtitle('Top 25 job titles for each year of 2011-2016')+
      theme(
            plot.title = element_text(size = rel(2)),
            panel.background = element_rect(fill = '#f0f0f0'),
            axis.text.x=element_text(angle = -90, hjust = 0),
            panel.grid.major.x = element_line(linetype = 'blank'),
            panel.grid.major = element_line(colour = "#e8e8e8"),
            panel.grid.minor = element_line(linetype = 'blank')
      )

# prepare data for boxplot. Showing 
# the difference in 'Certified' & 'Denied' cases
h1b_boxplot <- data%>%
      filter(CASE_STATUS == 'CERTIFIED' | CASE_STATUS == 'DENIED')

# plot boxplot
ggplot(aes(y = PREVAILING_WAGE, x = CASE_STATUS, fill = CASE_STATUS), 
       data = h1b_boxplot) + 
      geom_boxplot(notch = TRUE) + 
      scale_y_continuous(limits = c(0, 150000), 
                         breaks = seq(0, 150000, 5000)) + 
      ggtitle("Wages for certified & denied H1B cases")+
      theme(
            plot.title = element_text(size = rel(2)),
            panel.background = element_rect(fill = 'light gray'),
            panel.grid.major = element_line(colour = '#f0f0f0'),
            panel.grid.major.x = element_line(linetype = 'blank'),
            panel.grid.minor = element_line(linetype = 'blank')
      )

# boxplot for each given year. 
ggplot(aes(y = PREVAILING_WAGE, x = CASE_STATUS, fill = CASE_STATUS), 
       data = h1b_boxplot) + 
      geom_boxplot() + 
      scale_y_continuous(limits = c(0, 120000), 
                         breaks = seq(0, 120000, 10000)) + 
      ggtitle("Wages for certified & denied H1B cases")+
      facet_wrap(~ YEAR, ncol = 2)+
      theme(
            plot.title = element_text(size = rel(2)),
            panel.background = element_rect(fill = 'light gray'),
            panel.grid.major = element_line(colour = '#f0f0f0'),
            panel.grid.major.x = element_line(linetype = 'blank'),
            panel.grid.minor = element_line(linetype = 'blank')
      )

