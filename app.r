library(shiny)
library(bslib)
library(shinyjs)

ui <- fluidPage(
  theme = bs_theme(version = 5),
  useShinyjs(),
  title = "Rethinking missing data with patients",
  tags$script(HTML("
    document.addEventListener('DOMContentLoaded', function() {
      const updateSliderRelationships = function() {
        const sliders = {
          a: $('#question1aSlider'),
          b: $('#question1bSlider'),
          c: $('#question1cSlider'),
          d: $('#question1dSlider'),
          e: $('#question1eSlider'),
          gNo: $('#question1gNoSlider'),
          gYes: $('#question1gYesSlider')
        };
        
        $(document).on('change', '.js-range-slider', function(e) {
          const sliderId = $(this).attr('id');
          
          if (sliderId === 'question1aSlider') {
            if (parseFloat(sliders.a.val()) >= parseFloat(sliders.c.val())) {
              sliders.c.data('ionRangeSlider').update({ from: parseFloat(sliders.a.val()) + 0.1 });
            }
            if (parseFloat(sliders.c.val()) >= parseFloat(sliders.b.val())) {
              sliders.b.data('ionRangeSlider').update({ from: parseFloat(sliders.c.val()) + 0.1 });
            }
            
            if (parseFloat(sliders.a.val()) > parseFloat(sliders.d.val())) {
              sliders.d.data('ionRangeSlider').update({ from: parseFloat(sliders.a.val()) });
            }
            
            sliders.gNo.data('ionRangeSlider').update({ from: parseFloat(sliders.c.val()) });
          }
          else if (sliderId === 'question1bSlider') {
            if (parseFloat(sliders.b.val()) <= parseFloat(sliders.c.val())) {
              sliders.c.data('ionRangeSlider').update({ from: parseFloat(sliders.b.val()) - 0.1 });
            }
            if (parseFloat(sliders.c.val()) <= parseFloat(sliders.a.val())) {
              sliders.a.data('ionRangeSlider').update({ from: parseFloat(sliders.c.val()) - 0.1 });
            }
            
            if (parseFloat(sliders.b.val()) < parseFloat(sliders.e.val())) {
              sliders.e.data('ionRangeSlider').update({ from: parseFloat(sliders.b.val()) });
            }
          }
          else if (sliderId === 'question1cSlider') {
            if (parseFloat(sliders.c.val()) <= parseFloat(sliders.a.val())) {
              sliders.a.data('ionRangeSlider').update({ from: parseFloat(sliders.c.val()) - 0.1 });
            }
            if (parseFloat(sliders.c.val()) >= parseFloat(sliders.b.val())) {
              sliders.b.data('ionRangeSlider').update({ from: parseFloat(sliders.c.val()) + 0.1 });
            }
            
            sliders.gNo.data('ionRangeSlider').update({ from: parseFloat(sliders.c.val()) });
          }
          else if (sliderId === 'question1dSlider') {
            if (parseFloat(sliders.d.val()) < parseFloat(sliders.a.val())) {
              sliders.d.data('ionRangeSlider').update({ from: parseFloat(sliders.a.val()) });
            }
            if (parseFloat(sliders.d.val()) > parseFloat(sliders.c.val())) {
              sliders.d.data('ionRangeSlider').update({ from: parseFloat(sliders.c.val()) });
            }
          }
          else if (sliderId === 'question1eSlider') {
            if (parseFloat(sliders.e.val()) < parseFloat(sliders.c.val())) {
              sliders.e.data('ionRangeSlider').update({ from: parseFloat(sliders.c.val()) });
            }
            if (parseFloat(sliders.e.val()) > parseFloat(sliders.b.val())) {
              sliders.e.data('ionRangeSlider').update({ from: parseFloat(sliders.b.val()) });
            }
          }
        });
      };
      
      updateSliderRelationships();
    });
  ")),
  div(
    style="display:none;",
    textInput("page", "", value = "1"),
  ),
  div(
    h1("Rethinking missing data with patients"),
    hr(),
  ),
  conditionalPanel(
    condition = "input.page == 1",
    p("Introduction", style = "font-size: 24px; font-weight: bold;"),
    p("Clinical trials are important studies that gather evidence which is used 
      then to decide which healthcare options are available to everyone in the future. 
      Most of these trials will have measurements missing from participants, just like 
      pieces missing from a puzzle."),
    p("Researchers are asking if patients to help them 'fill the gaps' of these 
      puzzles, and this is where you can make a difference."),
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
        tags$a("Download File", href = "FAQs.pdf", download = NA)
      )
    ),
    p("If you would like to have any support when completing, contact ", tags$a(href = "mailto:s.greenwood.22@abdn.ac.uk?subject=Question%20-%20rethinking%20missing%20data%20with%20patients", "s.greenwood.22@abdn.ac.uk")),
    p("Click next to get started.")
  ),
  conditionalPanel(
    condition = "input.page == 2",
    p("Background", style = "font-size: 24px; font-weight: bold;"),
    p("Here is some information to give you a bit of context about the puzzle we are looking to fill together."),
    
    accordion(
    id = "clinical_trial_acc",
    open = c("What is the clinical trial?"),
    multiple = FALSE,  # Close other panels when one is opened
    
    accordion_panel(
      title = "What is the clinical trial?",
      icon = bsicons::bs_icon("patch-question"),
      div("Traditionally, dentists have encouraged both patients at risk of developing dental disease to attend their dental practices for regular 6-month 'check-ups'. There is, however, little evidence available for either patients or dentists to use when deciding on the best dental recall interval (i.e. time between dental check-ups) for maintaining oral health. In this study, they wanted to find out, for adult patients who regularly attend the dentist, what interval of time between dental check-ups maintains optimum oral health and represents value for money.")
    ),
    accordion_panel(
      title = "Who are the participants in the trial?",
      icon = bsicons::bs_icon("person-circle"),
      div("A total of 2372 adults aged 18 years and over who regularly attended 51 different dental practices across Scotland, Northern Ireland, England and Wales were involved. Patients aged 18 years or over who received all or part of their care as NHS patients.")
    ),
    accordion_panel(
      title = "What was the intervention?",
      icon = bsicons::bs_icon("prescription2"),
      div(
        "The intervention was how often a patient saw their dentist for a check-up. This was just a dental check-up and excluded any other treatments like scale and polish. Participants were randomly split into groups with each one assigned the dental check-up time of either:",
        tags$ul(
          tags$li("Every ", strong("2 years "), ", if considered at low risk by their dentist"),
          tags$li("Every ", strong("6 months")),
          tags$li("Or ", strong("risk-based"), "which they said was ", em("'an individualised, recall interval based on the patient's risk of dental disease.'"))
        ),
        p(""),
        p(strong("Note:"), "In this exercise we are going to focus on just those assigned to 6-month and risk-based recall, who were typically older with worse scores."),
      ),
    ),
    accordion_panel(
        title = "What are the missing measurements we are interested in today?",
        icon = bsicons::bs_icon("puzzle"),
        div(
            p("Many measurements were taken from participants in this clinical trial. This exercise focuses on just one, which was asking them about a specific symptom over the last 12 months."),
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
          "This question was asked in a questionnaire, which patients completed once a year. ",
          "It was completed at home and returned to the researchers using a pre-paid envelope. They did this every year for 4 years.",
          p(""),
          p(strong("Note:"), "we are going to focus on the missing answers to this question just at Year 4"),
        )
    ),
    accordion_panel(
        title = "How many pieces were missing?",
        icon = bsicons::bs_icon("search"),
        div(
          p(strong("How many were missing?"), "There were 438 patients missing an answer to this question. Split into the two groups it looked like this."),
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
        icon = bsicons::bs_icon("person-circle"),
        div(
          p("Limited information is available about the patient who did not answer that question. We can only search for clues. This is why we are doing this exercise! More information will be given before you do the exercise. "),
          
        )
    ),
    accordion_panel(
      title="What do we need to 'fill the gaps'?",
      icon = bsicons::bs_icon("question-circle"),
      div(
        p("We want to get a general sense of how they could have answered that question 4 years after they started the study. To get that overall picture we will focus on estimating the 'average'. This value can be anything between 0 to 4 and represents the typical response from this group")
      )
    ),
    accordion_panel(
      title = "Remember",
      icon = bsicons::bs_icon("lightbulb"),
      div(
        p(strong("Remember:"), "If you're not feeling sure about knowledge on this that is a good thing. Counter to what you might think, we want to capture that",em("uncertainty"),"in your judgements. Your judgement is not being used to accurately represent one patient's medical condition, it is about getting a general sense about all of those patients with missing measurements, and what their results might have been.")
      )
    ),
    accordion_panel(
      title = "Next step",
      icon = bsicons::bs_icon("person-circle"),
      div(
        p(strong("Remember:"), "If you're not feeling sure about knowledge on this that is a good thing. Counter to what you might think, we want to capture that",em("uncertainty"),"in your judgements. Your judgement is not being used to accurately represent one patient's medical condition, it is about getting a general sense about all of those patients with missing measurements, and what their results might have been.")
      ),
      
      div(
        p("We are going to look at one group at a time."),
        tags$ul(
          tags$li("First, the 217 patients in the 6 month group"),
          tags$li("Second, the 221 patients in the risk-recall group"),
          tags$li("Then, you will download your responses!"),
        ),
      )
    )
  )
  ),
  conditionalPanel(
    condition = "input.page == 3",
    p("Page to be deleted", style = "font-size: 24px; font-weight: bold;"),
    # p("We are going to focus on those participants with the missing measurements for this question below"),
    # accordion(
    #   id = "question-explanations",
    #   open = c("The missing puzzle pieces"),
    #   multiple = FALSE,  # Close other panels when one is opened
      # accordion_panel(
      #   title = "The missing puzzle pieces",
      #   icon = bsicons::bs_icon("puzzle"),
      #   div(
      #     p("Many measurements were taken from participants in this trial. This exercise focuses on just one."),
      #     tags$ul(
      #       tags$li(strong("Question:"), "Have you had painful aching in your mouth?"),
      #       tags$li(strong("Answer options:"), "a number from 0 to 4"),
      #     ),
      #     tags$table(
      #       class = "table table-bordered table-striped",
      #       tags$thead(
      #         tags$tr(
      #           tags$th("0"),
      #           tags$th("1"),
      #           tags$th("2"),
      #           tags$th("3"),
      #           tags$th("4")
      #         )
      #       ),
      #       tags$tbody(
      #         tags$tr(
      #           tags$td("never"),
      #           tags$td("hardly ever"),
      #           tags$td("occasionally"),
      #           tags$td("fairly often"),
      #           tags$td("very often")
      #         )
      #       )
      #     ),
      #     "This question was in a questionaire measuring patients' oral health symptoms over the past 12 months. The participants completed it at home and returned them to the researcher using a pre-paid envelope. They did this every year for 4 years.",
      #     p(strong("Note:"), "we are going to focus on the missing answers to this question just at Year 4"),
      #   )
      # ),
  #     accordion_panel(
  #       title="What do we need to 'fill the gaps'?",
  #       icon = bsicons::bs_icon("question-circle"),
  #       div(
  #         p("We want to get a general sense of how they could have answered that question 4 years after they started the study. To get that overall picture we will focus on estimating the 'average'. This value can be anything between 0 to 4 and represents the typical response from this group")
  #       )
  #     ),
  #     accordion_panel(
  #       title = "Remember",
  #       icon = bsicons::bs_icon("lightbulb"),
  #       div(
  #         p(strong("Remember:"), "If you're not feeling sure about knowledge on this that is a good thing. Counter to what you might think, we want to capture that",em("uncertainty"),"in your judgements. Your judgement is not being used to accurately represent one patient's medical condition, it is about getting a general sense about all of those patients with missing measurements, and what their results might have been.")
  #       )
  #     ),
  #     accordion_panel(
  #       title = "Participants we are focusing on",
  #       icon = bsicons::bs_icon("person-circle"),
  #       div(
  #         p("Next we are going to look at each treatment arm. Focusing on the 237 participants in the 6-month group first, then the 233 in the risk-recall arm."),
  #         tags$table(
  #           class = "table table-bordered table-striped",
  #           tags$thead(
  #             tags$tr(
  #               tags$th("(Currently Figure 6 data)"),
  #               tags$th("6-months"),
  #               tags$th("Risk-based recall")
  #             )
  #           ),
  #           tags$tbody(
  #             tags$tr(
  #               tags$td("How many are in the group"),
  #               tags$td("861 (100%)"),
  #               tags$td("863 (100%)")
  #             ),
  #             tags$tr(
  #               tags$td("Missing the answer to Q1 in their questionaire at Year 4"),
  #               tags$td("237 (27.5%)"),
  #               tags$td("233 (27.0%)")
  #             )
  #           )
  #         )
  #       )
  #     )
    # ),
  ),
  conditionalPanel(
    condition = "input.page == 4",
    p(strong("Group 1:"), "6-month recall"),
    p("We are first going to focus on the 861 participants who were going back to see the dentist every 6-months. We want to estimate the responses of those 237 (27.5%) whose responses were missing."),
    accordion(
      id = "q1-accordion",
      open = c("The missing puzzle pieces"),
      multiple = FALSE,
      accordion_panel(
        title = "How many of the participant in this group missed a response to the question?",
        icon = bsicons::bs_icon("search"),
        p("Of the 861 participants on the 6-month, 237 (27.5%) missed a response to this question at year 4."),
        tags$table(
          class = "table table-bordered table-striped",
          tags$thead(
            tags$tr(
              tags$th("(Currently Figure 6 data)"),
              tags$th("6-months")
            )
          ),
          tags$tbody(
            tags$tr(
              tags$td("How many are in the group"),
              tags$td("861 (100%)")
            ),
            tags$tr(
              tags$td("Missing the answer to Q1 in their questionaire at Year 4"),
              tags$td("237 (27.5%)")
            )
          )
        )
      ),
      accordion_panel(
        title="What is the profile of these missing participants?",
        icon = bsicons::bs_icon("person-circle"),
        p("Here is a table showing some information about the patient with missing data. On the right you can see also the information about those without, to allow you to compare if you want to!"),
        tags$table(
          class = "table table-bordered table-striped",
          tags$thead(
            tags$tr(
              tags$th(""),
              tags$th("Participants with a missing answer?"),
              tags$th("Participants with no missing answer?"),
              tags$th("Total - Table 6 - data")
            )
          ),
          tags$tbody(
            tags$tr(
              tags$td("How many of them? (%)"),
              tags$td("TODO"),
              tags$td("TODO"),
              tags$td("863 (100%)")
            ),
            tags$tr(
              tags$td("Did they complete this question at the start?"),
              tags$td("TODO"),
              tags$td("TODO"),
              tags$td("803 (93%)")
            ),
            tags$tr(
              tags$td("Age (years) - the mean"),
              tags$td("TODO"),
              tags$td("TODO"),
              tags$td("50.1 years")
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
              tags$td("TODO"),
              tags$td("TODO"),
              tags$td("366 (42.4%)")
            ),
            tags$tr(
              tags$td(
                tags$ul(
                  tags$li("Female")
                )
              ),
              tags$td("TODO"),
              tags$td("TODO"),
              tags$td("491 (56.9%)")
            ),
            tags$tr(
              tags$td(
                tags$ul(
                  tags$li("Missing")
                )
              ),
              tags$td("TODO"),
              tags$td("TODO"),
              tags$td("6 (0.7%)")
            ),
            tags$tr(
              tags$td("Smoked in last 12 months"),
              tags$td("TODO"),
              tags$td("TODO"),
              tags$td("130 (15.1%)")
            ),
            tags$tr(
              tags$td("Time since previous visit to dentist"),
            ),
            tags$tr(
              tags$td(
                tags$ul(
                  tags$li("< 1 year")
                )
              ),
              tags$td("TODO"),
              tags$td("TODO"),
              tags$td("741 (85.9%)")
            ),
            tags$tr(
              tags$td(
                tags$ul(
                  tags$li("1-2 years")
                )
              ),
              tags$td("TODO"),
              tags$td("TODO"),
              tags$td("51 (5.9%)")
            ),
            tags$tr(
              tags$td(
                tags$ul(
                  tags$li("> 2 years")
                )
              ),
              tags$td("TODO"),
              tags$td("TODO"),
              tags$td("0 (0%)")
            ),
            tags$tr(
              tags$td(
                tags$ul(
                  tags$li("Missing")
                )
              ),
              tags$td("TODO"),
              tags$td("TODO"),
              tags$td("71 (8.2%)")
            ),
            tags$tr(
              tags$td("Patient status, n (%)"),
            ),
            tags$tr(
              tags$td(
                tags$ul(
                  tags$li("NHS")
                )
              ),
              tags$td("TODO"),
              tags$td("TODO"),
              tags$td("677 (78.4%)")
            ),
            tags$tr(
              tags$td(
                tags$ul(
                  tags$li("Private")
                )
              ),
              tags$td("TODO"),
              tags$td("TODO"),
              tags$td("32 (3.7%)")
            ),
            tags$tr(
              tags$td(
                tags$ul(
                  tags$li("Combination")
                )
              ),
              tags$td("TODO"),
              tags$td("TODO"),
              tags$td("56 (6.5%)")
            ),
            tags$tr(
              tags$td(
                tags$ul(
                  tags$li("Missing")
                )
              ),
              tags$td("TODO"),
              tags$td("TODO"),
              tags$td("71 (8.2%)")
            ),
            tags$tr(
              tags$td("Type of toothbrush, n (%)"),
            ),
            tags$tr(
              tags$td(
                tags$ul(
                  tags$li("Manual")
                )
              ),
              tags$td("TODO"),
              tags$td("TODO"),
              tags$td("496 (57.5%)")
            ),
            tags$tr(
              tags$td(
                tags$ul(
                  tags$li("Electric")
                )
              ),
              tags$td("TODO"),
              tags$td("TODO"),
              tags$td("298 (34.5%)")
            ),
            tags$tr(
              tags$td(
                tags$ul(
                  tags$li("Missing")
                )
              ),
              tags$td("TODO"),
              tags$td("TODO"),
              tags$td("69 (8%)")
            ),
            tags$tr(
              tags$td("Regular attender to dentist?"),
              tags$td("TODO"),
              tags$td("TODO"),
              tags$td("735 (85.2%)")
            )
          ),
        )
      ),
      accordion_panel(
        title = "Remember: their missing puzzle piece",
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
    p("Now we are going to estimate the 237 (27.5%) whose responses were missing. We want to get a general sense of how they could have answered to that question 4 years after they started the study. To get that overall picture we will focus on estimating the 'average'. This value can be anything between 0 to 4 and represents what the typical response from these 237 overall."),
    navset_card_tab(
      nav_panel("Question 1a", 
        div(
          div(strong("Question 1a: "), p("Thinking about the overall average response from these participants, based on your judgement. What is the LOWEST possible value the average could be? (L = lower plausible limit)")),
          sliderInput("question1aSlider", label = NULL, min = 0, max = 4, value = 0, step = 0.1),
          uiOutput("question1aValue") # Display the selected value
        )
      ),
      nav_panel("Question 1b", 
        div(
          div(strong("Question 1b: "), p("Thinking about the overall average response from these participants, based on your judgement. What is the HIGHEST possible value the average could be? (U = upper plausible limit)")),
          sliderInput("question1bSlider", label = NULL, min = 0, max = 4, value = 4, step = 0.1),
          uiOutput("question1bValue"), # Display the selected value
          p("Reflection: Based on the answer you've given, you think that the average participant response to the questionnaire ranged from "),
          uiOutput("reflection1ab") # Display the reflection with values
        )
      ),
      nav_panel("Question 1c", 
        div(
          div(strong("Question 1c:"), p("Now you have you highest and lowest value, where in between these values splits the score, where it is equally likely that the average is above and below that value? Note that it doesn't have to sit in the middle! A value closer to right this means you think that then average of these 237 participants are likely to be is likely to be a higher score, which is a worse outcome")),
          uiOutput("question1cRange"), # Show current range from 1a and 1b
          sliderInput("question1cSlider", label = NULL, min = 0, max = 4, value = 2, step = 0.1),
          uiOutput("question1cValue"), # Display the selected value
          div(
            strong("Reflection:"),
            tags$ul(
              tags$li(strong("Question:"), "Once you have a value on the scale have a think. Imagine you're in a game show and there is big prize for getting this question right. Do you think the average is more likely to be in above or below that middle value?"),
              tags$li(strong("Answer:"), "If you answered yes, return to Q1c and consider increasing or reducing your value until you don't have a preference for above or below. If you answered no, continue onto the next")
            )
          )
        )
      ),
      nav_panel("Question 1d", 
        div(
          p("We're now going to split our group of 237 participant in half. One half have better (lower) scores, and the other have worse (higher) scores for the 6-months group."),
          div(strong("Question 1d:"), "For the half of the 237 participant with lower (better) scores move the scale to draw a line on the left where you think it is equally likely that the average is above and below that value? (remember it doesn't need to be in the middle!)"),
          uiOutput("question1dRange"), # Show current range from 1a and 1c
          sliderInput("question1dSlider", label = NULL, min = 0, max = 4, value = 1, step = 0.1),
          uiOutput("question1dValue") # Display the selected value
        )
      ),
      nav_panel("Question 1e", 
        div(
          div(strong("Question 1e:"), "For the half of the 237 participant with higher (worse) scores move the scale to draw a line on the left where you think it is equally likely that the average is above and below that value? (remember it doesn't need to be in the middle!)"),
          uiOutput("question1eRange"), # Show current range from 1c and 1b
          sliderInput("question1eSlider", label = NULL, min = 0, max = 4, value = 3, step = 0.1),
          uiOutput("question1eValue"), # Display the selected value
          div(strong("Reflection:"), "You have given your judgement about the average missing score for those 237 participants through 5 numbers. We now have a plot that is split into four segments, where it is equally likely that the average value of those 237 participants could be in each segment. It's normal for them not to be equally sized, often the middle two segments are much smaller!")
        )
      ),
      nav_panel("Question 1f", 
        div(
          div(strong("Question 1f:"), "Do you have any reasons, or rationale you want to write about your judgement above?"),
          uiOutput("question1fSummary"), # Show summary of previous answers
          textAreaInput("question1fTextArea", label = NULL, placeholder = "Write your reasons here"),
          p("Remember, we want to capture that uncertainty in your judgements, and we are asking your judgement to get a general sense about those patients with missing measurements, and what their results might have been. So we have one last reflection to help you with your response.")
        )
      ),
      nav_panel("Question 1g", 
        div(
          div(strong("Question 1g:"), "Lastly, lets now compare your judgements on the average of the 237 participants who did not answer against the average of the 624 participants who did answer the question."),
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
                tags$td("No (your judgement on the 237 participants)"),
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
          p("If you're not happy with your response feel free to edit the scale above of your judgment. This will update your original answers to Q1a – 1e.")
        )
      )
    )
  ),

  conditionalPanel(
    condition = "input.page == 5",
    p("Last step", style = "font-size: 24px; font-weight: bold;"),
    p("If you’ve not done so yet, please download your results."),
    div(downloadButton("export", "Download Results")),
    hr(),
    p("Then please send this downloaded file to ", 
      tags$a(href = "mailto:s.greenwood.22@abdn.ac.uk?subje
             ct=My%20Results%20-%20rethinking%20missing%20data%
             20with%20patients", 
             "s.greenwood.22@abdn.ac.uk")), 
    p("That is the end of this exercise! Next part is the consensus meeting."),
    strong("Where are your results going?"),
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
      Council’s (MRC) Trials Methodology Research Partnership (TMRP) 
      Doctoral Training Partnership (DTP), grant number MR/W006049/1."),
    strong("References:"),
    p("we'd like to note a series of resources that were fundamental in the 
    creation of this tool. "),
    tags$ul(
      tags$li("SHELF", em("add reference details")),
      tags$li("Mason et al. paper", em("add reference details")),
    ),
  ),
  div(
    style="display: flex; justify-content: space-between;",
    conditionalPanel(
      condition = "input.page == 1",
      p(),
    ),
    conditionalPanel(
      condition = "input.page > 1",
      actionButton("prevBtn", "Previous"),
    ),
    conditionalPanel(
      condition = "input.page < 5",
      actionButton("nextBtn", "Next")
    ),
  ),
  hr(),
  p("MIA Tool (Missing Information Analyser)"),
)






server <- function(input, output, session) {
  page <- reactiveVal(1)
  total_pages <- 5
  
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
    HTML(paste0("<strong>", responses$q1a, "</strong> (L) and <strong>", responses$q1b, "</strong> (U). If this is not what you think go back to edit your answer to Q1a and Q1b. After thinking about the extreme cases, we now have a scale of all the possible values that this average could be."))
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
  
  output$question1fSummary <- renderUI({
    div(
      p("Your judgments so far:"),
      tags$ul(
        tags$li("Lowest possible average: ", strong(responses$q1a)),
        tags$li("Highest possible average: ", strong(responses$q1b)),
        tags$li("Median value (equally likely to be above/below): ", strong(responses$q1c)),
        tags$li("Lower half median: ", strong(responses$q1d)),
        tags$li("Upper half median: ", strong(responses$q1e))
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
  
  observeEvent(input$page, {
    if (input$page == 4) {
      median_val <- round((responses$q1a + responses$q1b) / 2, 1)
      updateSliderInput(session, "question1cSlider", value = median_val)
      
      lower_quartile <- round((responses$q1a + median_val) / 2, 1)
      updateSliderInput(session, "question1dSlider", value = lower_quartile)
      
      upper_quartile <- round((median_val + responses$q1b) / 2, 1)
      updateSliderInput(session, "question1eSlider", value = upper_quartile)
      
      updateSliderInput(session, "question1gNoSlider", value = median_val)
    }
  })
  
  observeEvent(input$question1aSlider, {
    if (input$question1aSlider >= input$question1cSlider) {
      updateSliderInput(session, "question1cSlider", value = input$question1aSlider + 0.1)
    }
    if (input$question1aSlider > input$question1dSlider) {
      updateSliderInput(session, "question1dSlider", value = input$question1aSlider)
    }
  })
  
  observeEvent(input$question1bSlider, {
    if (input$question1bSlider <= input$question1cSlider) {
      updateSliderInput(session, "question1cSlider", value = input$question1bSlider - 0.1)
    }
    if (input$question1bSlider < input$question1eSlider) {
      updateSliderInput(session, "question1eSlider", value = input$question1bSlider)
    }
  })
  
  observeEvent(input$question1cSlider, {
    if (input$question1cSlider <= input$question1aSlider) {
      updateSliderInput(session, "question1aSlider", value = input$question1cSlider - 0.1)
    }
    if (input$question1cSlider >= input$question1bSlider) {
      updateSliderInput(session, "question1bSlider", value = input$question1cSlider + 0.1)
    }
    if (input$question1cSlider < input$question1dSlider) {
      updateSliderInput(session, "question1dSlider", value = input$question1cSlider)
    }
    if (input$question1cSlider > input$question1eSlider) {
      updateSliderInput(session, "question1eSlider", value = input$question1cSlider)
    }
    updateSliderInput(session, "question1gNoSlider", value = input$question1cSlider)
  })
  
  observeEvent(input$question1dSlider, {
    if (input$question1dSlider < input$question1aSlider) {
      updateSliderInput(session, "question1dSlider", value = input$question1aSlider)
    }
    if (input$question1dSlider > input$question1cSlider) {
      updateSliderInput(session, "question1dSlider", value = input$question1cSlider)
    }
  })
  
  observeEvent(input$question1eSlider, {
    if (input$question1eSlider < input$question1cSlider) {
      updateSliderInput(session, "question1eSlider", value = input$question1cSlider)
    }
    if (input$question1eSlider > input$question1bSlider) {
      updateSliderInput(session, "question1eSlider", value = input$question1bSlider)
    }
  })
  
  observeEvent(input$nextBtn, {
    if (page() < total_pages) {
      page(page() + 1)
    }
  })
  
  observeEvent(input$prevBtn, {
    if (page() > 1) {
      page(page() - 1)
    }
  })
  
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
}

shinyApp(ui, server)