codeunit 82110 "WaldoNAVPad Text Class"
{
  trigger OnRun();
  begin
  end;

  var
    WaldoNAVPadTextBuffer : Record "WaldoNAVPad Text Buffer" temporary;
    MaxLenght : Integer;
    CurrentObjectNr : Integer;
    //CurrentObject : DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Object";
    CurrentText : Text;
    CurrentHTML : Text;
    CurrentTextIsUpdated : Boolean;

  procedure Initialize(var Text : Text;pMaxLength : Integer);
  begin
    SetMaxLenght(pMaxLength);
    CurrentText := Text;
    CurrentHTML := Text;
    ParseText(CurrentText);

    FINDFIRST;
  end;

  procedure Initialize2(var Text : Text;var HTML : Text;pMaxLength : Integer);
  begin
    SetMaxLenght(pMaxLength);
    CurrentText := Text;
    CurrentHTML := HTML;
    ParseText(CurrentText);

    FINDFIRST;
  end;

  procedure LoadTextFromDialog(Editable : Boolean;UseHTMLEditor : Boolean);
  var
    WaldoNAVPadShowdialogMeth : Codeunit "WaldoNAVPad Showdialog Meth";
  begin
    WaldoNAVPadShowdialogMeth.ShowDialog(CurrentText,CurrentHTML,CurrentTextIsUpdated,Editable,UseHTMLEditor);

    if Editable then begin
      ParseText(CurrentText);

    end;
  end;

  procedure GetTextIsUpdated() : Boolean;
  begin
    exit(CurrentTextIsUpdated);
  end;

  procedure GetText() : Text;
  begin
    exit(CurrentText);
  end;

  procedure GetHTML() : Text;
  begin
    if CurrentHTML = '' then
      exit(CurrentText)
    else
      exit(CurrentHTML);
  end;

  procedure SetMaxLenght(pMaxLenght : Integer);
  begin
    MaxLenght := pMaxLenght;
  end;

  procedure GetMaxLength() : Integer;
  begin
    exit(MaxLenght);
  end;

  procedure GetCurrentTextLine() : Text;
  begin
    exit(WaldoNAVPadTextBuffer.Textline);
  end;

  procedure FINDFIRST() : Boolean;
  begin
    exit(WaldoNAVPadTextBuffer.FINDSET);
  end;

  procedure "COUNT"() : Integer;
  begin
    exit(WaldoNAVPadTextBuffer.COUNT);
  end;

  procedure NEXT() : Integer;
  begin
    exit(WaldoNAVPadTextBuffer.NEXT);
  end;

  local procedure ParseText(var Text : Text);
  var
    WaldoNAVPadTextParseMeth : Codeunit "WaldoNAVPad Text Parse Meth";
  begin
    WaldoNAVPadTextParseMeth.ParseText(Text,GetMaxLength,WaldoNAVPadTextBuffer);
  end;
}

