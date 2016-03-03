# Workshop script
#
# Basic script showing how to use 'ggplot2'
#
# Author: Matthias Grenié

# 01: Load Package -------------------------------------------------------------

library(ggplot2)



# 02: Load dataset -------------------------------------------------------------

data(trees)



# 03: Qplot --------------------------------------------------------------------

# Just as 'plot()'
qplot(trees$Girth, trees$Volume)

# Better syntax
qplot(data = trees, x = Girth, y = Volume)

# With title
qplot(data = trees, x = Girth, y = Volume, main = "Figure title")



# 04: 'ggplot()' & aesthetics principle ----------------------------------------

# Simple ggplot2 usage
ggplot(data = trees, aes(x = Girth, y = Volume)) +
  geom_point()

# Store it into an object
p = ggplot(data = trees, aes(x = Girth, y = Volume)) +
  geom_point()

# Print it!
p

## Add a new aesthetics: color!
ggplot(data = trees, aes(x = Girth, y = Volume, color = Height)) +
  geom_point()

## Can include given aesthetics in 'geom_point()'
ggplot(data = trees) +
  geom_point(aes(x = Girth, y = Volume, color = Height))

# Or
ggplot() +
  geom_point(data = trees, aes(x = Girth, y = Volume, color = Height))

## Other aesthetic: size!
ggplot(data = trees, aes(x = Girth, y = Volume, size = Height)) +
  geom_point()

## Add fixed attribute to data
# Add it OUTSIDE 'aes()' function
ggplot(data = trees, aes(x = Girth, y = Volume)) +
  geom_point(color = "darkblue")

# 05: other 'geometric' objects ------------------------------------------------
# **Same** data **different** representations

# Make a line
ggplot(data = trees, aes(x = Girth, y = Height)) +
  geom_line()

# Line & Point
ggplot(data = trees, aes(x = Girth, y = Height)) +
  geom_line() +
  geom_point()

# Make a histogram, does not need aesthetic 'y'
ggplot(data = trees, aes(x = Girth)) +
  geom_histogram()

# Add simple smoother grasp the smoothing
# ORDER matters -> here points are UNDER regression line
# "First in ggplot function = closer to the background"
ggplot(data = trees, aes(x = Girth, y = Height)) +
  geom_point() +
  geom_smooth(method = "lm")

# Reverse layers example
ggplot(data = trees, aes(x = Girth, y = Height)) +
  geom_smooth(method = "lm") +
  geom_point()

# Combine with one more aesthetic SPECIFIC to points
ggplot(data = tress, aes(x = Girth, y = Height)) +
  geom_smooth(method = "lm") +
  geom_point(aes(size = Volume))


# 06: Facetting ----------------------------------------------------------------
# = show subset of data in subplots

# Need another dataset
# check '?InsectSprays' to get info on data
data("InsectSprays")

head(InsectSprays)

# Simple density of all insects count
ggplot(InsectSprays, aes(x = count)) +
  geom_density()

# Draw one density per spray colored differently
ggplot(InsectSprays, aes(x = count, color = spray)) +
  geom_density()

# Split info (FACETS) horizontally
ggplot(InsectSprays, aes(x = count, color = spray)) +
  geom_density() +
  facet_grid(spray ~ .)

# Split densities vertically
ggplot(InsectSprays, aes(x = count, color = spray)) +
  geom_density() +
  facet_grid(. ~ spray)

# Free scales between facets
ggplot(InsectSprays, aes(x = count, color = spray)) +
  geom_density() +
  facet_grid(spray ~ ., scales = "free_y")



# 07: Scales -------------------------------------------------------------------
# Modify scales to plot your data on 'transformed' scales (log10, square root, 
# etc.)

# Put 'x' on log10 scale
ggplot(data = trees, aes(x = Girth, y = Height)) +
  geom_point() +
  scale_x_log10()

# Put 'x' and 'y' on log10 scale
ggplot(data = trees, aes(x = Girth, y = Height)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10()

# Another more flexible equivalent (change variable 'trans' to get other scales)
ggplot(data = trees, aes(x = Girth, y = Height)) +
  geom_point() +
  scale_x_continuous(trans = "log10")


# 08: Themes -------------------------------------------------------------------
# If you don't like default ggplot2 rendering you can use 'theme_*()' functions
# to get the look you like

p = ggplot(data = trees, aes(x = Girth, y = Height)) +
  geom_point()

# Default theme
p

# Black & White thme
p + theme_bw()

# 'classic' plots theme
p + theme_classic()

# Simple theme
p + theme_minimal()

# To customize your themes, you can look at the 'theme()' function or look into
# the 'ggthemes' package



# 09: Saving your plot ---------------------------------------------------------

# To save your plot use function 'ggsave()'
# It recognizes automatically the extension of the file '.pdf', or '.jpg', or
# '.png' for example see 'ggsave()' help for more formats
ggsave("myplot.pdf", plot = p)

# Specify arguments to save plot on A4 papers
ggsave("myplotA4.pdf", plot = p, width = 21, height = 29.7, units = "cm")

# Specify resolution with 'dpi' argument
ggsave("myplot.jpg", plot = p, dpi = 300)