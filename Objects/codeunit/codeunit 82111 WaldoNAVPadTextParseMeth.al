codeunit 82111 "WaldoNAVPad Text Parse Meth"
{
  // version WaldoNAVPad


  trigger OnRun();
  begin
  end;

  procedure ParseText(var Text : Text;MaxLength : Integer;var ResultWaldoNAVPadTextBuffer : Record "WaldoNAVPad Text Buffer");
  var
    Handled : Boolean;
  begin
    OnBeforeParseText(Text,Handled);
    DoParseText(Text,MaxLength,ResultWaldoNAVPadTextBuffer,Handled);
    OnAfterParseText(Text);
  end;

  local procedure DoParseText(var Text : Text;MaxLength : Integer;var ResultWaldoNAVPadTextBuffer : Record "WaldoNAVPad Text Buffer";var Handled : Boolean);
  var
    SystemString : DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String";
    LineArray : DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
    SystemIOStringReader : DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.IO.StringReader";
    Line : DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String";
    LineNo : Integer;
  begin
    if Handled then exit;

    SystemString := Text;

    ResultWaldoNAVPadTextBuffer.DELETEALL(false);

    SystemIOStringReader := SystemIOStringReader.StringReader(Text);
    Line := SystemIOStringReader.ReadLine;
    while not ISNULL(Line) do begin
      ProcessLine(LineNo,Line,MaxLength,ResultWaldoNAVPadTextBuffer);

      Line := SystemIOStringReader.ReadLine;
    end;
  end;

  local procedure ProcessLine(var LineNo : Integer;var Line : DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String";MaxLength : Integer;var ResultWaldoNAVPadTextBuffer : Record "WaldoNAVPad Text Buffer");
  var
    SubString : DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String";
    SpaceIndex : Integer;
    ResultString : DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String";
  begin
    while STRLEN(Line) > MaxLength do begin
      SubString := COPYSTR(Line,1,MaxLength);
      SpaceIndex := SubString.LastIndexOf(' ');
      if SpaceIndex = -1 then //No Space Found
        SpaceIndex := MaxLength;
      if SpaceIndex = 0 then //First Character is a space
        SpaceIndex := MaxLength;
      ResultString := SubString;
      if SpaceIndex < SubString.Length then begin
        ResultString := SubString.Substring(0,SpaceIndex);
        AddToBuffer(LineNo,ResultString,ResultWaldoNAVPadTextBuffer.Separator::" ", ResultWaldoNAVPadTextBuffer);
      end else begin
        AddToBuffer(LineNo,ResultString,ResultWaldoNAVPadTextBuffer.Separator::Space, ResultWaldoNAVPadTextBuffer);
      end;

      Line := Line.Remove(0,ResultString.Length);
    end;

    AddToBuffer(LineNo,Line,ResultWaldoNAVPadTextBuffer.Separator::"Carriage Return",ResultWaldoNAVPadTextBuffer);
  end;

  local procedure AddToBuffer(var LineNo : Integer;var Line : DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String";pSeparator : Integer;var ResultWaldoNAVPadTextBuffer : Record "WaldoNAVPad Text Buffer");
  begin
    LineNo += 1;

    with ResultWaldoNAVPadTextBuffer do begin
      INIT;
      "Line No." := LineNo;
      Textline := Line;
      Separator := pSeparator;
      INSERT;
    end;
  end;

  local procedure "--- Event Wrapper"();
  begin
  end;

  [IntegrationEvent(false, false)]
  local procedure OnBeforeParseText(var Text : Text;var Handled : Boolean);
  begin
  end;

  [IntegrationEvent(false, false)]
  local procedure OnAfterParseText(var Text : Text);
  begin
  end;
}

