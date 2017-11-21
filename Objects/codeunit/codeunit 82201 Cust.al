codeunit 82201 "Cust. Open WNP HTML Action"
{
  // version WaldoNAVPad

  TableNo = Customer;

  trigger OnRun();
  var
    WaldoNAVPadClass : Codeunit "WaldoNAVPad Class";
  begin
    //Example code to implement the WaldoNAVPad on a Record, using the generic Text tables
    WaldoNAVPadClass.Initialize(Rec);
    WaldoNAVPadClass.ShowAndSaveTexts(true,true);
  end;
}

