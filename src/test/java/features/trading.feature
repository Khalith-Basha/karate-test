@integration-test
Feature: Subcribe Ticker and Retrieve Instrument

  Scenario: Ticket Subscriber
    * def companyArgs = { wssocket : 'connect 21', type_p: 'wss', jsonpayload:'../testdata/device.json', subid: '14', typeReq: '{ "type": "ticker", "id": "DE000BASF111.LSX" }', wsschema:'subscriptionschema', path:'11', restschema:'ticketjsonschema' }
    * def result = call read('../commons/CommonStepDefs.feature') companyArgs
    Then match result.response == read('../expectedResponse/DE000BASF111tickerResponse.json')
     Then match result.response.properties.type.type == 'ticker'
    Then match result.response.properties.id.type == 'DE000BASF111.LSX'


  Scenario: Retrieve details about a single instrument.
    * def companyArgs = { wssocket : 'connect 21', type_p: 'wss', jsonpayload:'../testdata/device.json', subid: '1', typeReq: '{ "type": "instrument", "id": "DE000BASF111" }', wsschema:'subscriptionschema', path:'I11', restschema:'ticketjsonschema' }
    * def result = call read('../commons/CommonStepDefs.feature') companyArgs
    Then match result.response.properties.type.type == 'instrument'
    Then match result.response.properties.id.type == 'DE000BASF111'

  Scenario: Ticket Subscriber with different exchange code
    * def companyArgs = { wssocket : 'connect 21', type_p: 'wss', jsonpayload:'../testdata/device.json', subid: '13', typeReq: '{ "type": "ticker", "id": "DE000BASF111.LSX" }', wsschema:'subscriptionschema', path:'13', restschema:'ticketjsonschema' }
    * def result = call read('../commons/CommonStepDefs.feature') companyArgs
    Then match result.response.properties.type.type == 'ticker'
    Then match result.response.properties.id.type == 'DE000BASF113.LSX'


  Scenario: Retrieve details about another single instrument.
    * def companyArgs = { wssocket : 'connect 21', type_p: 'wss', jsonpayload:'../testdata/device.json', subid: '14', typeReq: '{ "type": "instrument", "id": "DE000BASF111" }', wsschema:'subscriptionschema', path:'I13', restschema:'ticketjsonschema' }
    * def result = call read('../commons/CommonStepDefs.feature') companyArgs
    Then match result.response.properties.type.type == 'instrument'
    Then match result.response.properties.id.type == 'DE000BASF111'

