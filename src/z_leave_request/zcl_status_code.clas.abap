CLASS zcl_status_code DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_exit .
    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_status_code IMPLEMENTATION.

   METHOD if_sadl_exit_calc_element_read~calculate.
    DATA(lv_today) = cl_abap_context_info=>get_system_date( ).

    DATA lt_original_data TYPE STANDARD TABLE OF zc_1534_leave_rqst WITH DEFAULT KEY.
    lt_original_data = CORRESPONDING #( it_original_data ).


*    0 - Neutral
*    1 - Negative (red)
*    2 - Critical (orange)
*    3 - Positive (green)


    LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_original_data>).
      IF <fs_original_data>-Status = 'Pending'.
        <fs_original_data>-StatusCode =  '2'.
      ELSEIF <fs_original_data>-Status = 'Approved'.
        <fs_original_data>-StatusCode =  '3'.
      ELSEIF <fs_original_data>-Status = 'Approved'.
        <fs_original_data>-StatusCode =  '1'.
      ELSE.
        <fs_original_data>-StatusCode =  '0'.
      ENDIF.
    ENDLOOP.


    ct_calculated_data = CORRESPONDING #(  lt_original_data ).

  ENDMETHOD.






  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
  ENDMETHOD.
ENDCLASS.
