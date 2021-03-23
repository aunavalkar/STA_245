#Example of Barplot 
hp_mpg<- ggplot(data = mtcars, mapping = aes(x = hp, y = mpg))
hp_mpg + geom_bar(stat= "identity", width = 1, fill = "magenta") + ggtitle("Barplot of mpg vs hp")

#Plotting interval data as a Barplot
ggplot(data = mtcars, aes(x = cut_interval(x=hp, n = 5), y = mpg))+geom_bar(stat = "identity",width = 0.5)+ xlab("MPG classes")

#Example of a boxplot
#invoke data Toothgrowth
data("ToothGrowth")
#Convert the column dose in to a factor and save it in a dataframe
ToothGrowth_1<-data.frame(len=ToothGrowth$len, dose=as.factor(ToothGrowth$dose))
#Plot the summary statistics as a box plot by dose (0.5, 1 or 2)
ggplot(data = ToothGrowth_1, mapping = aes(x= dose, y = len, fill= dose))+geom_boxplot()

#Pie Chart
ggplot(PlantGrowth, aes(x=factor(1), fill=group))+geom_bar(width = 1)+coord_polar("y")
