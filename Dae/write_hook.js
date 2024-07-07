function(ctx, callback) {


    // Get the roles from the current user's metadata.
    var roles = ctx.request.user.app_metadata && ctx.request.user.app_metadata.roles;
    if (!roles || !roles.length) {
     return callback(new Error('The current user does not have any roles assigned.'));
    }
   
    var roleToDepartmentMap = {
      'Finance Admin': 'finance',
      'IT Admin': 'IT',
      'HR Admin': 'HR',
      'client1 Admin': 'client1',
      'client2 Admin': 'client2'
     };
     
    var adminDepartment;
    for (var i = 0; i < roles.length; i++) {
     var role = roles[i];
     if (roleToDepartmentMap[role]) {
      adminDepartment = roleToDepartmentMap[role];
      break;
     }
    }
   
    if (!adminDepartment) {
     adminDepartment = ""
    }
    var connection = "";
    switch (adminDepartment){
    case 'client1' :
     connection =  'customer-client1';
     break;
    case 'client2' :
     connection =  'customer-client2';
     break;  
    default :
     connection =  'SADA-users';
    }
   
     
    var newProfile = {
      email: ctx.payload.email,
      username : ctx.payload.username,
      password: ctx.payload.password,
      connection: connection,
      user_metadata: {
        departement: adminDepartment || ctx.payload.departement
       }
      };
   
    if (ctx.method === 'update') {
      // If updating, only set the fields we need to send
     Object.keys(newProfile).forEach(function(key) {
        if (newProfile[key] === ctx.request.originalUser[key]) delete newProfile[key];
       });
    }
  
  
    // This is the payload that will be sent to API v2. You have full control over how the user is created in API v2.
    return callback(null, newProfile);
}
  