page 82100 WaldoNAVPad
{
  Caption = 'waldoNAVPad';
  PageType = Card;

  layout
  {
    area(content)
    {
      grid(Control1100084005)
      {
        field(FullText;FullText)
        {
          MultiLine = true;
        }
      }
    }
  }

  actions
  {
    area(processing)
    {
      action(Blobs)
      {
        RunObject = Page "WNP Blobs";
      }
      action(Texts)
      {
        RunObject = Page "WNP Texts";
      }
      action("Test HTML Editor")
      {

        trigger OnAction();
        begin
          PAGE.RUN(50010);
        end;
      }
    }
  }

  var
    FullText : Text;

  procedure SetText(Value : Text);
  begin
    FullText := Value;
  end;

  procedure GetText() : Text;
  begin
    exit(FullText);
  end;
}

