'use strict';
let AWS = require('aws-sdk');
exports.handler = (event, context, callback) => {
  console.log("Hello!\n" + JSON.stringify(event));
  let cognito = new AWS.CognitoIdentityServiceProvider();
  
  const params = {
    GroupName: event.request.clientMetadata.groupName,
    UserPoolId: event.userPoolId, 
    Username: event.userName
  };
  
  cognito.adminAddUserToGroup(params)
    .promise()
    .then(res => callback(null, event))
    .catch(err => callback(err, event)); 
};
