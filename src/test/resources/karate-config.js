function fn() {
 var env = karate.env;

 if (!env) {
         env = 'mock'; //
       }

    var config = {
        baseUrl: karate.properties['tradingrepublic.base.url'],
        randomUUID: function() {
            return java.util.UUID.randomUUID();
        },
        getEndpoint: function (region) {

             if (region === 'wss' ) {
                return 'wss://api.staging.neontrading.com';
            } else if(region == 'restapi' && baseUrl.includes('staging')){
                return 'https://api.staging.neontrading.com/api/v1/';
            } else if(region == 'restapi' && baseUrl.includes('staging')){
                return 'https://api.staging.neontrading.com/api/v1/';
            }else  if(env=='mock')
                              {
                              return 'http://localhost:8181/'
                              }

            else{
             return '';
            }
        },
        replaceTextInFile: function (args) {
            var TestUtils = Java.type('karate.TestUtils');
            print(args.filePath + ", " + args.toBeReplaced + ", " + args.replaceWith);
            return TestUtils.replace(args.filePath, args.toBeReplaced, args.replaceWith);
        }
    };

    return config;
}