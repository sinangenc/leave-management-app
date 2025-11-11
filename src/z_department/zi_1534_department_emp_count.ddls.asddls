@AccessControl.authorizationCheck: #MANDATORY
@EndUserText.label: 'View for Department Employee Count'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_1534_DEPARTMENT_EMP_COUNT as select from z1534_employee
{
    department_id,
    count( * ) as EmployeeCount
} group by department_id
