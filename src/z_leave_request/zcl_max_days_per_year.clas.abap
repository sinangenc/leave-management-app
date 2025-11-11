CLASS zcl_max_days_per_year DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_exit .
    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_max_days_per_year IMPLEMENTATION.

   METHOD if_sadl_exit_calc_element_read~calculate.

    DATA lt_original_data TYPE STANDARD TABLE OF zc_1534_leave_type WITH DEFAULT KEY.
    lt_original_data = CORRESPONDING #( it_original_data ).



    LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_original_data>).
      IF <fs_original_data>-MaxDaysPerYear = 0.
        <fs_original_data>-MaxDaysPerYearText = '-'.
      ELSE.
        <fs_original_data>-MaxDaysPerYearText = <fs_original_data>-MaxDaysPerYear.
      ENDIF.

    ENDLOOP.


    ct_calculated_data = CORRESPONDING #(  lt_original_data ).

  ENDMETHOD.



  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
  ENDMETHOD.
ENDCLASS.
