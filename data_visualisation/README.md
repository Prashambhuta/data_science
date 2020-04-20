# Data Visualisation using R

This dir contains information on:

## Base R plots
* Box Plot
* Density Plot

## `ggplot` examples

* histogram plot
```r
heights %>% ggplot(aes(height)) + geom_histogram()
```

* density plot
```r
heights %>% ggplot(aes(height)) + geom_density()
```

* scatter plot
```r
murders %>% ggplot(aes(x = , y = )) + geom_point() + scale_x_continuous("log10") + scale_y_log10()
```
* label / text plot
```r
murders %>% ggplot(aes(x = , y = , label = )) + geom_label() + ggtitle("Plot Title")
```


## `dplyr` examples

* arrange()

```R
murders <- murders %>% arrange(desc(total*1000000/population))
```

* filter() + summarise()

```R
heights %>% filter(sex=='Male') %>% summarise(average=mean(height),standard_deviation=sd(height), median=median(height), minimum=min(height), maximum=max(height))
```

* group_by()

```R
group_by_summary <- heights %>% group_by(sex) %>% summarise(average_height = mean(height), standard_deviation = sd(height))
```

* `.$` 
```r
murders %>% summarise(rate=sum(total)*1000000/sum(population)) %>% .$rate
```