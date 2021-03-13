 function() {
 var env = karate.env;
 var config = {
   env: env,
   HOST: (env == 'https://api-ssl.bitly.com/v4/groups')};
   karate.configure('connectTimeout', 3000);
   karate.configure('readTimeout', 3000);
   return config;
 }