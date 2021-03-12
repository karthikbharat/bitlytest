@e2e
Feature: Group bitlinks sort function tests

  Background:
    * url 'https://api-ssl.bitly.com/v4/groups/Bl39i27Ji5U/bitlinks'
    * configure headers = read('classpath:headers.js')

    Scenario: contract testing - verify contracts only for first array and pagination
    When method GET
    Then status 200
    * def result = response
    * match result.links[0].archived ==
      """
          false
      """
    And match result.pagination ==
    """
      {
        "prev": #present,
        "next": #present,
        "size": #number,
        "page": #number,
        "total": #number
    }
    """

    Scenario: configuration testing - validate default pagination count
    When method GET
    Then status 200
    * def result = response
    * match result.pagination.size == 50

  Scenario: Validate total links generated for this group
    When method GET
    Then status 200
    * def result = response
    And assert result.links.length == 17
    And match result.pagination ==
    """
      {
        "prev": #present,
        "next": #present,
        "size": 50,
        "page": 1,
        "total": 17
    }
    """