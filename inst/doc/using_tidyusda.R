## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup---------------------------------------------------------------
library(tidyUSDA)

## ------------------------------------------------------------------------
# Use keyring to store your api key
# key <- keyring::key_get("tidyusda")

# Or hard code that thing
key <- '7CE0AFAD-EF7B-3761-8B8C-6AF474D6EF71'  # please get your own key!

## ------------------------------------------------------------------------
tidyUSDA::allCategory %>% head()

## ------------------------------------------------------------------------
tidyUSDA::allGeogLevel %>% head()

## ---- results = "hide"---------------------------------------------------
# Get count of operations with sales in 2017
ops.with.sales <- tidyUSDA::getQuickstat(
  sector=NULL,
  group=NULL,
  commodity=NULL,
  category=NULL,
  domain='TOTAL',
  county=NULL,
  key = key,
  program = 'CENSUS',
  data_item = 'CROP TOTALS - OPERATIONS WITH SALES',
  geographic_level = 'STATE',
  year = '2017',
  state = NULL,
  geometry = TRUE,
  lower48 = TRUE)

## ------------------------------------------------------------------------
# Plot this data for each state
tidyUSDA::plotUSDA(df = ops.with.sales)


## ------------------------------------------------------------------------
mydata <- ops.with.sales[,c("NAME", "Value", "ALAND")]

## ------------------------------------------------------------------------

mydata$ALAND <- as.numeric(mydata$ALAND)
mydata$modified_value <- mydata$Value / mydata$ALAND

## ------------------------------------------------------------------------
tidyUSDA::plotUSDA(df = mydata, fill_by = 'modified_value')

