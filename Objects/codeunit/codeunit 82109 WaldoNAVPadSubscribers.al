codeunit 82109 "WaldoNAVPad Subscribers"
{
  // version WaldoNAVPad


  trigger OnRun();
  begin
  end;

  [EventSubscriber(ObjectType::Codeunit, 1, 'OnAfterGetDatabaseTableTriggerSetup', '', false, false)]
  local procedure SetUpWaldoNAVPad_OnAfterGetDatabaseTableTriggerSetup(TableId : Integer;var OnDatabaseInsert : Boolean;var OnDatabaseModify : Boolean;var OnDatabaseDelete : Boolean;var OnDatabaseRename : Boolean);
  var
    WaldoNAVPadClass : Codeunit "WaldoNAVPad Class";
  begin
    OnDatabaseRename := true;
    //making this TRUE for all tables should not be that concerning,
    //as renaming isn't something that happens too often ;-)

    //On the other hand, if we would do it like this:
    //  OnDatabaseRename := WaldoNAVPadClass.HasTexts(TableId);
    //Then it would fail for the first text we add to a table:
    //   - TriggerSetup would be false
    //   - if we add text and then rename, it wouldn't rename the text
  end;

  [EventSubscriber(ObjectType::Codeunit, 1, 'OnAfterOnDatabaseRename', '', false, false)]
  local procedure HandleWaldoNAVPadTexts_OnAfterOnDatabaseRename(RecRef : RecordRef;xRecRef : RecordRef);
  begin
    HandleRenameRecord(RecRef,xRecRef);
  end;

  local procedure HandleRenameRecord(var RecRef : RecordRef;var xRecRef : RecordRef);
  begin
    HandleBlobStore(RecRef,xRecRef);
    HandleTextStore(RecRef,xRecRef);
  end;

  local procedure HandleBlobStore(var RecRef : RecordRef;var xRecRef : RecordRef);
  var
    WaldoNavPadBlobstore : Record "WaldoNavPad Blobstore";
  begin
    with WaldoNavPadBlobstore do begin
      SETRANGE("Record ID", xRecRef.RECORDID);
      MODIFYALL("Record ID", RecRef.RECORDID,false);
    end;
  end;

  local procedure HandleTextStore(var RecRef : RecordRef;var xRecRef : RecordRef);
  var
    WaldoNAVPadTextstore : Record "WaldoNAVPad Textstore";
  begin
    with WaldoNAVPadTextstore do begin
      SETRANGE("Record ID", xRecRef.RECORDID);
      MODIFYALL("Record ID", RecRef.RECORDID,false);
    end;
  end;
}

