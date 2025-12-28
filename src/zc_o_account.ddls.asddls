@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'header composition'
@Metadata.allowExtensions: true

define view entity ZC_O_ACCOUNT as projection on ZI_O_ACCOUNT
{
    key OrderNumber,
    key ItemNumber,
    key AccLine,
    GlAccount,
    CostNumber,
@Semantics.amount.currencyCode: 'Currency'
    Amount,
    Currency,
        Createdby,
    Createdat,
    Lastchangedby,
    Lastchangedat,
    Locallastchangedat,
    /* Associations */
    _Item: redirected to parent ZC_O_ITEM,
        _Header : redirected to Zc_O_Header
}
