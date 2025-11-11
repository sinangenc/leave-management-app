CLASS LHC_ZR_1534_DEPARTMENT DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR Department
        RESULT result,
      validateDepartmentNameNotEmpty FOR VALIDATE ON SAVE
            IMPORTING keys FOR Department~validateDepartmentNameNotEmpty,
      validateManagerUnique FOR VALIDATE ON SAVE
            IMPORTING keys FOR Department~validateManagerUnique.
ENDCLASS.

CLASS LHC_ZR_1534_DEPARTMENT IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.

  METHOD validateDepartmentNameNotEmpty.
      "read relevant department data
      READ ENTITIES OF zr_1534_department IN LOCAL MODE
      ENTITY Department
       FIELDS ( DepartmentName )
       WITH CORRESPONDING #( keys )
      RESULT DATA(departments).

      LOOP AT departments INTO DATA(department).
          IF department-DepartmentName IS INITIAL.
            APPEND VALUE #( %tky = department-%tky ) TO failed-department.

            APPEND VALUE #( %tky                = department-%tky
                            %state_area         = 'VALIDATE_DEPARTMENT'
                            %msg                = me->new_message(
                                                  id       = 'ZR_1534_DEPARTMENT'
                                                  number   = '000'
                                                  severity = ms-error )
                            %element-DepartmentID = if_abap_behv=>mk-on
                          ) TO reported-department.

          ENDIF.
        ENDLOOP.

  ENDMETHOD.

  METHOD validateManagerUnique.
      "read relevant department data
      READ ENTITIES OF zr_1534_department IN LOCAL MODE
      ENTITY Department
       FIELDS ( Manager )
       WITH CORRESPONDING #( keys )
      RESULT DATA(departments).


      LOOP AT departments INTO DATA(department).

        IF department-Manager IS NOT INITIAL.
          " Check if selected employee is already manager of another department
          SELECT SINGLE
            FROM Z1534_DEPARTMENT
            FIELDS manager, department_name
            WHERE manager = @department-Manager
            AND department_id <> @department-DepartmentID
            INTO @DATA(check_result).

          IF check_result IS NOT INITIAL.

            SELECT SINGLE first_name, last_name
            FROM z1534_employee
            WHERE employee_id = @department-Manager
            INTO @DATA(ls_employee).

            APPEND VALUE #( %tky = department-%tky ) TO failed-department.

            APPEND VALUE #( %tky                = department-%tky
                            %state_area         = 'VALIDATE_DEPARTMENT'
                            %msg                = me->new_message(
                                                  id       = 'ZR_1534_DEPARTMENT'
                                                  number   = '001'
                                                  severity = ms-error
                                                  v1 = ls_employee-first_name && | | && ls_employee-last_name
                                                  v2 = check_result-department_name )
                            %element-Manager = if_abap_behv=>mk-on
                          ) TO reported-department.
          ENDIF.
        ENDIF.
      ENDLOOP.

  ENDMETHOD.

ENDCLASS.
