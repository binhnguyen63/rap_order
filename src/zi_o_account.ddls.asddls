@AccessControl.authorizationCheck: #NOT_REQUIRED
 @EndUserText.label: 'interface view item'
define view entity ZI_O_ACCOUNT as select from zsac_o_account
association to parent ZI_O_ITEM as _Item on $projection.OrderNumber = _Item.OrderNumber and $projection.ItemNumber = _Item.ItemNumber
association [1..1] to ZR_O_HEADER as _Header on  $projection.OrderNumber = _Header.OrderNumber
{
    key order_number as OrderNumber,
    key item_number as ItemNumber,
    key acc_line as AccLine,
    gl_account as GlAccount,
    cost_number as CostNumber,
    @Semantics.amount.currencyCode: 'Currency'
    amount as Amount,
        createdby as Createdby,
    createdat as Createdat,
    lastchangedby as Lastchangedby,
    lastchangedat as Lastchangedat,
    locallastchangedat as Locallastchangedat,
    _Item,
    _Item.Currency,
    _Header
}

