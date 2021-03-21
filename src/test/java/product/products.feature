@integration-test
Feature: Product Tests

  Scenario: Create a company, ADD & REMOVE a product
    # Part-1
    * def companyArgs = { wssocket : 'connect 21', type_p: 'wss', jsonpayload:'../testdata/device.json', subid: '14', typeReq: '{ "type": "ticker", "id": "DE000BASF111.LSX" }' }

    # Calling another re-useable feature to create a company
    # Note: While calling a feature the arguments should be a json/array
    * def createCompanyFeatureResult = call read('../commons/create.company.feature') companyArgs