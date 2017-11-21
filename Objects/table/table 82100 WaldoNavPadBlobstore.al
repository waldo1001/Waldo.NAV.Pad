table 82100 "WaldoNavPad Blobstore"
{
  // version WaldoNAVPad


  fields
  {
    field(1;"Entry No.";Integer)
    {
      AutoIncrement = true;
    }
    field(10;"Record ID";RecordID)
    {
    }
    field(20;Blob;BLOB)
    {
    }
    field(100;TableNo;Integer)
    {
    }
  }

  keys
  {
    key(Key1;"Entry No.")
    {
      Clustered = true;
    }
  }

  fieldgroups
  {
  }
}

