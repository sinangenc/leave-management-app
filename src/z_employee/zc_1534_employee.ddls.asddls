@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: 'Employee Details'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_1534_EMPLOYEE
  provider contract transactional_query
  as projection on ZR_1534_EMPLOYEE
  association [0..*] to ZC_1534_LEAVE_RQST as _LeaveRequest on $projection.EmployeeID = _LeaveRequest.EmployeeID
  association [1..1] to ZR_1534_EMPLOYEE as _BaseEntity on $projection.EmployeeID = _BaseEntity.EmployeeID
{
  key EmployeeID,
  FirstName,
  LastName,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_EMPLOYEE_FULL_NAME' 
  virtual FullName : abap.string,
  Email,
  JobTitle,
  HireDate,
  @Consumption.valueHelpDefinition:
  [{
    entity :{
       name    : 'ZR_1534_DEPARTMENT_VH',
       element : 'DepartmentID'
      },
      label  : 'Department',
      useForValidation: true
  }]

  @ObjectModel: {
      text: {
          element: [ 'DepartmentName' ]        
       }
  }
  @UI.textArrangement: #TEXT_ONLY
  DepartmentID,
  _Department.DepartmentName as DepartmentName,
  
  @Semantics: {
    user.createdBy: true
  }
  LocalCreatedBy,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  LocalCreatedAt,
  @Semantics: {
    user.localInstanceLastChangedBy: true
  }
  LocalLastchangedBy,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  LocalLastchangedAt,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  LastChangedAt,
  _LeaveRequest,
  _BaseEntity
}
