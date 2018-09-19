table 82100 "WaldoNAVPad Blobstore"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }
        field(10; "Record ID"; RecordID)
        {
            DataClassification = CustomerContent;
        }
        field(20; Blob; BLOB)
        {
            DataClassification = CustomerContent;
        }
        field(100; TableNo; Integer)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

