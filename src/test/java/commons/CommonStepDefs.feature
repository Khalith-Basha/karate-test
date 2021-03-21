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

    * def companyServiceBaseURL = call getEndpoint type_p
    * def wssocket = __arg.wssocket + " " +karate.readAsString(jsonpayload)
    * def subscribe = 'sub '+ subid  + ' ' + typeReq
    * def wssschemaPath = '../expectedschema/' + wsschema +".json"
    * def restschemaPath = '../expectedschema/'+ restschema +".json"



    # Configs
    * configure retry = { count: 5, interval: 90000 }

  Scenario: Subscription & Instrument
    #Get baseurl from karate-config.js file
    Given url companyServiceBaseURL
    And def socket = karate.webSocket(companyServiceBaseURL)
    When socket.send(wssocket)
    And def result = socket.listen(5000)
    * print result
    #VValidate connection request is connected or not
    Then match result == 'connected'
    #Subribe to ticker for example:  `sub 13 {  "type": "ticker", "id": "DE000BASF111.LSX" }`
    When socket.send(subscribe)
    And def result = socket.listen(5000)
    * def actualMsgType = result.split(' ')[1]
    #Validate we are not receiving Error in the response
    Then match actualMsgType !contains 'E'
    Then match actualMsgType == 'A'
    #RestAPI request call
    * def baseURL = call getEndpoint
    Given url baseURL
    And path path
    When method get
    Then status 200
    #Validate the json schema from the response
    Then match response == '#object'
    * string restSchemaExpected = read(restschemaPath)
    * string responseData = response
    * def SchemaUtils = Java.type('Utils.TestUtils')
    * assert SchemaUtils.isValid(responseData, restSchemaExpected)




