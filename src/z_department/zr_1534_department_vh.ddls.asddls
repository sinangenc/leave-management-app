@AccessControl.authorizationCheck: #MANDATORY
@EndUserText.label: 'Value Helper View for Department'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZR_1534_DEPARTMENT_VH as select from ZR_1534_DEPARTMENT
{
    @UI.hidden: true
    key DepartmentID,
    DepartmentName
}
