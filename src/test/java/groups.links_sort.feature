@e2e
Feature: Group bitlinks sort function tests

  Background:
    * url 'https://api-ssl.bitly.com/v4/groups/Bl39i27Ji5U/bitlinks/clicks'
    * configure headers = read('classpath:headers.js')

  Scenario: Validate default sort -  default upto 50 results
    When method GET
    Then status 200
    * def result = response
    * match result.sorted_links contains
      """
   [{"clicks":2,"id":"bit.ly\/2ODsGly"},{"clicks":1,"id":"bit.ly\/3rzM0i5"},{"clicks":1,"id":"bit.ly\/3qAb1s1"},{"clicks":1,"id":"bit.ly\/3bvcBqO"},{"clicks":1,"id":"bit.ly\/38lg8Gk"}], expected: [{"id":"bit.ly\/2ODsGly","clicks":2},{"id":"bit.ly\/3bvcBqO","clicks":1},{"id":"bit.ly\/38lg8Gk","clicks":1}]
"""

  @ignore("query_parameter__upper/lower_limit_should_be_handled_well__instead_internal_error")
  Scenario Outline: invalid data validation for query <param>
    Given param <param> = <size>
    When method GET
    Then status <statusCode>
    * def error = response.message
    And match error == <errorResponse>
    Examples:
      | param          | size                       | errorResponse       | statusCode |
      | size           | 188888                     | 'INTERNAL_ERROR'    | 500        |
      | size           | -1                         | 'INTERNAL_ERROR'    | 500        |
      | unit           | "days"                     | "INVALID_ARG_UNIT"  | 400        |
      | unit_reference | "0001-03-09T15:04:05-0700" | 'INTERNAL_ERROR'    | 500        |
      | units          | -2                         | "INVALID_ARG_UNITS" | 400        |

  Scenario Outline:  invalid sort field and <param> validation
    Given param <param> = <paramType>
    When method GET
    Then status <statusCode>
    * def error = response.errors[0]
    And match error == <errorResponse>
    Examples:
      | param          | paramType | errorResponse                                       | statusCode |
      | size           | 'e'       | {"field": "size","error_code": "invalid"}           | 400        |
      | unit           | 'mon'     | {"field": "unit","error_code": "invalid"}           | 400        |
      | units          | -2        | {"field": "units","error_code": "invalid"}          | 400        |
      | unit_reference | -2        | {"field": "unit_reference","error_code": "invalid"} | 400        |

  Scenario Outline:  validate clicks based on sort <param>-----<testReason>
    Given param <param> = <paramType>
    When method GET
    Then status <statusCode>
    * def result = response
    * match result.sorted_links == <response>
    Examples:
      | testReason        | param          | paramType                  | response                                                                                                                                                                                   | statusCode |
      | --{defaultValue}  | unit_reference | ''                         | [{"id": "bit.ly/2ODsGly","clicks": 2},{"id": "bit.ly/3rzM0i5","clicks": 1},{"id": "bit.ly/3qAb1s1","clicks": 1},{"id": "bit.ly/3bvcBqO","clicks": 1},{"id": "bit.ly/38lg8Gk","clicks": 1}] | 200        |
      | ---{minimumRange} | unit_reference | '2021-03-09T15:04:05-0700' | [{"id": "bit.ly/2ODsGly","clicks": 2},{"id": "bit.ly/3bvcBqO","clicks": 1},{"id": "bit.ly/38lg8Gk","clicks": 1}]                                                                           | 200        |
      | ---{maximumRange} | unit_reference | '2021-03-12T00:00:00-0000' | [{"id": "bit.ly/2ODsGly","clicks": 2},{"id": "bit.ly/3rzM0i5","clicks": 1},{"id": "bit.ly/3qAb1s1","clicks": 1},{"id": "bit.ly/3bvcBqO","clicks": 1},{"id": "bit.ly/38lg8Gk","clicks": 1}] | 200        |
      | ---{minSize}      | size           | 1                          | [{"clicks":2,"id":"bit.ly\/2ODsGly"}]                                                                                                                                                      | 200        |
      | ---{maxSize}      | size           | 5                          | [{"id": "bit.ly/2ODsGly","clicks": 2},{"id": "bit.ly/3rzM0i5","clicks": 1},{"id": "bit.ly/3qAb1s1","clicks": 1},{"id": "bit.ly/3bvcBqO","clicks": 1},{"id": "bit.ly/38lg8Gk","clicks": 1}] | 200        |
      | ---{defaultUnits} | units          | -1                         | [{"id": "bit.ly/2ODsGly","clicks": 2},{"id": "bit.ly/3rzM0i5","clicks": 1},{"id": "bit.ly/3qAb1s1","clicks": 1},{"id": "bit.ly/3bvcBqO","clicks": 1},{"id": "bit.ly/38lg8Gk","clicks": 1}] | 200        |
      | ---{defaultUnit}  | unit           | 'day'                      | [{"id": "bit.ly/2ODsGly","clicks": 2},{"id": "bit.ly/3rzM0i5","clicks": 1},{"id": "bit.ly/3qAb1s1","clicks": 1},{"id": "bit.ly/3bvcBqO","clicks": 1},{"id": "bit.ly/38lg8Gk","clicks": 1}] | 200        |
