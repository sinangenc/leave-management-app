CLASS LHC_ZR_1534_LEAVE_TYPE DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR LeaveType
        RESULT result,
      leaveTypeNameNotEmpty FOR VALIDATE ON SAVE
            IMPORTING keys FOR LeaveType~leaveTypeNameNotEmpty.
ENDCLASS.

CLASS LHC_ZR_1534_LEAVE_TYPE IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD leaveTypeNameNotEmpty.

    READ ENTITIES OF zr_1534_leave_type IN LOCAL MODE
    ENTITY LeaveType
    FIELDS ( LeaveTypeName )
    WITH CORRESPONDING #( keys )
    RESULT DATA(leave_types).

    LOOP AT leave_types INTO DATA(leave_type).
        IF leave_type-LeaveTypeName IS INITIAL.

            APPEND VALUE #( %tky = leave_type-%tky ) TO failed-leavetype.

            APPEND VALUE #( %tky                = leave_type-%tky
                            %state_area         = 'VALIDATE_LEAVETYPE'
                            %msg                = me->new_message(
                                                  id       = 'ZR_1534_LEAVE_TYPE'
                                                  number   = '000'
                                                  severity = ms-error )
                            %element-LeaveTypeID = if_abap_behv=>mk-on
                          ) TO reported-leavetype.

        ENDIF.
    ENDLOOP.


  ENDMETHOD.

ENDCLASS.
