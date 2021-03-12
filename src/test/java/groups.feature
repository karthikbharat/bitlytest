@e2e
Feature: Specific group related tests

  Background:
    * url 'https://api-ssl.bitly.com/v4/groups'
    * configure headers = read('classpath:headers.js')

  Scenario: contract testing - verify contracts of groups
    When method GET
    Then status 200
    * def result = response.groups
    * match result ==
    """
    [
        {
            "created": #string,
            "modified": #string,
            "bsds": #array,
            "guid": #string,
            "organization_guid": #string,
            "name": #string,
            "is_active": #boolean,
            "role": #string,
            "references": {
                "organization": #string
            }
        }
    ]
    """

  Scenario: validate valid  response for group
    When method GET
    Then status 200
    * def result = response.groups
    * match result ==
      """
      [
        {
            "created": "2021-03-09T18:00:50+0000",
            "modified": "2021-03-09T18:00:50+0000",
            "bsds": [],
            "guid": "Bl39i27Ji5U",
            "organization_guid": "Ol39iJl8uVl",
            "name": "bharathamanik",
            "is_active": true,
            "role": "org-admin",
            "references": {
                "organization": "https://api-ssl.bitly.com/v4/organizations/Ol39iJl8uVl"
            }
        }
    ]
      """

  Scenario Outline:validate invalid method calls - response code
    * request ''
    * configure charset = null
    When method <method>
    Then status <statusCode>

    Examples:
      | method | statusCode |
      | post   | 403        |
      | put    | 405        |
      | Delete | 405        |
      | patch  | 405        |