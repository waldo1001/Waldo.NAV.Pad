table 82101 "WaldoNAVPad Textstore"
{
  // version WaldoNAVPad


  fields
  {
    field(1;"Entry No";Integer)
    {
      AutoIncrement = true;
    }
    field(10;"Record ID";RecordID)
    {
    }
    field(20;Textline;Text[80])
    {
    }
    field(30;Separator;Option)
    {
      OptionMembers = " ",Space,"Carriage Return";
    }
    field(100;TableNo;Integer)
    {
    }
  }

  keys
  {
    key(Key1;"Entry No")
    {
      Clustered = true;
    }
  }

  fieldgroups
  {
  }
}

