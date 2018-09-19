page 82150 "WaldoNAVPad Blobs"
{
    PageType = List;
    SourceTable = "WaldoNAVPad Blobstore";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                }
                field(RecordID; FORMAT("Record ID"))
                {
                }
                field(Blob; Blob.HasValue())
                {
                }
            }
        }
    }

    actions
    {
    }
}

