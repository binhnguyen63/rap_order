CLASS lhc_zi_o_item DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS calculateItemValue FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZI_O_ITEM~calculateItemValue.

ENDCLASS.

CLASS lhc_zi_o_item IMPLEMENTATION.

  METHOD calculateItemValue.
  DATA totalValue TYPE zr_o_header-TotalValue VALUE 0.

  READ ENTITIES OF zr_o_header IN LOCAL MODE
  ENTITY zi_o_item
  FIELDS ( Quantity NetPrice ItemValue )
  WITH CORRESPONDING #( keys )
  RESULT DATA(items).


  LOOP AT items ASSIGNING FIELD-SYMBOL(<item>).
    <item>-ItemValue = <item>-Quantity * <item>-NetPrice.
  ENDLOOP.

  MODIFY ENTITIES OF zr_o_header IN LOCAL MODE
  ENTITY zi_o_item
  UPDATE FIELDS ( ItemValue )
  WITH VALUE #(
    FOR item IN items (
        %tky = item-%tky
        ItemValue = item-ItemValue
     )
    ).

*  TYPES: BEGIN OF header_keys_type,
*            OrderNumber TYPE ebeln,
*        END OF header_keys_type.
*
*
*  DATA header_keys TYPE SORTED TABLE OF header_keys_type WITH UNIQUE KEY OrderNumber.
*
*  LOOP AT keys ASSIGNING FIELD-SYMBOL(<key>).
*    APPEND VALUE #(
*
*        OrderNumber = <key>-OrderNumber
*      ) TO header_keys.
*  ENDLOOP.

 TYPES: BEGIN OF item_keys_type,
            OrderNumber TYPE ebeln,
        END OF item_KEYS_TYPE.

DATA item_keys TYPE TABLE OF item_keys_type.
LOOP AT keys ASSIGNING FIELD-SYMBOL(<k>).
    APPEND VALUE #( OrderNumber = <k>-OrderNumber ) TO item_keys.
ENDLOOP.

*  READ ENTITIES OF zr_o_header IN LOCAL MODE
*  ENTITY zi_o_item
*  ALL FIELDS
**  WITH VALUE #( ( %key-OrderNumber = keys[ 1 ]-OrderNumber ) )
*WITH CORRESPONDING #( item_keys )
*  RESULT DATA(itemsValue).

  READ ENTITIES OF zr_o_header IN LOCAL MODE
  ENTITY zr_o_header
    BY \_Item
    ALL FIELDS
    WITH CORRESPONDING #( item_keys )
    RESULT DATA(itemsValue).

  LOOP AT itemsValue ASSIGNING FIELD-SYMBOL(<itemValue>).
    totalValue += <itemValue>-ItemValue.
  ENDLOOP.


  MODIFY ENTITIES OF zr_o_header IN LOCAL MODE
  ENTITY zr_o_header
  UPDATE FIELDS ( TotalValue )
  WITH VALUE #( FOR k IN keys (

    %key-OrderNumber = k-OrderNumber
    TotalValue = totalValue
   ) ).


*  LOOP AT headers ASSIGNING FIELD-SYMBOL(<header>).
*    <header>-TotalValue = totalValue.
*  ENDLOOP.



  ENDMETHOD.

ENDCLASS.

CLASS lsc_zr_o_header DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS adjust_numbers REDEFINITION.

ENDCLASS.

CLASS lsc_zr_o_header IMPLEMENTATION.

  METHOD adjust_numbers.
    DATA lv_order_number TYPE ebeln.
    DATA lv_item_number TYPE n LENGTH 5.
    IF mapped-zr_o_header IS NOT INITIAL.
        SELECT SINGLE MAX( order_number )
        FROM zsac_o_header
        INTO @DATA(lv_latest_order_number).
        IF lv_latest_order_number IS INITIAL.
            lv_latest_order_number = '1000000000'.
        ENDIF.
        LOOP AT mapped-zr_o_header REFERENCE INTO DATA(lr_o_header).
            lr_o_header->OrderNumber = |{ lv_latest_order_number + 1 }|.
        ENDLOOP.
    ENDIF.

    IF mapped-zi_o_item IS NOT INITIAL.
        IF mapped-zr_o_header IS NOT INITIAL.
