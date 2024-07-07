function(ctx, callback) {
 
    //ctx.log('-----------Logging action roles:', roles);
    var roles = ctx.request.user.app_metadata && ctx.request.user.app_metadata.roles;
    if (!roles || !roles.length) {
     return callback(new Error('The current user does not have any roles assigned.'));
    }
  
  
    // Map roles to departments.
    var roleToDepartmentMap = {
      'Finance Admin': 'finance',
      'IT Admin': 'IT',
      'HR Admin': 'HR',
      'client1 Admin': 'client1',
      'client2 Admin': 'client2',
      'Delegated Admin - Administrator': 'global',
      'Delegated Admin - Auditor': 'global',
     };
  
  
    // Determine the user's department.
    var department;
    for (var i = 0; i < roles.length; i++) {
     var role = roles[i];
     if (roleToDepartmentMap[role]) {
      department = roleToDepartmentMap[role];
      break;
     }
    }
  
  
    if (!department) {
     return callback(new Error('The current user does not have a valid department role assigned.'));
    }
  
  
    // Allow users with the 'global' department to see all users.
    if (department === 'global') {
     return callback();
    }
   
    return callback(null, 'user_metadata.departement:"' + department + '"');
}
  