@AccessControl.authorizationCheck: #MANDATORY
@EndUserText.label: 'Value Helper View for Leave Type'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZR_1534_LEAVE_TYPE_VH as select from ZR_1534_LEAVE_TYPE
{
    @UI.hidden: true
    key LeaveTypeID,
    LeaveTypeName,
    @EndUserText.label: 'Requires Approval'
    RequiresApproval,
    MaxDaysPerYear
}
