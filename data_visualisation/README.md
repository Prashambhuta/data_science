# Data Visualisation in R
## Quantiles & Normal Distribution

## `ggplot` - basics

### Layers to consider

    1. data
    2. geometry
    3. aesthetic mapping components
    4. scale of plot
    5. labels, title, legend etc.
    6. theme/styling


1. data

> pipe the data using `p <- data %>% ggplot(aes(x = , y = , label = ))`

2. geometry
    * geometry types:
        * Scatter Plot: `geom_point`
            * in `aes()` add: `x = , y = `
                > `p <- p + geom_point()`
        * Text or label plot: `geom_text` or `geom_label`
            * in `aes()` add: `label = ` 
            * add `color =` 
                > `p <- p + geom_label(color = )`
            * add `factor` as `color`:
               * in `aes()` add `color = `
                > `aes(x = , y = , label = , color = "blue")`
        * Histogram plot: `geom_histogram`
            * in `aes()` add: `x = `
            * for `binwdith`:
                > `geom_histogram(bindwith = )`
        * Density plot: `geom_density`
            * to group:     in `aes()` add: `group = `
            * to color:     in `aes()` add: `color = `
            * to fill:      in `aes()` add: `fill = `
            * for transparency: in `geom_density` add: `alpha =`


3. aesthetic mappings

4. scale

    * convert to log scale:
        > `p <- p + scale_x_log10()`

        or

        > `p <- p + scale_x_continuous()`

5. labels, title, legend
    * add title:
        > `p + ggtitle("Enter plot title")`

6. theme/styling

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



