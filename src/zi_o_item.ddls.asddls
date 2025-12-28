@AccessControl.authorizationCheck: #NOT_REQUIRED
 @EndUserText.label: 'interface view item'
define view entity ZI_O_ITEM as select from zsac_o_item
association to parent ZR_O_HEADER as _Header on $projection.OrderNumber = _Header.OrderNumber
composition [0..*] of ZI_O_ACCOUNT as _Account
composition [0..*] of ZI_O_HISTORY as _History
{
    key order_number as OrderNumber,
    key item_number as ItemNumber,
    material as Material,
    quantity as Quantity,
  @Semantics.amount.currencyCode : 'Currency'
    net_price as NetPrice,
  @Semantics.amount.currencyCode : 'Currency'
    item_value as ItemValue,
        createdby as Createdby,
    createdat as Createdat,
    lastchangedby as Lastchangedby,
    lastchangedat as Lastchangedat,
    locallastchangedat as Locallastchangedat,
    _Header.Currency,
_Header,
_History,
_Account
}
