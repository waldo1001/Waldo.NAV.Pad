table 82110 "WaldoNAVPad Text Buffer"
{
  fields
  {
    field(1;"Line No.";Integer)
    {
    }
    field(10;Textline;Text[250])
    {
    }
    field(20;Separator;Option)
    {
      OptionMembers = " ",Space,"Carriage Return";
    }
  }

  keys
  {
    key(Key1;"Line No.")
    {
      Clustered = true;
    }
  }

  fieldgroups
  {
  }
}

