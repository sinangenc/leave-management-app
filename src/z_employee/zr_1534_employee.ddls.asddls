@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'

define root view entity ZR_1534_EMPLOYEE
  as select from z1534_employee as Employee
  association[1..1] to ZR_1534_DEPARTMENT as _Department on $projection.DepartmentID = _Department.DepartmentID
{
  key employee_id as EmployeeID,
  first_name as FirstName,
  last_name as LastName,
  email as Email,
  job_title as JobTitle,
  hire_date as HireDate,
  user_technical_name as UserTechnicalName,
  department_id as DepartmentID,
  _Department,
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
