library(shiny)

# Basal Metabolic Rate (BMR)
# ==========================
# Adult male: 66.47 + ( 13.75 x weight in kg ) + ( 5.003 x height in cm ) - ( 6.755 x age in years )
# Adult female: 655.1 + ( 9.563 x weight in kg ) + ( 1.850 x height in cm ) - ( 4.676 x age in years )
#
# Ref: Harris JA, Benedict FG. A biometric study of human basal metabolism. Proc Natl Acad Sci USA 1918;4(12):370-3.

bmrCalculate <- function(gender, weightKg, heightCm, ageYears, activityFactor){
  if(gender == "male"){
    bmr <- (66.47 + ( 13.75 * weightKg ) + ( 5.003 * heightCm ) - ( 6.755 * ageYears )) * as.numeric(activityFactor)
  }else{
    bmr <- (655.1 + ( 9.563 * weightKg ) + ( 1.850 * heightCm ) - ( 4.676 * ageYears )) * as.numeric(activityFactor)
  }
  
  bmr <- round(bmr, 0)
  
  bmr
} 

bmrDeficitCalculate <- function(bmr, loseRate){
  bmr - round(7700 * as.numeric(loseRate) / 7, 0)
}

# Body Mass Index (BMI)
# =====================
# ( weight in Kilograms / ( height in Meters x height in Meters ) )

bmiCalculate <- function(weightKg, heightCm){
  heightM <- heightCm / 100
  
  bmi <- weightKg / (heightM * heightM)
  
  bmi <- round(bmi, 0)
  
  bmi
} 

bmiWeightCalculate <- function(bmi, heightCm){
  heightM <- heightCm / 100
  
  weight <- bmi * heightM * heightM
  
  weight <- round(weight, digits = 1)
  
  weight
}

bmiWeightTableCalculate <- function(heightCm){  
  bmiWeightTable <- data.frame(
    "Classification" = c(
      "Under", 
      "Healthy", 
      "Overweight", 
      "Obese", 
      "Severely Obese"
    ),
    "BMI Range" = c(
      "Under 18.5", 
      "18.5 to 24.9", 
      "25 to 29.9", 
      "30 to 39.9", 
      "Over 40"
    ),
    "From kg" = c(
      NA,
      bmiWeightCalculate(18.5, heightCm),
      bmiWeightCalculate(25, heightCm),
      bmiWeightCalculate(30, heightCm),
      bmiWeightCalculate(40, heightCm)
    ),
    "To kg" = c(
      bmiWeightCalculate(18.49, heightCm),
      bmiWeightCalculate(24.99, heightCm),
      bmiWeightCalculate(29.99, heightCm),
      bmiWeightCalculate(39.99, heightCm),
      NA
    ),
    "Description" = c(
      "Underweight and possibly malnourished",
      "Healthy for young and middle-aged adults",
      "Considered overweight",
      "Considered obese, health risks",
      "Considered severly obese, severe health risks"
    )
  );
  
  bmiWeightTable
}

# Maintained Weight Loss Table
# ============================
bmrTimeTableCalculate <- function(gender, weightCurrent, weightGoal, heightCm, ageYears, activityFactor, loseRate){
  week <- 0
  
  weightKg <- weightCurrent
  
  if (weightCurrent < weightGoal)
  {
    weightKg <- weightGoal
  }

  bmr <- bmrCalculate(
    gender, 
    weightKg, 
    heightCm, 
    ageYears, 
    activityFactor)
  bmrDiet <- bmrDeficitCalculate(bmr, loseRate)
  
  if (weightKg <= weightGoal){
    bmrDiet <- NA
  }
  
  colWeek <- c(NA)
  colWeight <- c(weightCurrent)
  colLostKg <- c(NA)
  colBMR <- c(bmr)
  colDiet <- c(bmrDiet)
  
  while(weightKg > weightGoal){
    week <- week + 4
    weightKg <- weightKg - (4 * as.numeric(loseRate))
    
    if (weightKg <= weightGoal){
      weightKg <- weightGoal
    }
    
    bmr <- bmrCalculate(
      gender, 
      weightKg, 
      heightCm, 
      ageYears, 
      activityFactor)
    
    bmrDiet <- bmrDeficitCalculate(bmr, loseRate)
    
    if (weightKg <= weightGoal){
      bmrDiet = NA
    }
    
    colWeek <- c(colWeek, week)
    colWeight <- c(colWeight, weightKg)
    colLostKg <- c(colLostKg, weightCurrent - weightKg)
    colBMR <- c(colBMR, bmr)
    colDiet <- c(colDiet, bmrDiet)
  }
  
  bmrTimeTableCalculate <- data.frame(
    "Week" = colWeek,
    "Weight" = colWeight,
    "Lost kg" = colLostKg,
    "BMR" = colBMR,
    "Calorie per day Diet" = colDiet
  )
  
  bmrTimeTableCalculate
}

shinyServer(
  function(input, output) {

    output$bmiWeightTable <- renderTable(
      {
        bmiWeightTableCalculate(input$heightCm)
      },
      include.rownames=FALSE
    )
    
    output$bmrTimeTableCalculate <- renderTable(
      {
        bmrTimeTableCalculate(
          input$gender, 
          input$weightCurrent, 
          input$weightGoal, 
          input$heightCm, 
          input$ageYears, 
          input$activityFactor, 
          input$loseRate)
      },
      include.rownames=FALSE
    )

    output$bmr <- renderText(
      {
        bmrCalculate(
          input$gender, 
          input$weightCurrent, 
          input$heightCm, 
          input$ageYears, 
          input$activityFactor)
      }
    )

    output$heigthText <- renderUI(
      {
        HTML(paste(
          "<h3>",
          "At a height of <b>",
          input$heightCm,
          "</b> cm your BMI is <b>",
          bmiCalculate(input$weightCurrent, input$heightCm),
          "</b>",
          "</h3>"))
      }
    )

    output$bmrText <- renderUI(
      {
        bmr <- bmrCalculate(
          input$gender, 
          input$weightCurrent, 
          input$heightCm, 
          input$ageYears, 
          input$activityFactor)
        
        HTML(paste(
          "Your BMR given your activity level is <b>", 
          bmr, 
          " calories</b> per day. This simply means you have to consume <b>", 
          bmr, 
          " calories</b> per day to maintain your current weight at your current level of activity."))
      }
    )

    output$calorieDeficitText <- renderUI(
      {
        bmr <- bmrCalculate(
          input$gender, 
          input$weightCurrent, 
          input$heightCm, 
          input$ageYears, 
          input$activityFactor)
        
        HTML(paste(
          "<p>It takes a 7,700 calorie deficit to eliminate 1 kilogram of 
            body fat (<a href=\"http://www.livestrong.com/article/310149-how-many-calories-should-be-burned-to-lose-1-kilogram-of-weight/\">livestrong.com</a>
            , 2013). For you to lose <b>", 
          input$loseRate, 
          " kg</b> per week you need to create a ", 
          round(7700 * as.numeric(input$loseRate), 0), 
          " calorie deficit per week which in turn is a <b>", 
          round(7700 * as.numeric(input$loseRate) / 7, 0), 
          " calorie deficit per day.</b> Given your BMR of ", 
          bmr, 
          " calories per day that means a initial <b>",
          bmrDeficitCalculate(bmr, input$loseRate),
          " calories per day</b> diet will be enough to start you on your journey."
          )
        )
      }
    )
  }
)