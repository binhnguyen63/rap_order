@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'item composition'
@Metadata.allowExtensions: true
define view entity ZC_O_ITEM as projection on ZI_O_ITEM
{
    key OrderNumber,
    key ItemNumber,
    Material,
    Quantity,
@Semantics.amount.currencyCode: 'Currency'
    NetPrice,
@Semantics.amount.currencyCode: 'Currency'
    ItemValue,
    Currency,
        Createdby,
    Createdat,
    Lastchangedby,
    Lastchangedat,
    Locallastchangedat,
    /* Associations */
    _Account: redirected to composition child ZC_O_ACCOUNT,
    _Header : redirected to parent Zc_O_Header,
    _History: redirected to composition child ZC_O_HISTORY
}
