@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_1534_LEAVE_RQST
  as select from z1534_leave_rqst as LeaveRequest
  association [1..1] to ZR_1534_EMPLOYEE as _Employee on $projection.EmployeeID = _Employee.EmployeeID
  association [0..1] to ZI_1534_EMPLOYEE_HELPER as _EmployeeText on $projection.EmployeeID= _EmployeeText.EmployeeID
  association [0..1] to ZR_1534_LEAVE_TYPE_VH as _LeaveTypeText on $projection.LeaveTypeID= _LeaveTypeText.LeaveTypeID
  association [0..1] to ZI_1534_EMPLOYEE_HELPER as _Reviewer on $projection.ApprovedBy = _Reviewer.UserTechnicalName
{
  key leave_request_id as LeaveRequestID,
  employee_id as EmployeeID,
//  _EmployeeText.EmployeeName as EmployeeFullName,
  leave_type_id as LeaveTypeID,
  start_date as StartDate,
  end_date as EndDate,
  status as Status,
  request_date as RequestDate,
  approved_by as ApprovedBy,
  approved_at as ApprovedAt,
  _Employee,
  _EmployeeText,
  _LeaveTypeText,
  _Reviewer,
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
