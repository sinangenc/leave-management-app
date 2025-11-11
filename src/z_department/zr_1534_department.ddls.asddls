@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
//@ObjectModel : { resultSet.sizeCategory: #XS }
define root view entity ZR_1534_DEPARTMENT
  as select from z1534_department as Department
  association [0..1] to ZI_1534_DEPARTMENT_EMP_COUNT as _EmpCount
    on $projection.DepartmentID = _EmpCount.department_id
  association [0..1] to ZI_1534_EMPLOYEE_HELPER as _EmployeeText 
    on $projection.Manager= _EmployeeText.EmployeeID
//  association [0..1] to ZR_1534_DEPARTMENT as _ParentDepartment on $projection.ParentDepartment = _ParentDepartment.DepartmentID
{
  key department_id as DepartmentID,
  department_name as DepartmentName,
  manager as Manager,
//  _DepartmentEmployees,
  _EmpCount,
//  parent_department as ParentDepartment,
  _EmployeeText,
//  _ParentDepartment,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_lastchanged_by as LocalLastchangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_lastchanged_at as LocalLastchangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
}
