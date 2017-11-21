codeunit 82108 "WaldoNAVPad Upgrade Mgt."
{
  // version WaldoNAVPad


  trigger OnRun();
  begin
  end;

  procedure OnNavAppUpgradePerDatabase();
  begin
  end;

  procedure OnNavAppUpgradePerCompany();
  begin
    RestoreFieldsInModifiedTables(50000,99999);
    RestoreAppTables(50000,99999);
  end;

  local procedure RestoreFieldsInModifiedTables(FromField : Integer;ToField : Integer);
  var
    "Field" : Record Field;
    AllObj : Record AllObj;
    SourceRecRef : RecordRef;
    DestinationRecRef : RecordRef;
    KeyRef : KeyRef;
  begin
    with AllObj do begin
      SETRANGE("Object Type","Object Type"::Table);

      if FINDSET then
        repeat
            Field.SETRANGE(TableNo, "Object ID");
            Field.SETRANGE("No.", FromField, ToField);
            if not Field.ISEMPTY then begin
              NAVAPP.RESTOREARCHIVEDATA("Object ID");
            end;
        until NEXT < 1;
    end;
  end;

  local procedure RestoreAppTables(FromTableID : Integer;ToTableID : Integer);
  var
    SourceRecRef : RecordRef;
    DestinationRecRef : RecordRef;
    "Field" : Record Field;
    AllObj : Record AllObj;
  begin
    with AllObj do begin
      SETRANGE("Object Type", "Object Type"::Table);
      SETRANGE("Object ID", FromTableID,ToTableID);

      if FINDSET then
        repeat
          NAVAPP.RESTOREARCHIVEDATA("Object ID");
        until NEXT < 1;
    end;
  end;
}

