CLASS LHC_ZR_1534_EMPLOYEE DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR Employee
        RESULT result,
      validateNotEmptyFields FOR VALIDATE ON SAVE
            IMPORTING keys FOR Employee~validateNotEmptyFields.
ENDCLASS.

CLASS LHC_ZR_1534_EMPLOYEE IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.

  METHOD validateNotEmptyFields.

      READ ENTITIES OF zr_1534_employee IN LOCAL MODE
        ENTITY Employee
        FIELDS ( FirstName LastName Email JobTitle DepartmentID HireDate )
        WITH CORRESPONDING #( keys )
        RESULT DATA(employees).

        LOOP AT employees INTO DATA(employee).
            " First Name
            IF employee-FirstName IS INITIAL.

                APPEND VALUE #( %tky = employee-%tky ) TO failed-employee.

                APPEND VALUE #( %tky                = employee-%tky
                                %state_area         = 'VALIDATE_EMPLOYEE'
                                %msg                = me->new_message(
                                                      id       = 'ZR_1534_EMPLOYEE'
                                                      number   = '000'
                                                      severity = ms-error )
                                %element-FirstName = if_abap_behv=>mk-on
                              ) TO reported-employee.

            ENDIF.


            " Last Name
            IF employee-LastName IS INITIAL.

                APPEND VALUE #( %tky = employee-%tky ) TO failed-employee.

                APPEND VALUE #( %tky                = employee-%tky
                                %state_area         = 'VALIDATE_EMPLOYEE'
                                %msg                = me->new_message(
                                                      id       = 'ZR_1534_EMPLOYEE'
                                                      number   = '001'
                                                      severity = ms-error )
                                %element-LastName = if_abap_behv=>mk-on
                              ) TO reported-employee.

            ENDIF.

            " E-mail
            IF employee-Email IS INITIAL.

                APPEND VALUE #( %tky = employee-%tky ) TO failed-employee.

                APPEND VALUE #( %tky                = employee-%tky
                                %state_area         = 'VALIDATE_EMPLOYEE'
                                %msg                = me->new_message(
                                                      id       = 'ZR_1534_EMPLOYEE'
                                                      number   = '002'
                                                      severity = ms-error )
                                %element-Email = if_abap_behv=>mk-on
                              ) TO reported-employee.

            ELSE.

*                FIND REGEX '^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$' IN employee-Email IGNORING CASE.

                IF NOT matches(
                     val   = employee-Email
                     pcre  = '^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$'
                   ).


                    APPEND VALUE #( %tky = employee-%tky ) TO failed-employee.

                    APPEND VALUE #( %tky                = employee-%tky
                                    %state_area         = 'VALIDATE_EMPLOYEE'
                                    %msg                = me->new_message(
                                                          id       = 'ZR_1534_EMPLOYEE'
                                                          number   = '006'
                                                          severity = ms-error )
                                    %element-Email = if_abap_behv=>mk-on
                                  ) TO reported-employee.

                ENDIF.

            ENDIF.

            " Job Title
            IF employee-JobTitle IS INITIAL.

                APPEND VALUE #( %tky = employee-%tky ) TO failed-employee.

                APPEND VALUE #( %tky                = employee-%tky
                                %state_area         = 'VALIDATE_EMPLOYEE'
                                %msg                = me->new_message(
                                                      id       = 'ZR_1534_EMPLOYEE'
                                                      number   = '003'
                                                      severity = ms-error )
                                %element-JobTitle = if_abap_behv=>mk-on
                              ) TO reported-employee.

            ENDIF.

            " Department ID
            IF employee-DepartmentID IS INITIAL.

                APPEND VALUE #( %tky = employee-%tky ) TO failed-employee.

                APPEND VALUE #( %tky                = employee-%tky
                                %state_area         = 'VALIDATE_EMPLOYEE'
                                %msg                = me->new_message(
                                                      id       = 'ZR_1534_EMPLOYEE'
                                                      number   = '004'
                                                      severity = ms-error )
                                %element-DepartmentID = if_abap_behv=>mk-on
                              ) TO reported-employee.

            ENDIF.

            " Hire Date
            IF employee-HireDate IS INITIAL.

                APPEND VALUE #( %tky = employee-%tky ) TO failed-employee.

                APPEND VALUE #( %tky                = employee-%tky
                                %state_area         = 'VALIDATE_EMPLOYEE'
                                %msg                = me->new_message(
                                                      id       = 'ZR_1534_EMPLOYEE'
                                                      number   = '005'
                                                      severity = ms-error )
                                %element-HireDate = if_abap_behv=>mk-on
                              ) TO reported-employee.

            ENDIF.


        ENDLOOP.

  ENDMETHOD.

ENDCLASS.
