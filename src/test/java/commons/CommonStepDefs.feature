Feature: Create companies

  Background:
    # Test case inputs
    * def wssocket = __arg.wssocket
    * def type_p = __arg.type_p
    * def jsonpayload = __arg.jsonpayload
    * def subid = __arg.subid
    * def typeReq = __arg.typeReq
   * def wsschema = __arg.wsschema
    * def requestbody = __arg.requestbody
    * def restschema = __arg.restschema
    * def path = __arg.path

    # Resolve company service URL based on the region using a javascript function defined
    # inside 'karate-config.js'
    * def companyServiceBaseURL = call getEndpoint type_p
    * def wssocket = __arg.wssocket + " " +karate.readAsString(jsonpayload)
    * def subscribe = 'sub '+ subid  + ' ' + typeReq
    * def wssschemaPath = '../expectedschema/' + wsschema +".json"
    * def restschemaPath = '../expectedschema/'+ restschema +".json"
    # Get company registration code as random UUID using another javascript function defined
    # inside 'karate-config.js'
    #* def companyRegistrationCode = call randomUUID

    # Configs
    * configure retry = { count: 5, interval: 90000 }

  Scenario: Ticker subscription
    Given url companyServiceBaseURL
    And def socket = karate.webSocket(companyServiceBaseURL)
    When socket.send(wssocket)
    And def result = socket.listen(5000)
    * print result
    Then match result == 'connected'
    When socket.send(subscribe)
    And def result = socket.listen(5000)
    * def actualMsgType = result.split(' ')[1]
    Then match actualMsgType == 'A'
    * def baseURL = call getEndpoint
    Given url baseURL
    And path path
    When method get
    Then status 200
    Then match response == '#object'
    * string restSchemaExpected = read(restschemaPath)
    * string responseData = response
    * def SchemaUtils = Java.type('Utils.TestUtils')
    * assert SchemaUtils.isValid(responseData, restSchemaExpected)




