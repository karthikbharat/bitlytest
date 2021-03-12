# AUTOMATION TEST APPROACH
To facilitate the automation,points below considered
      -* how hard the logic usage in the functional tests
      -* Able usage of Gherkin language
      -* Re-usage and maintainability
      -* Ability to mentor new starters using it and use the automation as knowledege transfer tool for the product
      
# TEST TECHNIQUE USED
List of techniques used for testing the functions
            -*  Boundary value analysis for function testing
            -*  Contract testing to verify customers business logic
            -*  Exploratory test to find random errors
            -*  Invalid data supplied in fields,params and data to validate the negative error response

# GOOD TO HAVE
List of things can be improved
                         -*  Hard upper limit and lower limits not handled well, they should be handled and response should be readable and intuitive
                         -*  Query param 'units' need more clarity as it took a while to understand the usage. Any business case or ticket should be clear and concise and the acceptance criteria should be documented

 
### Steps to run 

-- Install as Gradle project
--  Since there is no dependency,run the Test runner class
-- Reports will be in  - target-cucumber-html-reports-overview-feature.html