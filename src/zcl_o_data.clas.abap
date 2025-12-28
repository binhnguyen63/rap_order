CLASS zcl_o_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.

  METHODS: generate_o_header
  importing headersNum TYPE i,
  generate_o_item,
  generate_o_history,
  generate_o_account.

ENDCLASS.



CLASS zcl_o_data IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  generate_o_header( 5 ).
  ENDMETHOD.
  METHOD generate_o_account.

  ENDMETHOD.

  METHOD generate_o_header.
  DELETE FROM zsac_o_header.
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
    MODIFY ENTITIES OF ZR_O_HEADER
    ENTITY ZR_O_HEADER
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
