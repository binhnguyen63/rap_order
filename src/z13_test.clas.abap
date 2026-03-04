CLASS z13_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z13_TEST IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA carrier_list    TYPE TABLE OF /dmo/carrier.
    DATA connection_list TYPE TABLE OF /dmo/connection.

    SELECT
      FROM /dmo/connection
      FIELDS *
      INTO TABLE @DATA(connections).

    connection_list = connection_list.

    out->write( connection_list ).

  ENDMETHOD.
ENDCLASS.
