codeunit 82101 "WaldoNAVPad ShowTexts Meth"
{
  // version WaldoNAVPad


  trigger OnRun();
  begin
  end;

  procedure ShowTexts(Editable : Boolean;UseHTMLEditor : Boolean;var RecRef : RecordRef;var ReturnWaldoNAVPadTextClass : Codeunit "WaldoNAVPad Text Class");
  var
    Handled : Boolean;
  begin
    OnBeforeShowTexts(RecRef,Handled);
    DoShowTexts(Editable,UseHTMLEditor,RecRef,ReturnWaldoNAVPadTextClass,Handled);
    OnAfterShowTexts(RecRef);
  end;

  local procedure DoShowTexts(Editable : Boolean;UseHTMLEditor : Boolean;var RecRef : RecordRef;var ReturnWaldoNAVPadTextClass : Codeunit "WaldoNAVPad Text Class";Handled : Boolean);
  var
    WaldoNAVPadTextstore : Record "WaldoNAVPad Textstore";
    TextFromBlob : Text;
    UpdatedText : Text;
  begin
    if Handled then exit;

    TextFromBlob := GetTextFromWNPBlob(RecRef);

    LoadTextfromDialog(TextFromBlob,Editable,UseHTMLEditor,ReturnWaldoNAVPadTextClass);
  end;

  local procedure GetTextFromWNPBlob(var RecRef : RecordRef) : Text;
  var
    TempBlob : Record TempBlob;
    WaldoNavPadBlobstore : Record "WaldoNavPad Blobstore";
  begin
    with WaldoNavPadBlobstore do begin
      SETRANGE("Record ID", RecRef.RECORDID);
      if not FINDFIRST then exit('');
      if not Blob.HASVALUE then exit('');

      CALCFIELDS(Blob);
      TempBlob.Blob := Blob;

      exit(GetTextFromBlob(TempBlob));
    end;
  end;

  local procedure LoadTextfromDialog(var TextFromBlob : Text;Editable : Boolean;UseHTMLEditor : Boolean;var ResultWaldoNAVPadTextClass : Codeunit "WaldoNAVPad Text Class");
  var
    WaldoNAVPadTextstore : Record "WaldoNAVPad Textstore";
  begin
    with ResultWaldoNAVPadTextClass do begin
      Initialize(TextFromBlob, MAXSTRLEN(WaldoNAVPadTextstore.Textline));
      LoadTextFromDialog(Editable,UseHTMLEditor);
    end;
  end;

  local procedure GetTextFromBlob(var TempBlob : Record TempBlob) : Text;
  var
    ReadStream : InStream;
    TextBigText : BigText;
  begin
    TempBlob.Blob.CREATEINSTREAM(ReadStream);
    TextBigText.READ(ReadStream);
    exit(FORMAT(TextBigText));
  end;

  [IntegrationEvent(false, false)]
  local procedure OnBeforeShowTexts(var RecRef : RecordRef;var Handled : Boolean);
  begin
  end;

  [IntegrationEvent(false, false)]
  local procedure OnAfterShowTexts(var RecRef : RecordRef);
  begin
  end;
}

