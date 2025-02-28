Save variables in local storage and reload on pageload,

have a popup to ask if they want to use existing data or start new, hidden input enter variables from local storage nto this input and show a popup, if they choose yes then populate these variables into rest of app variables

Be able to define some stuff like email addresses, extra descriptions in variables and it get loaded into the r code.

Add comments to everything

## Middle step between highest and medium where they reflect on if its correct



div(
        conditionalPanel(
          condition = "input.page == 4",
          p("Move the slider to where you think the lower bound is")
        ),
        conditionalPanel(
          condition = "input.page == 5",
          p("Move the slider to where you think the upper bound is")
        ),
        conditionalPanel(
          condition = "input.page == 6",
          p("Move the slider to where you think the middle is")
        ),
      ),
      div(
        class = "slider-container",
        div(
          style = "position: relative; height: 150px;",
          conditionalPanel(
            condition = "input.page >= 4",
            sliderInput("slider1", label = NULL, min = 0, max = 4, value = 0,step=0.1)
          ),
          conditionalPanel(
            condition = "input.page >= 5",
            sliderInput("slider3", label = NULL, min = 0, max = 4, value = 4,step=0.1)
          ),
          conditionalPanel(
            condition = "input.page >= 6",
            sliderInput("slider2", label = NULL, min = 0, max = 4, value = 2,step=0.1)
          ),
        ),
      ),
      conditionalPanel(
        condition = "input.page == 7",
        p("Confirm difference between treatment arms"),
        numericInput("confirm", "Confirm", value = 0)
      ),
      conditionalPanel(
        condition = "input.page == 8",
        p("Thank you for writing your judgement. Please download your responses. This is an important step as your

results will not save when you close this window."),
        downloadButton("export", "Export PDF")
      )