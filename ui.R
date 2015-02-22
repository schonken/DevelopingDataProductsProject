library(shiny)
shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Basal Metabolic Rate (BMR) inspired Calorie Planner"),

    # Side Panel
    sidebarPanel(
      p("This Calorie Planner tries to help clarify some of the mystery around BMI, BMR, Calorie Deficits and continued weight loss."),
      p("The report will update in real-time as you answer the following questions. Enjoy!"),
      
      numericInput('weightCurrent', 'Current Weight in kilograms (kg)', 90, min = 40, max = 500, step = 1),
      tags$div(
        HTML("<p>Convert pound to kg <a href=\"http://manuelsweb.com/kg_lbs.htm\" target=\"_blank\">here</a>.</p>")
      ),
      
      numericInput('heightCm', 'Height in centimeters (cm)', 175, min = 40, max = 250, step = 1),
      
      tags$div(
        HTML("<p>Convert feet to centimeters (cm) <a href=\"http://www.manuelsweb.com/ft_in_cm.htm\" target=\"_blank\">here</a>.</p>")
      ),
      
      numericInput('ageYears', 'Age in Years', 30, min = 18, max = 85, step = 1),
      radioButtons("gender", "Gender",
                   c("Male (boy)" = "male",
                     "Female (girl)" = "female")),

      selectInput("activityFactor", "How active are you? Be honest :)",
                   c("Sedentary: Little to no exercise" = "1.2",
                     "Mild: Intensive exercise for at least 20 minutes 1 to 3 times per week" = "1.3375", # 1.3 - 1.375
                     "Moderate: Intensive exercise for at least 30 to 60 minutes 3 to 4 times per week" = "1.525", # 1.5 - 1.55
                     "Heavy: Intensive exercise for 60 minutes or greater 5 to 7 days per week" = "1.7",
                     "Extreme: Training schedule with multiple training sessions throughout the day" = "1.9")),
      
      h4("Your weight loss goals"),
      
      numericInput('weightGoal', 'Goal Weight in kilograms (kg)', 80, min = 40, max = 500, step = 1),
      tags$div(
        HTML("<p>Convert pound to kg <a href=\"http://manuelsweb.com/kg_lbs.htm\" target=\"_blank\">here</a>.</p>")
      ),
      
      selectInput("loseRate", "I would like to lose",
                   c("0.25 kg per week" = "0.25",
                     "0.5 kg per week" = "0.5",
                     "0.75 kg per week" = "0.75",
                     "1.0 kg per week" = "1.0"),
                  "0.25")
    ),
    
    # Main Panel
    mainPanel(
      htmlOutput("heigthText"),
      tags$div(
        HTML("<p><i>\"A large body of research supports the idea that people with higher BMIs are more prone 
             to a number of health-related complications. A review article published in the Lancet (a very 
             highly respected medical journal) showed a significant increase in cancer with a 5 kg/m<sup>2</sup> 
             increase in BMI.\"</i> (<a href=\"http://www.builtlean.com/2013/07/17/bmi-chart/\">builtlean.com</a>, 2013)</p>")
      ),
      
      tableOutput("bmiWeightTable"),
      
      h3("Basal Metabolic Rate (BMR)"),
      
      tags$div(
        HTML("<p><i>\"Basal metabolic rate (BMR) is the amount of energy required to maintain the body's normal 
             metabolic activity, such as respiration, maintenance of body temperature (thermogenesis), and 
             digestion.\"</i> (<a href=\"http://www.globalrph.com/harris-benedict-equation.htm\">globalrph.com</a>, 2015)</p>")
      ),
      
      htmlOutput("bmrText"),
      
      h3("Creating your Calorie Deficit"),
      
#       tags$div(
#         HTML("<p>According to LIVESTRONG.COM it would take a 7,700 calorie deficit to eliminate 1 kilogram of 
#             body fat (<a href=\"http://www.livestrong.com/article/310149-how-many-calories-should-be-burned-to-lose-1-kilogram-of-weight/\">livestrong.com</a>, 2013).</p>")
#       ),
      
      htmlOutput("calorieDeficitText"),
      
      h3("Maintaining your Calorie Deficit"),
      tags$div(
        HTML("<p>Your Basal Metabolic Rate (BMR) decreases as you lose weight. A common weight loss trap is starting your diet
          at a certain calorie level and keeping it steady. This leads to a decrease in weight loss until
          you completely plateau. The following table suggests month by month adjustments as your weight decreases to
          help you avoid this trap.</p>")
      ),
      
      tableOutput("bmrTimeTableCalculate"),
      
      h3("Keeping track of your new lifestyle"),
      tags$div(
        HTML("<p>Counting calories can become very tedious if not near 
        impossible. <a href=\"http://www.myfitnesspal.com/\">MyFittnessPal.com</a> is a great free tool for doing 
        just that. They even have an iPhone app that will scan the barcode on your food for easy calorie counting.
        <a href=\"http://www.fitocracy.com\">Fitocracy.com</a> is a fitness centered social network that rewards
             you for doing and keeping track of your exercise.</p>")
      ),
      
      h3("Disclaimer"),
      p("The material on this site is provided for informational purposes only and is not medical advice. Always consult
        your physician before beginning any diet or exercise program.")
    )
  )
)