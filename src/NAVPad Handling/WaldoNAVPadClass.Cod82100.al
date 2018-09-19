codeunit 82100 "WaldoNAVPad Class"
{
    var
        WaldoNAVPadTextClass: Codeunit "WaldoNAVPad Text Class";
        CurrentRecRef: RecordRef;
        IsInitialized: Boolean;
        IsTextLoaded: Boolean;
        NotInitializedErr: Label 'Record not initialized.  Please review your code!';
        NoTextWasLoadedErr: Label 'No text was loaded.';

    procedure Initialize(RecVariant: Variant);
    var
        DataTypeManagement: Codeunit "Data Type Management";
    begin
        IsInitialized := DataTypeManagement.GetRecordRef(RecVariant, CurrentRecRef);
        CLEAR(WaldoNAVPadTextClass);
        IsTextLoaded := false;
    end;

    procedure ShowAndSaveTexts(Editable: Boolean; UseHTMLEditor: Boolean);
    begin
        if not IsInitialized then ERROR(NotInitializedErr);

        LoadTextFromDialog(Editable, UseHTMLEditor);
        if Editable then
            SaveText();
    end;

    procedure LoadTextFromDialog(Editable: Boolean; UseHTMLEditor: Boolean): Boolean;
    var
        WaldoNAVPadShowTextsMeth: Codeunit "WaldoNAVPad ShowTexts Meth";
    begin
        if not IsInitialized then ERROR(NotInitializedErr);

        WaldoNAVPadShowTextsMeth.ShowTexts(Editable, UseHTMLEditor, CurrentRecRef, WaldoNAVPadTextClass);
        IsTextLoaded := true;
    end;

    procedure SaveText();
    var
        WaldoNAVPadSaveTextsMeth: Codeunit "WaldoNAVPad SaveTexts Meth";
    begin
        if not IsInitialized then ERROR(NotInitializedErr);
        if not IsTextLoaded then ERROR(NoTextWasLoadedErr);

        WaldoNAVPadSaveTextsMeth.SaveTexts(WaldoNAVPadTextClass, CurrentRecRef);
    end;

    procedure HasSavedTexts(var TableNo: Integer): Boolean;
    var
        WaldoNAVPadTableHasTextMeth: Codeunit "WaldoNAVPad TableHasText Meth";
    begin
        exit(WaldoNAVPadTableHasTextMeth.TableHasTexts(TableNo));
    end;
}