*            Brand new header
            lv_order_number = mapped-zr_o_header[ 1 ]-OrderNumber.
        ELSE.
*            Header already exist
            lv_order_number = mapped-zi_o_item[ 1 ]-%tmp-OrderNumber.
        ENDIF.

        SELECT SINGLE MAX( item_number )
        FROM zsac_o_item
        INTO @DATA(lv_latest_item_number).

        IF lv_latest_item_number IS INITIAL.
            lv_latest_item_number = '10000'.
        ENDIF.

        LOOP AT mapped-zi_o_item REFERENCE INTO DATA(lr_o_item).
            lr_o_item->OrderNumber = |{ lv_order_number }|.
            lr_o_item->ItemNumber = |{ lv_latest_item_number + 1 }|.
        ENDLOOP.

    ENDIF.
    IF mapped-zi_o_history IS NOT INITIAL.
*    Header and Item already exist
        IF mapped-zi_o_history[ 1 ]-%tmp-ItemNumber IS NOT INITIAL.
        lv_order_number = mapped-zi_o_history[ 1 ]-%tmp-OrderNumber.
        lv_item_number = mapped-zi_o_history[ 1 ]-%tmp-ItemNumber.
*        Header exist but Item does not
        ELSEIF mapped-zi_o_history[ 1 ]-%tmp-OrderNumber IS NOT INITIAL.
        lv_order_number = mapped-zi_o_history[ 1 ]-%tmp-OrderNumber.
        lv_item_number = mapped-zi_o_item[ 1 ]-ItemNumber.
        ELSE.
        lv_item_number = mapped-zi_o_item[ 1 ]-ItemNumber.
        lv_order_number = mapped-zr_o_header[ 1 ]-OrderNumber.
        ENDIF.

        SELECT SINGLE MAX( hist_id )
        FROM zsac_o_history
        INTO @DATA(lv_latest_hist_id).

        IF lv_latest_hist_id IS INITIAL.
            lv_latest_hist_id = '100000'.
        ENDIF.

        LOOP AT mapped-zi_o_history REFERENCE INTO DATA(lr_o_history).
        lr_o_history->OrderNumber = |{ lv_order_number }|.
        lr_o_history->ItemNumber = |{ lv_item_number }|.
        lr_o_history->HistId = |{ lv_latest_hist_id + 1 }|.
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
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zr_o_header RESULT result.

    METHODS approve FOR MODIFY
      IMPORTING keys FOR ACTION zr_o_header~approve RESULT result.

ENDCLASS.

CLASS lhc_ZR_O_HEADER IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD get_instance_features.

    READ ENTITIES OF zr_o_header IN LOCAL MODE
    ENTITY zr_o_header
    FIELDS ( status )
    WITH CORRESPONDING #( keys )
    RESULT DATA(chosen_row).

    LOOP AT chosen_row ASSIGNING FIELD-SYMBOL(<row>).
        APPEND VALUE #(
            %tky = <row>-%tky
            %action-approve = COND #( WHEN <row>-Status = 'A' THEN if_abap_behv=>fc-o-disabled ELSE if_abap_behv=>fc-o-enabled )
        ) TO result.

    ENDLOOP.

  ENDMETHOD.

  METHOD approve.




    MODIFY ENTITIES OF zr_o_header IN LOCAL MODE
    ENTITY zr_o_header
    UPDATE FIELDS ( status )
    WITH VALUE #(
        FOR key IN keys (
            %tky = key-%tky
            status = 'A'
        )
     ).

    READ ENTITIES OF zr_o_header IN LOCAL MODE
    ENTITY zr_o_header
    FIELDS ( status )
    WITH CORRESPONDING #( keys )
    RESULT DATA(chosen_rows).

    result = VALUE #( FOR row IN chosen_rows (
        %tky = row-%tky
        %param = row
     ) ).

  ENDMETHOD.

ENDCLASS.
