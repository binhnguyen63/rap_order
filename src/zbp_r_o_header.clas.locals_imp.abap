CLASS lsc_zr_o_header DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS adjust_numbers REDEFINITION.

ENDCLASS.

CLASS lsc_zr_o_header IMPLEMENTATION.

  METHOD adjust_numbers.
    IF mapped-zr_o_header IS NOT INITIAL.
        SELECT SINGLE MAX( order_number )
        FROM zsac_o_header
        INTO @DATA(lv_latest_order_number).
        IF lv_latest_order_number IS INITIAL.
            lv_latest_order_number = '1000000000'.
        ENDIF.
        LOOP AT mapped-zr_o_header REFERENCE INTO DATA(lr_o_header).
            lr_o_header->OrderNumber = lv_latest_order_number + 1.
        ENDLOOP.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

CLASS lhc_ZR_O_HEADER DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_o_header RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zr_o_header RESULT result.

ENDCLASS.

CLASS lhc_ZR_O_HEADER IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

ENDCLASS.
