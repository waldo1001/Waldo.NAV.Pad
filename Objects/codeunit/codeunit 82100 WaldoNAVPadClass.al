codeunit 82100 "WaldoNAVPad Class"
{
  // version WaldoNAVPad


  trigger OnRun();
  begin
  end;

  var
    CurrentRecRef : RecordRef;
    WaldoNAVPadTextClass : Codeunit "WaldoNAVPad Text Class";
    IsInitialized : Boolean;
    NotInitialized : Label 'Record not initialized.  Please review your code!';
    IsTextLoaded : Boolean;
    NoTextWasLoaded : Label 'No text was loaded.';

  procedure Initialize(RecVariant : Variant);
  var
    DataTypeManagement : Codeunit "Data Type Management";
  begin
    IsInitialized := DataTypeManagement.GetRecordRef(RecVariant, CurrentRecRef);
    CLEAR(WaldoNAVPadTextClass);
    IsTextLoaded := false;
  end;

  procedure ShowAndSaveTexts(Editable : Boolean;UseHTMLEditor : Boolean);
  var
    WaldoNAVPadShowTextsMeth : Codeunit "WaldoNAVPad ShowTexts Meth";
  begin
    if not IsInitialized then ERROR(NotInitialized);

    LoadTextFromDialog(Editable,UseHTMLEditor);
    if Editable then
      SaveText;
  end;

  procedure LoadTextFromDialog(Editable : Boolean;UseHTMLEditor : Boolean) : Boolean;
  var
    WaldoNAVPadShowTextsMeth : Codeunit "WaldoNAVPad ShowTexts Meth";
  begin
    if not IsInitialized then ERROR(NotInitialized);

    WaldoNAVPadShowTextsMeth.ShowTexts(Editable,UseHTMLEditor,CurrentRecRef,WaldoNAVPadTextClass);
    IsTextLoaded := true;
  end;

  procedure SaveText();
  var
    WaldoNAVPadSaveTextsMeth : Codeunit "WaldoNAVPad SaveTexts Meth";
  begin
    if not IsInitialized then ERROR(NotInitialized);
    if not IsTextLoaded then ERROR(NoTextWasLoaded);

    WaldoNAVPadSaveTextsMeth.SaveTexts(WaldoNAVPadTextClass,CurrentRecRef);
  end;

  procedure HasSavedTexts(var TableNo : Integer) : Boolean;
  var
    WaldoNAVPadTableHasTextMeth : Codeunit "WaldoNAVPad TableHasText Meth";
  begin
    exit(WaldoNAVPadTableHasTextMeth.TableHasTexts(TableNo));
  end;
}

