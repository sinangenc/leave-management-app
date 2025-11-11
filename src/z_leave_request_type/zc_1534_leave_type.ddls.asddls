@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: 'Leave Type Details'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_1534_LEAVE_TYPE
  provider contract transactional_query
  as projection on ZR_1534_LEAVE_TYPE
  association [1..1] to ZR_1534_LEAVE_TYPE as _BaseEntity on $projection.LeaveTypeID = _BaseEntity.LeaveTypeID
{
  key LeaveTypeID,
  LeaveTypeName,
  RequiresApproval,
  MaxDaysPerYear,
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
  _BaseEntity
}
