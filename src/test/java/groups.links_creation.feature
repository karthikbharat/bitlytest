@e2e
Feature: Group bitlinks creation tests

  Background:
    * url 'https://api-ssl.bitly.com/v4/bitlinks'
    * configure charset = null
    * configure headers = read('classpath:headers.js')
    * def jsonPayload = read('/Users/bharathamanik/Desktop/Automation/bitly/src/test/resources/body.json')


  Scenario Outline: Validate a historical post link and comparae response by <field> -  (json payload from resources used)
    * request jsonPayload
    When method post
    Then status 200
    * def result = response
    * match result.<field> == "<response>"
    Examples:
      | field    | response                |
      | link     | https://bit.ly/30zP8P7  |
      | id       | bit.ly/30zP8P7          |
      | title    | test                    |
      | long_url | https://www.bbc.co.ken/ |

  Scenario Outline: check invalid data requests shows expected error response and status code
    * request <body>
    When method <methodRequest>
    Then status <statusCode>
    * def error = response.errors[0]
    And match error ==
    """ <errorResponse> """

    Examples:
      | body                                                      | methodRequest | statusCode | errorResponse                                 |
      | '{"long_url": ""}'                                        | post          | 400        | {"field": "long_url","error_code": "invalid"} |
      | '{"long": "https://www.bbc.co.uuuuu/"}'                   | post          | 400        | {"field": "long_url","error_code": "invalid"} |
      | '{"long_url": "https://www.bbc.co.uuuuu/","domain": "8"}' | post          | 400        | {"field": "domain","error_code": "invalid"}   |


  Scenario Outline:Create and validate newlink
  * request'{"long_url":"https://www.bbc.com.austria/","domain":"bit.ly","group_guid":"Bl39i27Ji5U","title":"NewApp"}'
  When method post
  Then status 201
  * def result = response
  * match result.<field>=="<response>"
    Examples:
      |field|response|
      |title|NewApp|
      |long_url|https://www.bbc.com.austria/|