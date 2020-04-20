## `dplyr` functions

* `filter` - to filter interested columns from dataframe
* `group_by` - to group the columns based on categorical data
* `summarise` - to perform actions on the filtered columns
* `arrange` - to sort the `statistical inference`
* `.$` (dot placeholder) - to select single numeric/categorical value from a table.
* `top_n` - to display the top `n` numbers of row from the table

## Examples

```R
murders <- murders %>% arrange(desc(total*1000000/population))
```

```R
heights %>% filter(sex=='Male') %>% summarise(average=mean(height),standard_deviation=sd(height), median=median(height), minimum=min(height), maximum=max(height))
```

```R
group_by_summary <- heights %>% group_by(sex) %>% summarise(average_height = mean(height), standard_deviation = sd(height))
```