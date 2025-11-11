@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: 'Leave Request Details'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_1534_LEAVE_RQST
  provider contract transactional_query
  as projection on ZR_1534_LEAVE_RQST
  association [1..1] to ZR_1534_LEAVE_RQST as _BaseEntity on $projection.LeaveRequestID = _BaseEntity.LeaveRequestID
{
  key LeaveRequestID,
  @Consumption.valueHelpDefinition:
  [{
    entity :{
       name    : 'ZR_1534_EMPLOYEE_VH',
       element : 'EmployeeID'
      },
      label  : 'Employee',
      useForValidation: true
  }]
  @ObjectModel.text.element: ['EmployeeFullName']
  @UI.textArrangement: #TEXT_ONLY
  EmployeeID,
  @UI.hidden: true
  _EmployeeText.EmployeeName as EmployeeFullName,
  @Consumption.valueHelpDefinition:
  [{
    entity :{
       name    : 'ZR_1534_LEAVE_TYPE_VH',
       element : 'LeaveTypeID'
      },
      label  : 'Leave Type',
      useForValidation: true
  }]
  @ObjectModel.text.element: ['LeaveTypeName']
  @UI.textArrangement: #TEXT_ONLY
  LeaveTypeID,
  @UI.hidden: true
  _LeaveTypeText.LeaveTypeName as LeaveTypeName, 
  StartDate,
  EndDate,
//  @Consumption.valueHelpDefinition: [{  }]
  Status,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_STATUS_CODE' 
  virtual StatusCode : abap.int2,
  RequestDate,
  ApprovedBy,
  ApprovedAt,
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
