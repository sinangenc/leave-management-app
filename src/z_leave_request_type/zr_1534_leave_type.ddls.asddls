@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_1534_LEAVE_TYPE
  as select from z1534_leave_type as LeaveType
{
  key leave_type_id as LeaveTypeID,
  leave_type_name as LeaveTypeName,
  requires_approval as RequiresApproval,  
  max_days_per_year as MaxDaysPerYear,
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
