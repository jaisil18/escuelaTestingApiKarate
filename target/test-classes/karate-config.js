function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }

  var apiPetStore = 'https://petstore.swagger.io/v2';

  if (env == 'dev') {
    // defaults already set
  } else if (env == 'cert') {
    // customize
  }

  var config = {
    env: env,
    myVarName: 'someValue',
    apiPetStore: apiPetStore
  };

  return config;
}