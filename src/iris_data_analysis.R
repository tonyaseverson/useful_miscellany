## ---- iris-pivoted

# Need to convert to tall and skinny df
iris_feature_species_df <- iris %>%
  pivot_longer(cols=-Species, 
               names_to="Feature",
               values_to="Measurement") %>%
  separate(col = Feature, into = c("Part", "Dimension"), remove = TRUE)

head(iris_feature_species_df)


## ---- iris-boxplot --------------
# (Fine to add extra hyphens at end)

# Convert vectors to factors and split Features into flower part and dimension
iris_feature_species_df$Species <- factor(iris_feature_species_df$Species)
iris_feature_species_df$Part <- factor(iris_feature_species_df$Part)
iris_feature_species_df$Dimension <- factor(iris_feature_species_df$Dimension)

# Create boxplots representing species-feature measurements

iris_feature_species_df %>%
  ggplot(aes(Part, Measurement)) +
  geom_boxplot(aes(fill=Dimension)) + 
  facet_grid(Species ~ .) +
  ggtitle("Widths and lengths of flower parts in Iris species") +
  labs(x="Flower part", y="Measurement (cm)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))




  