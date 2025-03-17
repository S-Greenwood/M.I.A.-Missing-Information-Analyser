library(shiny)
library(bslib)
library(shinyjs)
library(plotly)
library(palmerpenguins)
library(dplyr)

#### UI code ####
ui <- fluidPage(
  theme = bs_theme(version = 5),
  useShinyjs(),
  title = "Rethinking missing data with patients",
  
  
 div(
    style="display:none;",
    textInput("page", "", value = "1"),
  ),
  
  
  #### Header ####
  div(
    hr(),
    h1("Rethinking missing data with patients"),
    hr(),
  ),
  
  # Text on each page
  
  # Page 1 - text ####
  
  conditionalPanel(
    condition = "input.page == 1",
    p("Introduction", style = "font-size: 24px; font-weight: bold;"),
    p("Clinical trials are important studies that gather evidence about 
    healthcare interventions. This evidence is then used to decide which 
    healthcare options are available to everyone in the future. Most of these 
    clinical trials will have missing measurements from patients. 
    Researchers are asking patients to help them decide what to do about
    these missing measurements. This is where you come in!"),
    strong("Objective of this step: "),
    p("As a patient, we want to take your judgements/ opinions/ thoughts on what you 
      think the gaps should be for specific clinical trial. This activity should 
      take 30 - 60 minutes."),
    p("Before you start, if you want a refresher on any of these topics see these links below."),
    tags$ul(
      tags$li(
        "A short video introducing missing data: ",
        tags$a(href = "https://www.youtube.com/watch?v=DLBVXCru8cI", "Watch Video")
      ),
      tags$li(
        "A document of frequently asked questions: ",
        tags$a(href = "FAQs.pdf", "View Document", download="FAQS.pdf")
      )
    ),
    p("If you would like to have any support please contact ", tags$a(href = "mailto:s.greenwood.22@abdn.ac.uk?subject=Question%20-%20rethinking%20missing%20data%20with%20patients", "s.greenwood.22@abdn.ac.uk")),
    p("Click next to get started.")
  ),
  
  # Page 2 - text ####
  
  conditionalPanel(
    condition = "input.page == 2",
    p("Background", style = "font-size: 24px; font-weight: bold;"),
    p("Here is some information to give you a bit of context about the clinical 
      trial 'puzzle' we are looking to fill together. Click on each question to 
      see the answer."),
    
    accordion(
    id = "clinical_trial_acc",
    open = NULL,
    multiple = FALSE,  # Close other panels when one is opened
    
    accordion_panel(
      title = "What is the clinical trial?",
      icon = bsicons::bs_icon("question-circle"),
      div("Traditionally, dentists have encouraged both patients at low risk and 
          patients at high risk of developing dental disease to attend their dental 
          practices for regular 6-month ‘check-ups’. There is, however, little 
          evidence available for either patients or dentists to use when deciding 
          on the best dental recall interval (i.e. time between dental check-ups) 
          for maintaining oral health. In this study, we wanted to find out, for 
          adult patients who regularly attend the dentist, what interval of time 
          between dental check-ups maintains optimum oral health and represents 
          value for money")
    ),
    accordion_panel(
      title = "Who are the participants in the trial?",
      icon = bsicons::bs_icon("person-circle"),
      div("A total of 2372 adults aged 18 years and over who regularly attended 
          51 different dental practices across Scotland, Northern Ireland, 
          England and Wales were involved. These patients received all or part 
          of their care as NHS patients.")
    ),
    accordion_panel(
      title = "What was the intervention?",
      icon = bsicons::bs_icon("prescription2"),
      div(
        "The intervention was how often a patient saw their dentist for a check-
        up. This was just a dental check-up and excluded any other treatments 
        like scale and polish. Participants were randomly split into groups with 
        each one assigned the dental check-up time of either:",
        tags$ul(
          tags$li("Every ", strong("2 years "), ", if considered at low risk by their dentist"),
          tags$li("Every ", strong("6 months")),
          tags$li("Or ", strong("risk-based"), "which they said was ", em("'an individualised, recall interval based on the patient's risk of dental disease.'"))
        ),
        p(""),
        p(strong("Note:"), "In this exercise we are going to focus on just those 
          assigned to 6-month and risk-based recall, who were typically older 
          with worse scores."),
      ),
    ),
    accordion_panel(
        title = "What are the missing measurements we are interested in today?",
        icon = bsicons::bs_icon("puzzle"),
        div(
            p("Many measurements were taken from participants in this clinical 
              trial. This exercise focuses on just one, which was asking them 
              about a specific symptom over the last 12 months."),
          tags$ul(
            tags$li(strong("Question:"), "Have you had painful aching in your mouth?"),
            tags$li(strong("Answer:"), "the patient answered by selecting a number from below"),
          ),
          tags$table(
            class = "table table-bordered table-striped",
            tags$thead(
              tags$tr(
                tags$th("0"),
                tags$th("1"),
                tags$th("2"),
                tags$th("3"),
                tags$th("4")
              )
            ),
            tags$tbody(
              tags$tr(
                tags$td("never"),
                tags$td("hardly ever"),
                tags$td("occasionally"),
                tags$td("fairly often"),
                tags$td("very often")
              )
            )
          ),
          "This question was asked in a questionnaire, which patients completed 
          once a year. ",
          "It was completed at home and returned to the researchers using a pre-
          paid envelope. They did this every year for 4 years.",
          p(""),
          p(strong("Note:"), "we are going to focus on the missing answers to 
            this question just at Year 4"),
        )
    ),
    accordion_panel(
        title = "How many pieces were missing?",
        icon = bsicons::bs_icon("search"),
        div(
          p(strong("How many were missing?"), "There were 438 patients missing a
            n answer to this question. Split into the two groups it looked like this."),
          tags$table(
            class = "table table-bordered table-striped",
            tags$thead(
              tags$tr(
                tags$th("Number of patients"),
                tags$th("6-months"),
                tags$th("Risk-based recall"),
                tags$th("Total")
              )
            ),
            tags$tbody(
              tags$tr(
                tags$td("In each group"),
                tags$td("863 (100%)"),
                tags$td("861 (100%)"),
                tags$td("1724")
              ),
              tags$tr(
                tags$td("Missing an answer"),
                tags$td("217 (25.1%)"),
                tags$td("221 (27.0%)"),
                tags$td("438")
              )
            )
          )
        )
    ),
    accordion_panel(
        title = "Who are the participants with missing measurements?",
        icon = bsicons::bs_icon("person-vcard"),
        div(
          p("Limited information is available about the patient who did not 
            answer that question. We can only search for clues. This is why we 
            are doing this exercise!"),
          
        )
    ),
    accordion_panel(
      title="What do we need to 'fill the gaps'?",
      icon = bsicons::bs_icon("question-circle"),
      div(
        p("We want to get a general sense of how they could have answered that 
          question 4 years after they started the study. To get that overall 
          picture we will focus on estimating the 'average'. This value can be 
          anything between 0 to 4 and represents the typical response from this 
          group")
      )
    ),
    accordion_panel(
      title = "What if I am not sure?",
      icon = bsicons::bs_icon("person-raised-hand"),
      div(
        p(strong("Remember:"), "If you're not feeling sure this that is a good 
          thing! Counter to what you might think, we want to capture 
          that",em("uncertainty"),"in your judgements. Your judgement is not 
          being used to accurately represent one patient's medical condition, 
          it is about getting a general sense about all of those patients with 
          missing measurements, and what their results might have been.")
      )
    ),
    accordion_panel(
      title = "Next step",
      icon = bsicons::bs_icon("arrow-right-square"),
      div(
        p("We are going to look at one group at a time."),
        tags$ul(
          tags$li("First, the 217 patients in the 6 month group"),
          tags$li("Second, the 221 patients in the risk-recall group"),
          tags$li("Then, you will download your responses, email them and you're done!"),
        ),
      )
    ),
    div( hr()),
  )
  ),
  
  
  # Page 3 - text ####
  
  
  conditionalPanel(
    condition = "input.page == 3",
    p("Group 1: 6-month recall", style = "font-size: 24px; font-weight: bold;"),
    #p("We are first going to focus on the 861 participants who were going back to see the dentist every 6-months. We want to estimate the responses of those 237 (27.5%) whose responses were missing."),
    accordion(
      id = "q1-accordion",
      open = NULL,
      multiple = FALSE,
      accordion_panel(
        title = "How many patients were missing their measurement?",
        icon = bsicons::bs_icon("search"),
        p("Of the 863 patients in Group 1 (6-months), 217 (25.1%) missed a 
          response to this question at year 4."),
        tags$table(
          class = "table table-bordered table-striped",
          tags$thead(
            tags$tr(
              tags$th("Number of patients"),
              tags$th("6-months")
            )
          ),
          tags$tbody(
            tags$tr(
              tags$td("Total number in group"),
              tags$td("863 (100%)")
            ),
            tags$tr(
              tags$td("Missing an answer"),
              tags$td("217 (25.1%)")
            )
          )
        )
      ),
      accordion_panel(
        title="What is the profile of these patients?",
        icon = bsicons::bs_icon("person-circle"),
        p("Here is a table showing some background information about the patients with 
          missing data, compared to those without missing data."),
        div(
          p("Summary of what the tables shows:"),
          tags$ul(
            tags$li("..."),
            tags$li("..."),
            tags$li("..."),
          ),
        ),
        
        tags$table(
          class = "table table-bordered table-striped",
          tags$thead(
            tags$tr(
              tags$th(""),
              tags$th("Patients with a missing answer?"),
              tags$th("Patients with no missing answer?"),
              tags$th("Total - Table 6 - data")
            )
          ),
          tags$tbody(
            tags$tr(
              tags$td("How many patients? (%)"),
              tags$td("217 (25.14%)"),
              tags$td("646 (74.86%)"),
              tags$td("863 (100%)")
            ),
            tags$tr(
              tags$td("Did they complete this questionnaire at the start?"),
              tags$td("187 (21.67%)"),
              tags$td("616 (71.38%)"),
              tags$td("803 (93.05%)")
            ),
            tags$tr(
              tags$td("Mean Age (years)"),
              tags$td("45.1"),
              tags$td("51.7"),
              tags$td("48.4")
            ),
            tags$tr(
              tags$td("Gender")
            ),
            tags$tr(
              tags$td(
                tags$ul(
                  tags$li("Male")
                )
              ),
              tags$td("95 (11.01%)"),
              tags$td("271 (31.4%)"),
              tags$td("366 (42.41%)")
            ),
            tags$tr(
              tags$td(
                tags$ul(
                  tags$li("Female")
                )
              ),
              tags$td("116 (13.44%)"),
              tags$td("375 (43.45%)"),
              tags$td("491 (56.89%)")
            ),
            tags$tr(
              tags$td("Smoked in last 12 months"),
              tags$td("48 (5.56%)"),
              tags$td("82 (9.5%)"),
              tags$td("130 (15.06%)")
            ),
            tags$tr(
              tags$td("What care do they normally have?"),
            ),
            tags$tr(
              tags$td(
                tags$ul(
                  tags$li("NHS")
                )
              ),
              tags$td("148 (17.15%)"),
              tags$td("529 (61.3%)"),
              tags$td("677 (78.45%)")
            ),
            tags$tr(
              tags$td(
                tags$ul(
                  tags$li("Private")
                )
              ),
              tags$td("10 (1.16%)"),
              tags$td("22 (2.55%)"),
              tags$td("32 (3.71%)")
            ),
            tags$tr(
              tags$td(
                tags$ul(
                  tags$li("Combination")
                )
              ),
              tags$td("18 (2.09%)"),
              tags$td("38 (4.4%)"),
              tags$td("56 (6.49%)")
            ),
            tags$tr(
              tags$td("Type of toothbrush"),
            ),
            tags$tr(
              tags$td(
                tags$ul(
                  tags$li("Manual")
                )
              ),
              tags$td("115 (13.33%)"),
              tags$td("381 (44.15%)"),
              tags$td("496 (57.47%)")
            ),
            tags$tr(
              tags$td(
                tags$ul(
                  tags$li("Electric")
                )
              ),
              tags$td("67 (7.76%)"),
              tags$td("231 (26.77%)"),
              tags$td("298 (34.53%)")
            ),
            
          ),
        )
      ),
      accordion_panel(
        title = "What were they missing?",
        icon = bsicons::bs_icon("lightbulb"),
        p("These participants did not answer this question at Year 4:"),
        tags$ul(
          tags$li(strong("Question: "), "Have you had painful aching in your mouth?"),
          tags$li(strong("Answer: "), "picking a number from below"),
        ),
        tags$table(
            class = "table table-bordered table-striped",
            tags$thead(
              tags$tr(
                tags$th("0"),
                tags$th("1"),
                tags$th("2"),
                tags$th("3"),
                tags$th("4")
              )
            ),
            tags$tbody(
              tags$tr(
                tags$td("never"),
                tags$td("hardly ever"),
                tags$td("occasionally"),
                tags$td("fairly often"),
                tags$td("very often")
              )
            )
          ),
      )
    ),
    br(),
    p("Activity: 'Fill in the gaps'", style = "font-size: 18px; font-weight: bold;"),
    
    p("Now we are going to estimate the 217 patients whose responses were missing.
      We want to get a general sense of how they could have answered that question, 
      on average, 4 years into the trial."),
   p("This activity will be completed in ", strong("3 steps"),". Be sure to 
   complete each one before clicking 'Next'"),
   
#### Page 3 - tabs ####

   navset_card_tab(
      id = "nav_tab_top_1",
      nav_panel("Step 1", 
          p("Remember the question was 'Have you had painful aching in your 
            mouth?', and the scale was"),
          tags$table(
                  class = "table table-bordered table-striped",
                  style = "background-color: #f8f9fa; color: #333;",  # Light gray background, dark text
                  tags$thead(
                    tags$tr(
                      tags$th("0"),
                      tags$th("1"),
                      tags$th("2"),
                      tags$th("3"),
                      tags$th("4")
                    )
                  ),
                  tags$tbody(
                    tags$tr(
                      tags$td(style = "background-color: #ccffff;", "never"),
                      tags$td(style = "background-color: #ccffcc;", "hardly ever"),
                      tags$td(style = "background-color: #ffffcc;", "occasionally"),
                      tags$td(style = "background-color: #ffebcc;", "fairly often"),
                      tags$td(style = "background-color: #ffcccc;", "very often")
                    )
                  )
           ),
         div(
           div(strong("Question 1a: "), p("Thinking about the overall average 
                                         response from these participants, based 
                                         on your judgement. What is the LOWEST 
                                         possible value the average could be? 
                                         (L = lower plausible limit)")),
          sliderInput("question1aSlider", label = NULL, min = 0, max = 4, value = 0, step = 0.1),
          uiOutput("question1aValue") # Display the selected value
        ),

        div(
          div(strong("Question 1b: "), p("Thinking about the overall average 
                                         response from these participants, 
                                         based on your judgement. What is the 
                                         HIGHEST possible value the average 
                                         could be? (U = upper plausible limit)")),
          sliderInput("question1bSlider", label = NULL, min = 0, max = 4, value = 4, step = 0.1),
          uiOutput("question1bValue"), # Display the selected value
          p(""),
          uiOutput("reflection1ab"), # Display the reflection with values
          p(""),
          
        ),
        div(
          div(strong("Question 1c:"), p("Now we have your highest and lowest 
                                        value, we now need to split that bar in 
                                        two! At which value on this scale do you 
                                        think that the average of the group is 
                                        equally likely to be above and below 
                                        that value?")),
          #uiOutput("question1cRange"), # Show current range from 1a and 1b
          sliderInput("question1cSlider", label = NULL, min = 0, max = 4, value = 2, step = 0.1),
          uiOutput("question1cValue"), # Display the selected value
          p(""),
          div(
            strong("Tips for Question 1c:"),
            tags$ul(
              tags$li("Note that your answer doesn't have to sit in the middle! 
              A value closer to right this means you think that then average of 
              these 217 participants are likely to be is likely to be a higher 
              score, which is a worse outcome"),
              tags$li("When you have an answer have a think. Imagine you're in a 
              game show and there is big prize for getting this question right. 
              Do you think the average of the group of 217 patients is more 
              likely to be in above or below that middle value? If you think yes
              , then return to Q1c and consider increasing or reducing your 
              value until you don't have a preference for above or below. If you 
              answered no, continue onto Step 2, by clicking above")
            )
          )
        )
      ),
      nav_panel("Step 2", 
          p("Remember the question was 'Have you had painful aching in your 
            mouth?', and the scale was"),
                tags$table(
                  class = "table table-bordered table-striped",
                  style = "background-color: #f8f9fa; color: #333;",  # Light gray background, dark text
                  tags$thead(
                    tags$tr(
                      tags$th("0"),
                      tags$th("1"),
                      tags$th("2"),
                      tags$th("3"),
                      tags$th("4")
                    )
                  ),
                  tags$tbody(
                    tags$tr(
                      tags$td(style = "background-color: #ccffff;", "never"),
                      tags$td(style = "background-color: #ccffcc;", "hardly ever"),
                      tags$td(style = "background-color: #ffffcc;", "occasionally"),
                      tags$td(style = "background-color: #ffebcc;", "fairly often"),
                      tags$td(style = "background-color: #ffcccc;", "very often")
                    )
                  )
        ),
        div(
          p("We're now going to split our group of 217 participant in half. One half have better (lower) scores, and the other have worse (higher) scores for the 6-months group."),
          div(strong("Question 1d:"), "For the half of the 217 participant with lower (better) scores move the scale to draw a line on the left where you think it is equally likely that the average is above and below that value? (remember it doesn't need to be in the middle!)"),
          uiOutput("question1dRange"), # Show current range from 1a and 1c
          sliderInput("question1dSlider", label = NULL, min = 0, max = 4, value = 1, step = 0.1),
          uiOutput("question1dValue") # Display the selected value
        ),
        div(
          div(strong("Question 1e:"), "For the half of the 217 participant with higher (worse) scores move the scale to draw a line on the left where you think it is equally likely that the average is above and below that value? (remember it doesn't need to be in the middle!)"),
          uiOutput("question1eRange"), # Show current range from 1c and 1b
          sliderInput("question1eSlider", label = NULL, min = 0, max = 4, value = 3, step = 0.1),
          uiOutput("question1eValue"), # Display the selected value
          div(strong("Reflection:"), "You have given your judgement about the average missing score for those 217 participants through 5 numbers. We now have a plot that is split into four segments, where it is equally likely that the average value of those 217 participants could be in each segment. It's normal for them not to be equally sized, often the middle two segments are much smaller!")
        ),
        
        div(
          div(strong("Question 1f:"), "Do you have any reasons, or rationale you want to write about your judgement above?"),
          uiOutput("question1fSummary"), # Show summary of previous answers
          br(),
          br(),
          br(),
          textAreaInput("question1fTextArea", label = NULL, placeholder = "Write your reasons here"),
          p("Remember, we want to capture that uncertainty in your judgements, and we are asking your judgement to get a general sense about those patients with missing measurements, and what their results might have been. So we have one last reflection to help you with your response.")
        )
      ),
      nav_panel("Step 3", 
        div(
          div(strong("Question 1g:"), "Lastly, lets now compare your judgements on the average of the 217 participants who did not answer against the average of the 624 participants who did answer the question."),
          tags$table(
            class = "table table-bordered table-striped",
            tags$thead(
              tags$tr(
                tags$th("Returned the questionnaire at Year 4?"),
                tags$th("")
              )
            ),
            tags$tbody(
              tags$tr(
                tags$td("No (your judgement on the 217 participants)"),
                tags$td(
                  uiOutput("question1gNoValue"), # Display value from 1c
                  sliderInput("question1gNoSlider", label = NULL, min = 0, max = 4, value = 2, step = 0.1)
                )
              ),
              tags$tr(
                tags$td("Yes (the results of the 624 who did answer the question)"),
                tags$td(
                  sliderInput("question1gYesSlider", label = NULL, min = 0, max = 4, value = 1.5, step = 0.1, animate = FALSE)
                )
              ),
              tags$tr(
                tags$td("What does this mean?"),
                tags$td(uiOutput("comparison1g"))
              )
            )
          ),
          p("If you're not happy with your response, go back to Q1c and take
            another look at your answer!")
        )
      )
    ),
    
    navset_card_tab(
      id = "nav_tab_bottom_1",
      nav_panel("Step 1", ""),
      nav_panel("Step 2", ""),
      nav_panel("Step 3", ""),
    )

  ),
  


 
 
  # Page 5 - text ####
 
  conditionalPanel(
    condition = "input.page == 4",
    p("Send your results", style = "font-size: 24px; font-weight: bold;"),
    p("That is the end of this exercise! If you've not done so yet, please 
    download your results. Then please send this downloaded file to ", 
      tags$a(href = "mailto:s.greenwood.22@abdn.ac.uk?subje
             ct=My%20Results%20-%20rethinking%20missing%20data%
             20with%20patients", 
             "s.greenwood.22@abdn.ac.uk")),
        div(downloadButton("export", "Download Results")),
    hr(),
    
    strong("What happens now?"),
    p("Other patients are completing the same exercise. They will be sending
      their judgements to the research team, who will combine them to discuss 
      in the consensus meeting"),
    tags$figure(
      class="centerFigure",
      tags$img(
        src="datagoing.png",
        width=400,
        alt="Example image"
      ),
    ),
        hr(),
    strong("Additional note:"),
    p("We want to thank all the patient and public involvement contributors who 
      helped create this website, as well as the Alan Fleming for his 
      programming help!"),
    p("If you want to find out more about the research consider"),
    tags$ul(
      tags$li("Website of the research page",tags$a(href = "https://www.abdn.ac.uk/ace/what-we-do/research/projects-a-z/rethinking-missing-data-with-patients-365", "here" )),
      tags$li("Contact Beatriz Goulao via:", 
                tags$a(href = "mailto:beatriz.goulao@abdn.ac.uk?subject=
                Question%20-%20rethinking%20missing%20data%
                20with%20patients", "email")),
    ),
    strong("Funding:"),
    p("This website was created using funding from the Medical Research 
      Council's (MRC) Trials Methodology Research Partnership (TMRP) 
      Doctoral Training Partnership (DTP), grant number MR/W006049/1."),
    strong("References:"),
    p("we'd like to note a series of resources that were fundamental in the 
    creation of this tool. "),
    tags$ul(
      tags$li("SHELF", em("add reference details")),
      tags$li("Mason et al. paper", em("add reference details")),
    ),
  ),
  
  #### Footer ####
  
  div(
    style="display: flex; justify-content: space-between;",
    conditionalPanel(
      condition = "input.page == 1",
      p(),
    ),
    conditionalPanel(
      condition = "input.page > 1",
      actionButton("prevBtn", "Previous", style = "background-color: #1d4675; 
                   color: white; font-size: 18px; padding: 10px 20px; 
                   border-radius: 5px;"),
    ),
    conditionalPanel(
      condition = "input.page < 4",
      actionButton("nextBtn", "Next", style = "background-color: #1d4675; 
                   color: white; font-size: 18px; padding: 10px 20px; 
                   border-radius: 5px;"),
    ),
  ),
  
  
  hr(),
  p("MIA Tool (Missing Information Analyser)", style = "font-style: italic; color: grey"),
  
  
  
  
  #### Formatting #####
  
  # Force the panels to be collapsed
  tags$script(HTML("
        document.addEventListener('DOMContentLoaded', function() {
          document.querySelectorAll('.accordion-button').forEach(function(button) {
            button.classList.add('collapsed'); // Ensure all buttons start collapsed
          });
          document.querySelectorAll('.accordion-collapse').forEach(function(panel) {
            panel.classList.remove('show'); // Ensure all panels are collapsed
          });
        });
      ")
  ),


  # HTML code to style the accordion bars
  tags$head(
    tags$style(HTML("
      .accordion-button {
        background-color: #1d4675 !important;  /* dark blue for all panels */
        color: white !important; 
        
      }
      
      .accordion-item {
        border: 2px solid #4CAF50 !important; /* green border */
      }
      
      .accordion-button:not(.collapsed) {
        background-color: #388E3C !important; /* green for open panel */
        color: white !important;
      }
    "))
  ),
  
  # HTML code to style the navigation bars 
  tags$head(
    tags$style(HTML("
      .nav-link {
        background-color: #1d4675 !important; /* dark blue for tab header*/
        color: white !important; 
        font-weight: bold;
        border-radius: 5px;
        margin: 2px;
      }

      .nav-link.active {
        background-color: #4CAF50 !important; /* green for open tab */
        color: white !important;
        font-weight: bold;
      }

      .card {
        border: 2px solid #1d4675 !important; /* border around the card */
      }
    "))
  ),
  
  
  
  # HTML code for coloured graphic
  
  tags$style(HTML("
  #question1fSummary .irs {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
  }

  #question1fSummary .irs-line {
    background-color: transparent; /* Make the unfilled part transparent */
  }

   .redbar .irs-bar {
    background-color: red; 
          height: 3px;
  }

  .bluebar .irs-bar {
    background-color: blue;
          height: 3px;
  }

  .greenbar .irs-bar {
    background-color: green;
          height: 3px;
  }

  .orangebar .irs-bar {
    background-color: orange;
          height: 3px;
  }

  .purplebar .irs-bar {
    background-color: purple;
          height: 3px;
  }

  .pinkbar .irs-bar {
    background-color: pink; 
      height: 3px;
  }

  .pinkbar .irs-line {
    background-color: red !important;
    height: 3px;
  }

  #question1fSummary .irs-handle {
    width: 16px;
    height: 16px;
    border-radius: 50%;
    background-color: red; /* Match the handle color to the filled part */
    top: -4px;
  }

  #question1fSummary .irs-handle.state_pressed,
  #question1fSummary .irs-handle:hover {
    background-color: darkred; /* Darken the handle color on hover/press */
  }

  #question1fSummary .irs-min,
  #question1fSummary .irs-max {
    display: none;
  }

  #question1fSummary .irs-from,
  #question1fSummary .irs-to,
  #question1fSummary .irs-single {
    display: none;
  }
  ")),
  
  
  # Slider formatting
  # 
  # tags$script(HTML("
  #   document.addEventListener('DOMContentLoaded', function() {
  #     const updateSliderRelationships = function() {
  #       const sliders = {
  #         a: $('#question1aSlider'),
  #         b: $('#question1bSlider'),
  #         c: $('#question1cSlider'),
  #         d: $('#question1dSlider'),
  #         e: $('#question1eSlider'),
  #         gNo: $('#question1gNoSlider'),
  #         gYes: $('#question1gYesSlider')
  #       };
  #       
  #       $(document).on('change', '.js-range-slider', function(e) {
  #         const sliderId = $(this).attr('id');
  #         
  #         if (sliderId === 'question1aSlider') {
  #           if (parseFloat(sliders.a.val()) >= parseFloat(sliders.c.val())) {
  #             sliders.c.data('ionRangeSlider').update({ from: parseFloat(sliders.a.val()) + 0.1 });
  #           }
  #           if (parseFloat(sliders.c.val()) >= parseFloat(sliders.b.val())) {
  #             sliders.b.data('ionRangeSlider').update({ from: parseFloat(sliders.c.val()) + 0.1 });
  #           }
  #           
  #           if (parseFloat(sliders.a.val()) > parseFloat(sliders.d.val())) {
  #             sliders.d.data('ionRangeSlider').update({ from: parseFloat(sliders.a.val()) });
  #           }
  #           
  #           sliders.gNo.data('ionRangeSlider').update({ from: parseFloat(sliders.c.val()) });
  #         }
  #         else if (sliderId === 'question1bSlider') {
  #           if (parseFloat(sliders.b.val()) <= parseFloat(sliders.c.val())) {
  #             sliders.c.data('ionRangeSlider').update({ from: parseFloat(sliders.b.val()) - 0.1 });
  #           }
  #           if (parseFloat(sliders.c.val()) <= parseFloat(sliders.a.val())) {
  #             sliders.a.data('ionRangeSlider').update({ from: parseFloat(sliders.c.val()) - 0.1 });
  #           }
  #           
  #           if (parseFloat(sliders.b.val()) < parseFloat(sliders.e.val())) {
  #             sliders.e.data('ionRangeSlider').update({ from: parseFloat(sliders.b.val()) });
  #           }
  #         }
  #         else if (sliderId === 'question1cSlider') {
  #           if (parseFloat(sliders.c.val()) <= parseFloat(sliders.a.val())) {
  #             sliders.a.data('ionRangeSlider').update({ from: parseFloat(sliders.c.val()) - 0.1 });
  #           }
  #           if (parseFloat(sliders.c.val()) >= parseFloat(sliders.b.val())) {
  #             sliders.b.data('ionRangeSlider').update({ from: parseFloat(sliders.c.val()) + 0.1 });
  #           }
  #           
  #           sliders.gNo.data('ionRangeSlider').update({ from: parseFloat(sliders.c.val()) });
  #         }
  #         else if (sliderId === 'question1dSlider') {
  #           if (parseFloat(sliders.d.val()) < parseFloat(sliders.a.val())) {
  #             sliders.d.data('ionRangeSlider').update({ from: parseFloat(sliders.a.val()) });
  #           }
  #           if (parseFloat(sliders.d.val()) > parseFloat(sliders.c.val())) {
  #             sliders.d.data('ionRangeSlider').update({ from: parseFloat(sliders.c.val()) });
  #           }
  #         }
  #         else if (sliderId === 'question1eSlider') {
  #           if (parseFloat(sliders.e.val()) < parseFloat(sliders.c.val())) {
  #             sliders.e.data('ionRangeSlider').update({ from: parseFloat(sliders.c.val()) });
  #           }
  #           if (parseFloat(sliders.e.val()) > parseFloat(sliders.b.val())) {
  #             sliders.e.data('ionRangeSlider').update({ from: parseFloat(sliders.b.val()) });
  #           }
  #         }
  #       });
  #     };
  #     
  #     updateSliderRelationships();
  #   });
  # ")),
  
  
)


#### Server code ####

server <- function(input, output, session) {
  page <- reactiveVal(1)
  total_pages <- 5
  
  #### Server - Question text updates with values ####
  responses <- reactiveValues(
    q1a = 0,
    q1b = 4,
    q1c = 2,
    q1d = 1,
    q1e = 3,
    q1f = "",
    q1gNo = 2,
    q1gYes = 1.5,
    comparison = "similar to"
  )
  
  # Update reactive values whenever sliders change
  observe({
    responses$q1a <- input$question1aSlider
    responses$q1b <- input$question1bSlider
    responses$q1c <- input$question1cSlider
    responses$q1d <- input$question1dSlider
    responses$q1e <- input$question1eSlider
    responses$q1f <- input$question1fTextArea
    responses$q1gNo <- input$question1gNoSlider
    responses$q1gYes <- input$question1gYesSlider
  })
  
  observe({
    updateTextInput(session, "page", value = page())
  })
  
  output$question1aValue <- renderUI({
    p(strong("Your answer: ", responses$q1a))
  })
  
  output$question1bValue <- renderUI({
    p(strong("Your answer: ", responses$q1b))
  })
  
  output$reflection1ab <- renderUI({
    p("Based on the answer you've given, you think that the average participant 
      response to the questionnaire ranged from", strong(responses$q1a), " and ", 
      strong(responses$q1b), ". If this is not what you think go back to edit 
      your answer to Q1a and Q1b."
      )
    # HTML(paste0("<strong>", responses$q1a, "</strong> (L) and <strong>", responses$q1b, "</strong> (U). If this is not what you think go back to edit your answer to Q1a and Q1b. After thinking about the extreme cases, we now have a scale of all the possible values that this average could be."))
  })
  
  output$question1cRange <- renderUI({
    p("Based on your previous answers, you've indicated the range is between ", 
      strong(responses$q1a), " and ", strong(responses$q1b), ".")
  })
  
  output$question1cValue <- renderUI({
    p(strong("Your answer: ", responses$q1c))
  })
  
  output$question1dRange <- renderUI({
    p("Based on your previous answers, this value should be between ", 
      strong(responses$q1a), " and ", strong(responses$q1c), ".")
  })
  
  output$question1dValue <- renderUI({
    p(strong("Your answer: ", responses$q1d))
  })
  
  output$question1eRange <- renderUI({
    p("Based on your previous answers, this value should be between ", 
      strong(responses$q1c), " and ", strong(responses$q1b), ".")
  })
  
  output$question1eValue <- renderUI({
    p(strong("Your answer: ", responses$q1e))
  })
  #### Server - Q1f summary ####
  output$question1fSummary <- renderUI({
    div(
      p("Your judgments so far:"),
      tags$ul(
        tags$li("Lowest possible average: ", strong(responses$q1a)),
        tags$li("Highest possible average: ", strong(responses$q1b)),
        tags$li("Median value (equally likely to be above/below): ", strong(responses$q1c)),
        tags$li("Lower half median: ", strong(responses$q1d)),
        tags$li("Upper half median: ", strong(responses$q1e))
      ),
      
      div(
        style = "position: relative; left: -50px; height: 120px; margin-top: 30px;",

         # Horizontal graph with distribution
         plotlyOutput("HorizontalDistr")
      
      ),
      
      div(
        style = "margin-top: 50px;",
        p("Legend:"),
        tags$ul(
          tags$li(tags$span("L", style = "color: blue; font-weight: bold;"), " - Lowest possible average (", strong(responses$q1a), ")"),
          tags$li(tags$span("Q1", style = "color: green; font-weight: bold;"), " - Lower quartile (", strong(responses$q1d), ")"),
          tags$li(tags$span("M", style = "color: red; font-weight: bold;"), " - Median value (", strong(responses$q1c), ")"),
          tags$li(tags$span("Q3", style = "color: green; font-weight: bold;"), " - Upper quartile (", strong(responses$q1e), ")"),
          tags$li(tags$span("U", style = "color: blue; font-weight: bold;"), " - Highest possible average (", strong(responses$q1b), ")")
        )
      )
    )
  })
  
  output$question1gNoValue <- renderUI({
    p("Based on your previous answer to Q1c: ", strong(responses$q1c))
  })
  
  output$comparison1g <- renderUI({
    comparison <- ifelse(responses$q1gNo > responses$q1gYes + 0.2, "worse than",
                 ifelse(responses$q1gNo < responses$q1gYes - 0.2, "better than", "similar to"))
    
    responses$comparison <- comparison
    
    HTML(paste0("When we compare this against your judgements, this means that they did <strong>", 
                comparison, 
                "</strong> the participants who did not return their questionnaire. (Based on the median value)"))
  })
  
  #### Server - slider code 1 ####
  
  # Observe changes in slider1a or slider1b and update slider1c (Median slider based on Min and Max)
  observe(
    updateSliderInput(session, "question1cSlider",
                      min = responses$q1a,
                      max = responses$q1b,
                      value = (responses$q1a + responses$q1b)/2 # Keep value in range
    )
  )
  
  # Observe changes in slider1a or slider1c and update slider1d (Q1 slider based on Min and Median)
  observe(
    updateSliderInput(session, "question1dSlider",
                      min = responses$q1a,
                      max = responses$q1c,
                      value = (responses$q1a + responses$q1c)/2 # Keep value in range
    )
  )  
  
  # Observe changes in slider1b or slider1c and update slider1d (Q3 slider based on Max and Median)
  observe(
    updateSliderInput(session, "question1eSlider",
                      min = responses$q1c,
                      max = responses$q1b,
                      value = (responses$q1b + responses$q1c)/2 # Keep value in range
    )
  )     
  observe({
    updateSliderInput(session, "q1aVisual", value = responses$q1a)
    updateSliderInput(session, "q1bVisual", value = responses$q1b)
    updateSliderInput(session, "q1cVisual", value = responses$q1c)
    updateSliderInput(session, "q1dVisual", value = responses$q1d)
    updateSliderInput(session, "q1eVisual", value = responses$q1e)
  })
  
  observe({
    shinyjs::disable("q1aVisual")
    shinyjs::disable("q1bVisual")
    shinyjs::disable("q1cVisual")
    shinyjs::disable("q1dVisual")
    shinyjs::disable("q1eVisual")
  })
  #### Server - Q1f graph output ####
  # Plot the horizontal line chart with horizontal lines at each value
  output$HorizontalDistr <- renderPlotly({
    
    # Values to plot: Min, Q1, Median, Q3, Max
    x1 = c(0, responses$q1a)
    y1 = c(1, 1)
    
    x2 = c(responses$q1a, responses$q1d)
    y2 = c(1, 1)
    
    x3 = c(responses$q1d, responses$q1c)
    y3 = c(1, 1)
    
    x4 = c(responses$q1c, responses$q1e)
    y4 = c(1, 1)
    
    x5 = c(responses$q1e, responses$q1b)
    y5 = c(1, 1)
    
    x6 = c(responses$q1b, 4)
    y6 = c(1, 1)
    
    # Create the plot: horizontal lines at each metric
    plot_ly(hoverinfo='skip') %>%
      # Horizontal blocs
      add_trace(x=x1, y=y1, type = 'scatter', mode="lines", line = list(color = "#CC3311", width = 2)) %>%
      add_trace(x=x2, y=y2, type = 'scatter', mode="lines", line = list(color = "#4477AA", width = 50)) %>%
      add_trace(x=x3, y=y3, type = 'scatter', mode="lines", line = list(color = "#AA3377", width = 50)) %>%
      add_trace(x=x4, y=y4, type = 'scatter', mode="lines", line = list(color = "#228833", width = 50)) %>%
      add_trace(x=x5, y=y5, type = 'scatter', mode="lines", line = list(color = "#DDAA33", width = 50)) %>%
      add_trace(x=x6, y=y6, type = 'scatter', mode="lines", line = list(color = "#CC3311", width = 2)) %>%
      
      # Vertical black lines between blocs and markers
      add_trace(x=rep(responses$q1a,2), y=c(0.5, 1.11), type = 'scatter', mode="lines", line = list(color = "black", width = 1)) %>%
      add_trace(x=rep(responses$q1d,2), y=c(0.5, 1.11), type = 'scatter', mode="lines", line = list(color = "black", width = 1)) %>%
      add_trace(x=rep(responses$q1c,2), y=c(0.5, 1.11), type = 'scatter', mode="lines", line = list(color = "black", width = 1)) %>%
      add_trace(x=rep(responses$q1e,2), y=c(0.5, 1.11), type = 'scatter', mode="lines", line = list(color = "black", width = 1)) %>%
      add_trace(x=rep(responses$q1b,2), y=c(0.5, 1.11), type = 'scatter', mode="lines", line = list(color = "black", width = 1)) %>%
      
      # Markers with text inside
      add_trace(x=responses$q1a, y=0.5, text="L", type = 'scatter', mode="markers+text", marker = list(color = "white", size=40, line=list(width=2, color='DarkSlateGrey'))) %>%
      add_trace(x=responses$q1d, y=0.5, text="Q1", type = 'scatter', mode="markers+text", marker = list(color = "white", size=40, line=list(width=2, color='DarkSlateGrey'))) %>%
      add_trace(x=responses$q1c, y=0.5, text="Med", type = 'scatter', mode="markers+text", marker = list(color = "white", size=40, line=list(width=2, color='DarkSlateGrey'))) %>%
      add_trace(x=responses$q1e, y=0.5, text="Q3", type = 'scatter', mode="markers+text", marker = list(color = "white", size=40, line=list(width=2, color='DarkSlateGrey'))) %>%
      add_trace(x=responses$q1b, y=0.5, text="U", type = 'scatter', mode="markers+text", marker = list(color = "white", size=40, line=list(width=2, color='DarkSlateGrey'))) %>%
      
      layout(
        #title = "Distribution Metrics as Horizontal Lines",
        xaxis = list(#title = "Your estimated distribution", 
          tickvals = seq(0,4,0.1), 
          ticktext = c("<b>never: 0</b>", "", "0.2", "", "0.4", "", "0.6", "", "0.8", "",
                       "<b>hardly ever: 1</b>", "", "1.2", "", "1.4", "", "1.6", "", "1.8", "",
                       "<b>occasionally: 2</b>", "", "2.2", "", "2.4", "", "2.6", "", "2.8", "",
                       "<b>fairly often: 3</b>", "", "3.2", "", "3.4", "", "3.6", "", "3.8", "",
                       "<b>very often: 4</b>"), 
          range = c(0, 4), 
          zeroline = FALSE,
          tickangle= 330),
        yaxis = list(range=c(0, 1.5),
                     showticklabels = FALSE),
        showlegend = FALSE
      )
  })
  
  #### Server - Next / previous buttons ####
  observeEvent(input$nextBtn, {
    if (page() == 3) {
      showModal(
        modalDialog(
          title = "Confirmation",
          "Have you completed all 3 steps?",
          footer = tagList(
            modalButton("No"),
            actionButton("confirmNext", "Yes")
          )
        )
      )
    } else if (page() < total_pages) {
      page(page() + 1)
    }
  })
  
  observeEvent(input$confirmNext, {
    removeModal()
    if (page() < total_pages) {
      page(page() + 1)
    }
  })
  
  observeEvent(input$prevBtn, {
    if (page() > 1) {
      page(page() - 1)
    }
  })

  #### Server - PDF output  ####
  output$export = downloadHandler(
    filename = function() {
      paste0("My_results_", format(Sys.time(), "%Y%m%d_%H%M%S"), ".pdf")
    },
    content = function(file) {
      pdf(file, width = 10, height = 14)
      plot.new()
      text(0.5, 0.95, "Rethinking Missing Data with Patients: Your Responses", font = 2, cex = 1.5)
      
      # 6-month recall responses
      text(0.5, 0.85, "Group 1: 6-month recall", font = 2, cex = 1.2)
      
      # text(0.3, 0.8, "Thank you for completing the exercise! These are the 
      #      judgements / opinion / thoughts on the questions below. Please send 
      #      this document to s.greenwood.22@abdn.ac.uk.", cex = 1)
      
      text(0.3, 0.8, "Question", cex = 1)
      text(0.7, 0.8, "Your Response", cex = 1)
      
      text(0.3, 0.75, "1a) LOWEST overall average responses", cex = 0.9)
      text(0.7, 0.75, as.character(responses$q1a), cex = 0.9)
      
      text(0.3, 0.7, "1b) HIGHEST overall average responses", cex = 0.9)
      text(0.7, 0.7, as.character(responses$q1b), cex = 0.9)
      
      text(0.3, 0.65, "1c) Typical value on the average responses", cex = 0.9)
      text(0.7, 0.65, as.character(responses$q1c), cex = 0.9)
      
      text(0.3, 0.6, "1d) Quartile 1 of overall average responses", cex = 0.9)
      text(0.7, 0.6, as.character(responses$q1d), cex = 0.9)
      
      text(0.3, 0.55, "1e) Quartile 3 of overall average responses", cex = 0.9)
      text(0.7, 0.55, as.character(responses$q1e), cex = 0.9)
      
      text(0.3, 0.5, "1f) Rationale for your judgements", cex = 0.9)
      text(0.7, 0.5, "See below", cex = 0.9)
      
      if (responses$q1f != "") {
        wrapped_text <- strwrap(responses$q1f, width = 80)
        for (i in 1:min(length(wrapped_text), 10)) {
          text(0.5, 0.45 - (i * 0.03), wrapped_text[i], cex = 0.8)
        }
      }
      
      text(0.5, 0.2, paste("Your judgement suggests missing responses were", responses$comparison, 
                           "those who did answer."), cex = 0.9)
      
      text(0.5, 0.1, paste("Generated on:", format(Sys.time(), "%Y-%m-%d %H:%M:%S")), cex = 0.8)
      
      dev.off()
    }
  )
  #### Server - Navbar  ####
  # We want the two buttons to work together 
  # Sync Bottom Tab -> Updates Top Tab
  observeEvent(input$nav_tab_bottom_1, {
    updateTabsetPanel(session, "nav_tab_top_1", selected = input$nav_tab_bottom_1)
  })
  # Sync Top Tab -> Updates Bottom Tab
  observeEvent(input$nav_tab_top_1, {
    updateTabsetPanel(session, "nav_tab_bottom_1", selected = input$nav_tab_top_1)
  })

}

#### Run the app ####

shinyApp(ui, server)