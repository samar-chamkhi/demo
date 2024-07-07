function(ctx, callback) {
    var department = ctx.request.user.app_metadata && ctx.request.user.app_metadata.department;
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
     return callback(null, {connections: [ 'customer-client1']});
    case 'client2' :
     return callback(null, {connections: [ 'customer-client2']});
    default :
     return callback(null, {connections: [ 'SADA-users']});
    }
}
  