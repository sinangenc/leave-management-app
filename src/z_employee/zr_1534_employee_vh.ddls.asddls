@AccessControl.authorizationCheck: #MANDATORY
@EndUserText.label: 'Value Helper View for Employee'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZR_1534_EMPLOYEE_VH as select from ZR_1534_EMPLOYEE
{
    @UI.hidden: true
    key EmployeeID,
    FirstName,
    LastName,
    Email
//    _Department
}
