table 82101 "WaldoNAVPad Textstore"
{
    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }
        field(10; "Record ID"; RecordID)
        {
            DataClassification = CustomerContent;
        }
        field(20; Textline; Text[80])
        {
            DataClassification = CustomerContent;
        }
        field(30; Separator; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Space,"Carriage Return";
        }
        field(100; TableNo; Integer)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

