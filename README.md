# karate-test
A sample karate test project to showcase API testing using Karate (https://github.com/intuit/karate) framework.

Features:
* Stubbing API using karate mock
* Feature calling another features.
* Utility javascript functions.
* Re-useable feature files. (Refer to `commons` folder)
* Configure retries for API calls.
* Reading & Writing files.
* Call to Java methods. (Refer to `TestUtils.java` class)
* Karate parallel execution. (Refer to `TestParallel.java` class)
* Test HTML reports.

# Getting Started
We have following 2 REST APIs and 1 Websocket endpoint to test:
Websocket Endpoint : wss://api.staging.neontrading.com
* **Get /11** - To subscribe the ticker
```json
{
  "properties": {
    "type": {
      "type": "ticker"
    },
    "id": {
      "type": "DE000BASF111.LSX",
      "description": "ISIN and exchange shortcode of the ticker"
    }
  }
}
```
* **Get /I11** - To Reretreive Instrument
```json
{
  "properties": {
    "type": {
      "type": "instrument"
    },
    "id": {
      "type": "DE000BASF111",
      "description": "ISIN and exchange shortcode of the ticker"
    }
  }
}

The feature files are inside `src/test/java/features` folder as this is the default classpath location.

We have a feature file `trading.feature` which has 4 scenarios, first one is to authenticate websocket gateway and subscribe the request - 
`sub <subId> <payload>` and then for ticket subscribtion rest api

Second scenario is to authenticate websocket gateway and subscribe the request - `sub <subId> <payload>` and then and Retrieve details about a single instrument.

1.Trading.feature - We are defining all the inputs required for the websocket and rest api calls ( include json schema files for each api)
 def companyArgs = { wssocket : 'connect 21', type_p: 'wss', jsonpayload:'../testdata/device.json', subid: '14', typeReq: '{ "type": "ticker", "id": "DE000BASF111.LSX" }', wsschema:'subscriptionschema', path:'11', restschema:'ticketjsonschema' }
 Then weare calling commonstepDef.feature ( which is common for all the api)

`CommonStepDef.feature  (This feature file is kept inside common folder).
This feature file following actions are performed.
1. Reretreive baseurl from karate-config.js file
2. Authentication to websocket with Device details ( This device details is placed as jsonfile in testdata/device.json)
3. Validate connection request is connected or not
4. Subribe to ticker. for example:  `sub 13 {  "type": "ticker", "id": "DE000BASF111.LSX" }`
5. Validate we are not receiving Error in the response
6. RestAPI request call - Mock endpoint
7. Validate the response from json schema
Please note, these steps are common for all 4 scenarios. 

inside `TestUtils.java`, this java method is being called to validate the json schema

`karate-config.js`- config file. Based on environment, url it will set the endpoint. if we are not setting the env then by default it will connect to mock server. 


**Note:** This project makes use of karate parallel execution scemantics which is being defined inside `TestParallel.java`


Following maven command will be used to run the feature files:

```shell script
mvn test -P karate-integration-tests -Dtest=TestParallel -Dproduct.service.base.url=<Actual_URL>
```

### Test Reports

This project uses `cucumber-reporting` maven plugin to generate the HTML & JSON reports from the `maven-surefire` xml reports.

To get these HTML reports in `jenkins` we need to install a jenkins plugin `Cucumber reports`. More information on this `jenkins` plugin can be found here:
* https://github.com/jenkinsci/cucumber-reports-plugin 
* https://plugins.jenkins.io/cucumber-reports/

To setup this plugin in `jenkins` following [blog](https://medium.com/faun/karate-cucumber-reports-integration-in-jenkins-3f0e617c8265) can also be looked at.

##KarateMock
This project uses karate mock for mocking karate api. .jar file is placed under mock directory. 
To Start the mock server:
java -jar karate-0.9.3.jar -m mock.feature -p <portnumber>








