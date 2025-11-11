@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: 'Department Details'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_1534_DEPARTMENT
  provider contract transactional_query
  as projection on ZR_1534_DEPARTMENT
  association[0..*] to ZC_1534_EMPLOYEE as _DepartmentEmployees
    on $projection.DepartmentID = _DepartmentEmployees.DepartmentID
  association [1..1] to ZR_1534_DEPARTMENT as _BaseEntity 
    on $projection.DepartmentID = _BaseEntity.DepartmentID
{
  key DepartmentID,
  DepartmentName,
  @Consumption.valueHelpDefinition:
  [{
    entity :{
       name    : 'ZR_1534_EMPLOYEE_VH', //'ZI_1534_EMPLOYEE_HELPER',
       element : 'EmployeeID'
      },
      label  : 'Manager',
      useForValidation: true
  }]
  @ObjectModel.text.element: ['ManagerFullName']
  @UI.textArrangement: #TEXT_ONLY
  Manager, 
    
//  @Consumption.valueHelpDefinition:
//  [{
//    entity :{
//       name    : 'ZR_1534_DEPARTMENT',
//       element : 'DepartmentID'
//      },
//      label  : 'Parent Department',
//      useForValidation: true
//  }]
//  @ObjectModel.text.element: [ 'ParentDepartmentName' ]
//  @UI.textArrangement: #TEXT_ONLY
//  ParentDepartment,
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
  _BaseEntity,
  _EmployeeText.EmployeeName as ManagerFullName,
  _DepartmentEmployees,
  _EmpCount.EmployeeCount as EmployeeCount
//  _ParentDepartment.DepartmentName as ParentDepartmentName
}
