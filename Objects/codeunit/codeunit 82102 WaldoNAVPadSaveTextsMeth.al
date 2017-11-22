codeunit 82102 "WaldoNAVPad SaveTexts Meth"
{
  trigger OnRun();
  begin
  end;

  procedure SaveTexts(var WaldoNAVPadTextClass : Codeunit "WaldoNAVPad Text Class";var RecRef : RecordRef);
  var
    Handled : Boolean;
  begin
    OnBeforeSaveTexts(Handled);

    DoSaveTexts(WaldoNAVPadTextClass,RecRef,Handled);

    OnAfterSaveTexts();
  end;

  local procedure DoSaveTexts(var WaldoNAVPadTextClass : Codeunit "WaldoNAVPad Text Class";var RecRef : RecordRef;var Handled : Boolean);
  var
    OldBlobText : Text;
  begin
    if Handled then exit;

    if not WaldoNAVPadTextClass.GetTextIsUpdated then exit;

    UpdateTextForRecord(WaldoNAVPadTextClass,RecRef);
  end;

  local procedure UpdateTextForRecord(var WaldoNAVPadTextClass : Codeunit "WaldoNAVPad Text Class";var RecRef : RecordRef);
  begin
    SaveTextToBlob(WaldoNAVPadTextClass.GetHTML,RecRef);;
    SaveTextToRecords(WaldoNAVPadTextClass,RecRef);
  end;

  local procedure FilterWNPTexts(var WaldoNAVPadTextstore : Record "WaldoNAVPad Textstore";var RecRef : RecordRef);
  begin
    with WaldoNAVPadTextstore do begin
      SETRANGE("Record ID", RecRef.RECORDID);
    end;
  end;

  local procedure SaveTextToBlob(Text : Text;var RecRef : RecordRef);
  begin
    DeleteWNPBlobForRecord(RecRef);
    InsertWPNBlobForRecord(Text,RecRef);
  end;

  local procedure DeleteWNPBlobForRecord(var RecRef : RecordRef);
  var
    WaldoNavPadBlobstore : Record "WaldoNavPad Blobstore";
  begin
    with WaldoNavPadBlobstore do begin
      SETRANGE("Record ID", RecRef.RECORDID);
      DELETEALL(false);
    end;
  end;

  local procedure InsertWPNBlobForRecord(var Text : Text;var RecRef : RecordRef);
  var
    WaldoNavPadBlobstore : Record "WaldoNavPad Blobstore";
    TempBlob : Record TempBlob;
  begin
    with WaldoNavPadBlobstore do begin
      GetBlobFromText(Text,TempBlob);
      INIT;
      "Record ID" := RecRef.RECORDID;
      Blob := TempBlob.Blob;
      TableNo := RecRef.NUMBER;
      INSERT;
    end;
  end;

  local procedure SaveTextToRecords(var WaldoNAVPadTextClass : Codeunit "WaldoNAVPad Text Class";var RecRef : RecordRef);
  begin
    DeleteWNPTextForRecord(RecRef);
    InsertWPNTextForRecord(WaldoNAVPadTextClass,RecRef);
  end;

  local procedure DeleteWNPTextForRecord(var RecRef : RecordRef);
  var
    WaldoNAVPadTextstore : Record "WaldoNAVPad Textstore";
  begin
    FilterWNPTexts(WaldoNAVPadTextstore, RecRef);
    WaldoNAVPadTextstore.DELETEALL(false);
  end;

  local procedure InsertWPNTextForRecord(var WaldoNAVPadTextClass : Codeunit "WaldoNAVPad Text Class";var RecRef : RecordRef);
  begin
    with WaldoNAVPadTextClass do begin
      if FINDFIRST then
        repeat
          InsertWPNText(GetCurrentTextLine, RecRef);
        until NEXT < 1;
    end;
  end;

  local procedure InsertWPNText(pTextline : Text;var RecRef : RecordRef);
  var
    WaldoNAVPadTextstore : Record "WaldoNAVPad Textstore";
  begin
    with WaldoNAVPadTextstore do begin
      INIT;

      Textline := pTextline;
      "Record ID" := RecRef.RECORDID;
      TableNo := RecRef.NUMBER;

      INSERT;
    end;
  end;

  local procedure GetBlobFromText(Text : Text;var TempBlob : Record TempBlob);
  var
    WriteStream : OutStream;
    TextBigText : BigText;
  begin
    TempBlob.Blob.CREATEOUTSTREAM(WriteStream);
    TextBigText.ADDTEXT(Text);
    TextBigText.WRITE(WriteStream);
  end;

  local procedure OnBeforeSaveTexts(var Handled : Boolean);
  begin
  end;

  local procedure OnAfterSaveTexts();
  begin
  end;
}

