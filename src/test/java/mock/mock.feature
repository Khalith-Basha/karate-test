Feature: stateful mock server

  Background:
    * configure cors = true

    Scenario: pathMatches('/11') && methodIs('get')
      * def response = read('../mock/mockResponse/DE000BASF111tickerResponse.json')
  Scenario: pathMatches('/13') && methodIs('get')
    * def response = read('../mock/mockResponse/DE000BASF113tickerResponse.json')
  Scenario: pathMatches('/I11') && methodIs('get')
    * def response = read('../mock/mockResponse/DE000BASF111instrumentResponse.json')
  Scenario: pathMatches('/I13') && methodIs('get')
    * def response = read('../mock/mockResponse/DE000BASF111instrumentResponse.json')

#  Scenario: pathMatches('/') && methodIs('post') && bodyPath('$.properties.id.type') == 'DE000BASF111.LSX' && bodyPath('$.properties.type.type') == 'ticker'
#    * def response = read('../mock/mockResponse/DE000BASF111tickerResponse.json')
#  Scenario: pathMatches('/') && methodIs('post') && bodyPath('$.properties.id.type') == 'DE000BASF113.LSX' && bodyPath('$.properties.type.type') == 'ticker'
#    * def response = read('../mock/mockResponse/DE000BASF113tickerResponse.json')
#  Scenario: pathMatches('/') && methodIs('post') && bodyPath('$.properties.id.type') == 'DE000BASF111.LSX' && bodyPath('$.properties.type.type') == 'instrument'
#    * def response = read('../mock/mockResponse/DE000BASF111instrumentResponse.json')
#  Scenario: pathMatches('/') && methodIs('post') && bodyPath('$.properties.id.type') == 'DE000BASF111.LSX' && bodyPath('$.properties.type.type') == 'instrument'
#    * def response = read('../mock/mockResponse/DE000BASF113instrumentResponse.json')
  Scenario:
    # catch-all
    * def responseStatus = 404
    * def responseHeaders = { 'Content-Type': 'text/html; charset=utf-8' }
    * def response = <html><body>Not Found</body></html>