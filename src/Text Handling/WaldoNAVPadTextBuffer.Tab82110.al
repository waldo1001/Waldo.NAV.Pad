table 82110 "WaldoNAVPad Text Buffer"
{
    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(10; Textline; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(20; Separator; Option)
        {
            OptionMembers = " ",Space,"Carriage Return";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

