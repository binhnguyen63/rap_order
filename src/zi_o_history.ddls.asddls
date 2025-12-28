@AccessControl.authorizationCheck: #NOT_REQUIRED
 @EndUserText.label: 'interface view item'
define view entity ZI_O_HISTORY as select from zsac_o_history
association to parent ZI_O_ITEM as _Item on $projection.OrderNumber = _Item.OrderNumber and $projection.ItemNumber = _Item.ItemNumber
association [1..1] to ZR_O_HEADER as _Header on  $projection.OrderNumber = _Header.OrderNumber
{
    key item_number as ItemNumber,
    key order_number as OrderNumber,
    key hist_id as HistId,
    movement_type as MovementType,
    posting_date as PostingDate,
    mov_qty as MovQty,
        createdby as Createdby,
    createdat as Createdat,
    lastchangedby as Lastchangedby,
    lastchangedat as Lastchangedat,
    locallastchangedat as Locallastchangedat,
    _Item,
    _Header
}
