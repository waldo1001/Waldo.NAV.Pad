pageextension 50101 pageextension50101 extends "Customer List" 
{
  // version NAVW110.0,WaldoNAVPad

  actions
  {
    addafter("Sales Journal")
    {
      action(OpenWNPText)
      {
        Caption = 'Open WaldoNAVPad Text';
        Image = Text;
        Promoted = true;
        PromotedIsBig = true;
        RunObject = Codeunit "Cust. Open WNP Action";
        RunPageOnRec = true;
      }
      action(OpenWNPTextHTML)
      {
        Caption = 'Open WaldoNAVPad HTML';
        Image = Text;
        Promoted = true;
        PromotedIsBig = true;
        RunObject = Codeunit "Cust. Open WNP HTML Action";
        RunPageOnRec = true;
      }
    }
  }
}

