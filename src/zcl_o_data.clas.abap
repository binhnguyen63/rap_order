CLASS zcl_o_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS: generate_o_header
      IMPORTING headersNum TYPE i,
      generate_o_item,
      generate_o_history,
      generate_o_account.

ENDCLASS.



CLASS ZCL_O_DATA IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    generate_o_header( 1 ).
  ENDMETHOD.


  METHOD generate_o_account.

  ENDMETHOD.


  METHOD generate_o_header.
    DELETE FROM zsac_o_header.
    DELETE FROM zsac_o_item.
    DELETE FROM zsac_o_history.
*  DO headersNum TIMES.
*    DATA(lv_i) = sy-index.
*    DATA headerTable TYPE STANDARD TABLE OF ZSAC_O_HEADER.
*    headerTable = VALUE #( (
*      order_number   = |{ 1000000000 + lv_i }|
*
*      company_code       = '1001'
*      vendor_number      = '1000000000' + lv_i
*      document_date      = cl_abap_context_info=>get_system_date( )
*      status             = COND string( WHEN lv_i mod 2 = 0 THEN 'N' ELSE 'A' )
*      currency           = 'USD'
*      total_value        = '23.23' + lv_i * 10
*     ) ).
*     INSERT zsac_o_header FROM TABLE @headerTable.
*  ENDDO.

    DO headersNum TIMES.
      DATA(lv_i) = sy-index.
      MODIFY ENTITIES OF zr_o_header
      ENTITY zr_o_header
      CREATE FIELDS (     CompanyCode
       VendorNumber
       DocumentDate
      Status
      Currency
       TotalValue  ) WITH VALUE #( (
       %cid                 = 'newHeader01'
          CompanyCode = '1001'
          VendorNumber = '1000000000'
          DocumentDate = cl_abap_context_info=>get_system_date( )
          Status = 'N'
          Currency = 'USD'
          TotalValue = '23.23'
       ) )

       ENTITY zr_o_header
       CREATE BY \_Item FROM VALUE #( (
        %cid_ref = 'newHeader01'
        %target = VALUE #( (
              %cid = 'newItem01'
              Material = 'leather'
              Quantity = '1'
              NetPrice = '5'
              %control = VALUE #(
              Material = if_abap_behv=>mk-on
              Quantity = if_abap_behv=>mk-on
              NetPrice = if_abap_behv=>mk-on
              ItemValue = if_abap_behv=>mk-on

          )
           ) )

        )  )

       ENTITY zi_o_item
       CREATE BY \_History FROM VALUE #( (
            %cid_ref = 'newItem01'
            %target = VALUE #( (
            %cid = 'newHistory01'
             MovementType = 'I'
             PostingDate = cl_abap_context_info=>get_system_date(  )
             MovQty = 12
             %control = VALUE #(
                MovementType = if_abap_behv=>mk-on
             PostingDate = if_abap_behv=>mk-on
             MovQty = if_abap_behv=>mk-on
              )
              ) )
        ) )
       MAPPED DATA(ls_mapped)
       FAILED DATA(ls_failed)
       REPORTED DATA(ls_reported).
      COMMIT ENTITIES.

    ENDDO.

  ENDMETHOD.


  METHOD generate_o_history.

  ENDMETHOD.


  METHOD generate_o_item.

  ENDMETHOD.
ENDCLASS.
