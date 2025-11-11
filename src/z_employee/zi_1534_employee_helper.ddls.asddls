@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: false
@EndUserText.label: 'Value Helper View for Employee'
//@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_1534_EMPLOYEE_HELPER as select from ZR_1534_EMPLOYEE
{
    key EmployeeID,
    concat_with_space(FirstName, LastName, 1) as EmployeeName
}
