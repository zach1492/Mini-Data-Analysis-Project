
# Simple Data Analysis Demo

# Load libraries
library(dplyr)
library(ggplot2)

# Create sample dataset
set.seed(42)

data <- data.frame(
  student_id=1:100,
  study_hours = rnorm(100, mean = 5, sd = 2),
  stress_level = rnorm(100, mean = 60, sd = 10)
)

# Clean up data
data <- data %>%
  mutate(
    stress_level = ifelse(stress_level < 0, 0, stress_level)
  )

# Summary statistics
summary_stats <- data %>%
  summarise(
    mean_study = mean(study_hours),
    mean_stress = mean(stress_level),
    sd_stress = sd(stress_level)
  )

print(summary_stats)

# Simple linear regression
model<- lm(stress_level ~ study_hours, data = data)
summary(model)

# Visualisation
ggplot(data, aes(x = study_hours, y = stress_level)) +
  geom_point(color="blue") +
  geom_smooth(method = "lm", color = "red") +
  labs(
    title = "Stress vs Study Hours",
    x = "Study Hours",
    y ="Stress Level"
  )

# Group example
data <- data %>% 
    mutate(study_group = ifelse(study_hours > 5, "High", "Low"))

group_summary <- data %>%
  group_by(study_group) %>%
  summarise(
    avg_stress = mean(stress_level),
    count = n()
  )

print(group_summary)