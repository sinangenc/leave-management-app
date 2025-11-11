CLASS zcl_employee_full_name DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_exit .
    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA mv_is_draft TYPE abap_bool VALUE abap_false.
ENDCLASS.



CLASS zcl_employee_full_name IMPLEMENTATION.

   METHOD if_sadl_exit_calc_element_read~calculate.

    DATA lt_original_data TYPE STANDARD TABLE OF zc_1534_employee WITH DEFAULT KEY.
    lt_original_data = CORRESPONDING #( it_original_data ).


    LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_original_data>).
        <fs_original_data>-FullName =  <fs_original_data>-FirstName && | | && <fs_original_data>-LastName.
    ENDLOOP.


    ct_calculated_data = CORRESPONDING #(  lt_original_data ).

  ENDMETHOD.



  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
  ENDMETHOD.

ENDCLASS.
