CLASS LHC_ZR_1534_LEAVE_RQST DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR LeaveRequest
        RESULT result,
      validateNotEmptyFields FOR VALIDATE ON SAVE
            IMPORTING keys FOR LeaveRequest~validateNotEmptyFields,
      setRequestDate FOR DETERMINE ON SAVE
            IMPORTING keys FOR LeaveRequest~setRequestDate,
      determineStatus FOR DETERMINE ON MODIFY
            IMPORTING keys FOR LeaveRequest~determineStatus,
      approveLeaveRequest FOR MODIFY
            IMPORTING keys FOR ACTION LeaveRequest~approveLeaveRequest RESULT result,
      get_instance_features FOR INSTANCE FEATURES
            IMPORTING keys REQUEST requested_features FOR LeaveRequest RESULT result,
      rejectLeaveRequest FOR MODIFY
            IMPORTING keys FOR ACTION LeaveRequest~rejectLeaveRequest RESULT result,
      validateOverlappingLeave FOR VALIDATE ON SAVE
            IMPORTING keys FOR LeaveRequest~validateOverlappingLeave,
      validateMaxDaysPerYear FOR VALIDATE ON SAVE
            IMPORTING keys FOR LeaveRequest~validateMaxDaysPerYear.
ENDCLASS.

CLASS LHC_ZR_1534_LEAVE_RQST IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD validateNotEmptyFields.

      READ ENTITIES OF zr_1534_leave_rqst IN LOCAL MODE
        ENTITY LeaveRequest
        FIELDS ( EmployeeID LeaveTypeID StartDate EndDate )
        WITH CORRESPONDING #( keys )
        RESULT DATA(leave_requests).

        LOOP AT leave_requests INTO DATA(leave_request).
            " Employee Id
            IF leave_request-EmployeeID IS INITIAL.

                APPEND VALUE #( %tky = leave_request-%tky ) TO failed-leaverequest.

                APPEND VALUE #( %tky                = leave_request-%tky
                                %state_area         = 'VALIDATE_LEAVEREQUEST'
                                %msg                = me->new_message(
                                                      id       = 'ZR_1534_LEAVE_RQST'
                                                      number   = '000'
                                                      severity = ms-error )
                                %element-EmployeeID = if_abap_behv=>mk-on
                              ) TO reported-leaverequest.

            ENDIF.


            " Leave Type
            IF leave_request-LeaveTypeID IS INITIAL.

                APPEND VALUE #( %tky = leave_request-%tky ) TO failed-leaverequest.

                APPEND VALUE #( %tky                = leave_request-%tky
                                %state_area         = 'VALIDATE_LEAVEREQUEST'
                                %msg                = me->new_message(
                                                      id       = 'ZR_1534_LEAVE_RQST'
                                                      number   = '001'
                                                      severity = ms-error )
                                %element-LeaveTypeID = if_abap_behv=>mk-on
                              ) TO reported-leaverequest.

            ENDIF.


            " Start Date
            IF leave_request-StartDate IS INITIAL.

                APPEND VALUE #( %tky = leave_request-%tky ) TO failed-leaverequest.

                APPEND VALUE #( %tky                = leave_request-%tky
                                %state_area         = 'VALIDATE_LEAVEREQUEST'
                                %msg                = me->new_message(
                                                      id       = 'ZR_1534_LEAVE_RQST'
                                                      number   = '002'
                                                      severity = ms-error )
                                %element-StartDate = if_abap_behv=>mk-on
                              ) TO reported-leaverequest.

            ENDIF.


            " End Date
            IF leave_request-EndDate IS INITIAL.

                APPEND VALUE #( %tky = leave_request-%tky ) TO failed-leaverequest.

                APPEND VALUE #( %tky                = leave_request-%tky
                                %state_area         = 'VALIDATE_LEAVEREQUEST'
                                %msg                = me->new_message(
                                                      id       = 'ZR_1534_LEAVE_RQST'
                                                      number   = '003'
                                                      severity = ms-error )
                                %element-EndDate = if_abap_behv=>mk-on
                              ) TO reported-leaverequest.

            ENDIF.


            " EndDate >= StartDate
            IF leave_request-StartDate IS NOT INITIAL
               AND leave_request-EndDate IS NOT INITIAL
               AND leave_request-StartDate > leave_request-EndDate.

                APPEND VALUE #( %tky = leave_request-%tky ) TO failed-leaverequest.

                APPEND VALUE #( %tky                = leave_request-%tky
                                %state_area         = 'VALIDATE_LEAVEREQUEST'
                                %msg                = me->new_message(
                                                      id       = 'ZR_1534_LEAVE_RQST'
                                                      number   = '004'
                                                      severity = ms-error )
                                %element-StartDate = if_abap_behv=>mk-on
                                %element-EndDate = if_abap_behv=>mk-on
                              ) TO reported-leaverequest.

            ENDIF.


        ENDLOOP.

  ENDMETHOD.




  METHOD setRequestDate.

    READ ENTITIES OF zr_1534_leave_rqst IN LOCAL MODE
        ENTITY LeaveRequest
        FIELDS ( RequestDate )
        WITH CORRESPONDING #( keys )
        RESULT DATA(leave_requests).

    "LOOP AT leave_requests INTO DATA(leave_request).
    "    leave_request-RequestDate = cl_abap_context_info=>get_system_date( ).
    "ENDLOOP.

    MODIFY ENTITIES OF zr_1534_leave_rqst IN LOCAL MODE
    ENTITY LeaveRequest
    UPDATE FIELDS ( RequestDate )
    WITH VALUE #(
      FOR lev_req IN leave_requests
      ( %tky = lev_req-%tky
        RequestDate = cl_abap_context_info=>get_system_date( ) )
        "RequestDate = lev_req-RequestDate   //solution with loop
    )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).

  ENDMETHOD.

  METHOD determineStatus.

    READ ENTITIES OF zr_1534_leave_rqst IN LOCAL MODE
      ENTITY LeaveRequest
      FIELDS ( LeaveTypeID Status )
      WITH CORRESPONDING #( keys )
      RESULT DATA(leave_requests).

    IF leave_requests IS INITIAL.
      RETURN.
    ENDIF.

    " Get RequiresApproval info for each req_type
    SELECT leave_type_id, requires_approval
      FROM z1534_leave_type
      FOR ALL ENTRIES IN @leave_requests
      WHERE leave_type_id = @leave_requests-LeaveTypeID
      INTO TABLE @DATA(lt_types).

    IF lt_types IS INITIAL.
      RETURN.
    ENDIF.

    " Determine status based on req_type
    LOOP AT leave_requests ASSIGNING FIELD-SYMBOL(<lr>).

      READ TABLE lt_types INTO DATA(ls_type)
        WITH KEY leave_type_id = <lr>-LeaveTypeID.

      IF sy-subrc = 0.
        IF ls_type-requires_approval = abap_true.
          <lr>-Status = 'Pending'.
        ELSE.
          <lr>-Status = 'Approved'.
        ENDIF.
      ENDIF.

    ENDLOOP.


    MODIFY ENTITIES OF zr_1534_leave_rqst IN LOCAL MODE
      ENTITY LeaveRequest
      UPDATE FIELDS ( Status )
      WITH VALUE #(
        FOR lr IN leave_requests
        ( %tky = lr-%tky
          Status = lr-Status )
      )
      REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).

  ENDMETHOD.

  METHOD approveLeaveRequest.

      READ ENTITIES OF zr_1534_leave_rqst IN LOCAL MODE
        ENTITY LeaveRequest
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
        RESULT DATA(leave_requests).

      LOOP AT leave_requests INTO DATA(lv_req).

        " Approve only pending leave requests
        IF lv_req-Status = 'Pending'.

          MODIFY ENTITIES OF zr_1534_leave_rqst IN LOCAL MODE
            ENTITY LeaveRequest
            UPDATE FIELDS ( Status ApprovedBy ApprovedAt ) "UPDATE SET FIELDS
            WITH VALUE #(
              ( %tky       = lv_req-%tky
                Status     = 'Approved'
                "ApprovedBy = cl_abap_context_info=>get_user( )
                ApprovedBy = cl_abap_context_info=>get_user_technical_name(  )
                ApprovedAt = cl_abap_context_info=>get_system_date( ) )
            )
            REPORTED DATA(update_reported).

            APPEND VALUE #(
                %tky        = lv_req-%tky
                %state_area = 'ACTION_APPROVE'
                %msg        = me->new_message(
                             id       = 'ZR_1534_LEAVE_RQST'
                             number   = '001'
                             severity = if_abap_behv_message=>severity-success )
            ) TO reported-leaverequest.

        ENDIF.

      ENDLOOP.

      reported = CORRESPONDING #( DEEP update_reported ).

      " Read changed data for action result
      READ ENTITIES OF zr_1534_leave_rqst IN LOCAL MODE
      ENTITY LeaveRequest
      ALL FIELDS WITH
      CORRESPONDING #( keys )
      RESULT DATA(leave_requests_result).

      result = VALUE #( FOR lv_req_result IN leave_requests_result ( %tky      = lv_req_result-%tky
                                              %param    = lv_req_result ) ).

  ENDMETHOD.

  METHOD rejectLeaveRequest.
      READ ENTITIES OF zr_1534_leave_rqst IN LOCAL MODE
        ENTITY LeaveRequest
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
        RESULT DATA(leave_requests).

      LOOP AT leave_requests INTO DATA(lv_req).

        " Reject only pending leave requests
        IF lv_req-Status = 'Pending'.

          MODIFY ENTITIES OF zr_1534_leave_rqst IN LOCAL MODE
            ENTITY LeaveRequest
            UPDATE FIELDS ( Status ApprovedBy ApprovedAt )
            WITH VALUE #(
              ( %tky       = lv_req-%tky
                Status     = 'Rejected'
                ApprovedBy = cl_abap_context_info=>get_user_technical_name(  )
                ApprovedAt = cl_abap_context_info=>get_system_date( ) )
            )
            REPORTED DATA(update_reported).

        ENDIF.

      ENDLOOP.

      reported = CORRESPONDING #( DEEP update_reported ).

      " Read changed data for action result
      READ ENTITIES OF zr_1534_leave_rqst IN LOCAL MODE
      ENTITY LeaveRequest
      ALL FIELDS WITH
      CORRESPONDING #( keys )
      RESULT DATA(leave_requests_result).

      result = VALUE #( FOR lv_req_result IN leave_requests_result ( %tky      = lv_req_result-%tky
                                              %param    = lv_req_result ) ).
  ENDMETHOD.

  METHOD get_instance_features.

    READ ENTITIES OF zr_1534_leave_rqst IN LOCAL MODE
      ENTITY LeaveRequest
      FIELDS (  LeaveRequestID Status )
      WITH CORRESPONDING #( keys )
      RESULT DATA(leave_requests)
      FAILED failed.


    result = VALUE #( FOR lv_req IN leave_requests
                       ( %tky                           = lv_req-%tky
                         %features-%action-approveLeaveRequest = COND #( WHEN lv_req-Status <> 'Approved'
                                                                  THEN if_abap_behv=>fc-o-enabled ELSE if_abap_behv=>fc-o-disabled  )
                         %features-%action-rejectLeaveRequest = COND #( WHEN lv_req-Status = 'Pending'
                                                                  THEN if_abap_behv=>fc-o-enabled ELSE if_abap_behv=>fc-o-disabled  )
                         %features-%action-Edit = COND #( WHEN lv_req-Status <> 'Approved'
                                                                  THEN if_abap_behv=>fc-o-enabled ELSE if_abap_behv=>fc-o-disabled  )
                      ) ).


  ENDMETHOD.

  METHOD validateOverlappingLeave.

    READ ENTITIES OF zr_1534_leave_rqst IN LOCAL MODE
      ENTITY LeaveRequest
      FIELDS ( EmployeeID StartDate EndDate )
      WITH CORRESPONDING #( keys )
      RESULT DATA(leave_requests).

	LOOP AT leave_requests INTO DATA(lv_req).

      " If required fields not yet filled, overlapping-check impossible
      IF lv_req-EmployeeID IS INITIAL OR
         lv_req-StartDate IS INITIAL OR
         lv_req-EndDate   IS INITIAL.
        CONTINUE.
      ENDIF.

      " Overlapping check
      SELECT leave_request_id, start_date, end_date
      FROM z1534_leave_rqst AS db
      WHERE db~employee_id = @lv_req-EmployeeID
      AND db~leave_request_id <> @lv_req-LeaveRequestID
      AND (
        ( @lv_req-StartDate BETWEEN db~start_date AND db~end_date )
        OR ( @lv_req-EndDate BETWEEN db~start_date AND db~end_date )
        OR ( db~start_date BETWEEN @lv_req-StartDate AND @lv_req-EndDate )
      )
      INTO TABLE @DATA(overlaps).


      IF overlaps IS NOT INITIAL.

        APPEND VALUE #( %tky = lv_req-%tky ) TO failed-leaverequest.

        APPEND VALUE #(
          %tky        = lv_req-%tky
          %state_area = 'VALIDATE_OVERLAP'
          %msg        = me->new_message(
                           id       = 'ZR_1534_LEAVE_RQST'
                           number   = '005'
                           severity = if_abap_behv_message=>severity-error
                         )
          %element-StartDate = if_abap_behv=>mk-on
          %element-EndDate   = if_abap_behv=>mk-on
        ) TO reported-leaverequest.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD validateMaxDaysPerYear.

    READ ENTITIES OF zr_1534_leave_rqst IN LOCAL MODE
      ENTITY LeaveRequest
      FIELDS ( EmployeeID LeaveTypeID StartDate EndDate )
      WITH CORRESPONDING #( keys )
      RESULT DATA(leave_requests).

    IF leave_requests IS INITIAL.
      RETURN.
    ENDIF.

    "get max days of leave types
    SELECT leave_type_id, max_days_per_year
      FROM z1534_leave_type
      FOR ALL ENTRIES IN @leave_requests
      WHERE leave_type_id = @leave_requests-LeaveTypeID
      INTO TABLE @DATA(lt_leave_types).

      LOOP AT leave_requests INTO DATA(lv_req).

        " skip empty records
        IF lv_req-EmployeeID IS INITIAL
           OR lv_req-LeaveTypeID IS INITIAL
           OR lv_req-StartDate IS INITIAL
           OR lv_req-EndDate IS INITIAL.
          CONTINUE.
        ENDIF.

        READ TABLE lt_leave_types INTO DATA(ls_type)
          WITH KEY leave_type_id = lv_req-LeaveTypeID.

        IF sy-subrc <> 0 OR ls_type-max_days_per_year = 0.
          " unlimited
          CONTINUE.
        ENDIF.

        " Days of current leave req.
        DATA(days_requested) = lv_req-EndDate - lv_req-StartDate + 1.

        " Active year
        DATA(lv_year) = lv_req-StartDate(4).

        SELECT SUM( DAYS_BETWEEN( start_date, end_date ) + 1 ) AS total_days
          FROM z1534_leave_rqst AS db
          WHERE db~employee_id  = @lv_req-EmployeeID
            AND db~leave_type_id = @lv_req-LeaveTypeID
            AND db~status IN ('Approved','Pending')
            AND substring( db~start_date, 1, 4 ) = @lv_year
            AND db~leave_request_id <> @lv_req-LeaveRequestID
          INTO @DATA(total_days_prev).

        IF total_days_prev IS INITIAL.
          total_days_prev = 0.
        ENDIF.

        DATA(total_after_new) = total_days_prev + days_requested.

        IF total_after_new > ls_type-max_days_per_year.

          APPEND VALUE #( %tky = lv_req-%tky ) TO failed-leaverequest.

          APPEND VALUE #(
            %tky        = lv_req-%tky
            %state_area = 'VALIDATE_MAXDAYS'
            %msg        = me->new_message(
                             id       = 'ZR_1534_LEAVE_RQST'
                             number   = '006'
                             severity = if_abap_behv_message=>severity-error
                             v1       = |{ ls_type-max_days_per_year }|
                           )
            %element-EndDate = if_abap_behv=>mk-on
            %element-StartDate = if_abap_behv=>mk-on
          ) TO reported-leaverequest.

        ENDIF.

      ENDLOOP.

ENDMETHOD.


ENDCLASS.
