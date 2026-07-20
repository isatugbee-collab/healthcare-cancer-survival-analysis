###############################################################
# Project: Cancer Patient Outcomes Analysis
# Author : Isatu Bah
# Purpose: Import and prepare data for regression analysis
# Date   : July 2026
###############################################################

# Connect R to SQL Server
con <- dbConnect(
  odbc::odbc(),
  Driver = "ODBC Driver 18 for SQL Server",
  Server = "LAPTOP-T4LB090R\\SQLEXPRESS",
  Database = "cancerpatientanalysis",
  Trusted_Connection = "Yes",
  TrustServerCertificate = "Yes"
)
#Test the connection
dbListTables(con)

#Import the table into R
cancer_data <- dbReadTable(
  con,
  "india_cancer_patients_2022_2025"
)
#confirm
dim(cancer_data)
head(cancer_data)
names(cancer_data)
str(cancer_data)

#Exploratory Data Analysis (EDA)
summary(cancer_data)

colSums(is.na(cancer_data))

#Create Histogram
ggplot(cancer_data, aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "steelblue", color = "white") +
  labs(
    title = "Distribution of Patient Age",
    x = "Age",
    y = "Number of Patients"
  ) +
  theme_minimal()

#Average Survival by Stage
cancer_data %>%
  group_by(Stage) %>%
  summarise(
    Average_Survival = mean(Survival_Months),
    Patients = n()
  )

#histogram with the red line to tell the average age
ggplot(cancer_data, aes(x = Age)) +
  geom_histogram(
    binwidth = 5,
    fill = "#2E86DE",
    color = "white"
  ) +
  geom_vline(
    aes(xintercept = mean(Age)),
    color = "red",
    linewidth = 1
  ) +
  labs(
    title = "Distribution of Patient Age",
    subtitle = "Cancer Patients in India (2022–2025)",
    x = "Patient Age (Years)",
    y = "Number of Patients"
  ) +
  theme_minimal(base_size = 13)

cancer_data$Stage <- as.factor(cancer_data$Stage)

#-------------------------------------------------------
# Simple Linear Regression
# Research Question:
# Does age significantly affect survival months?
#Y=β0+β1X+ε
#-------------------------------------------------------
#test
model1 <- lm(Survival_Months ~ Age, data = cancer_data)
summary(model1)

#testing age and stage
Survival_Months ~ Age + Stage

#Survival Months=β0+β1(Age)+β2(Stage)
cancer_data$Stage <- as.factor(cancer_data$Stage)

str(cancer_data$Stage)

model2 <- lm(Survival_Months ~ Age + Stage,
             data = cancer_data)

summary(model2)
#make sure all variables are factors
cancer_data$Gender <- as.factor(cancer_data$Gender)
cancer_data$Stage <- as.factor(cancer_data$Stage)
cancer_data$Cancer_Type <- as.factor(cancer_data$Cancer_Type)
cancer_data$Treatment_Type <- as.factor(cancer_data$Treatment_Type)

#Survival Months=β0+β1(Age)+β2(Gender)+β3(Stage)+β4(Cancer Type)+β5(Treatment Type)
model3 <- lm(
  Survival_Months ~
    Age +
    Gender +
    Stage +
    Cancer_Type +
    Treatment_Type,
  data = cancer_data
)

summary(model3)

numeric_data <- cancer_data %>%
  select(Age, Survival_Months)

cor(numeric_data)

corrplot(
  cor(numeric_data),
  method = "color",
  type = "upper",
  addCoef.col = "black",
  tl.col = "black",
  number.cex = 1
)

confint(model3)

vif(model3)

par(mfrow = c(2,2))

plot(model3)

numeric_data <- cancer_data %>%
  select(Age, Survival_Months)

cor(numeric_data)

corrplot(
  cor(numeric_data),
  method = "color",
  type = "upper",
  addCoef.col = "black",
  tl.col = "black",
  number.cex = 1
)

confint(model3)

vif(model3)

par(mfrow = c(2,2))
plot(model3)

summary(model1)

summary(model2)

summary(model3)

