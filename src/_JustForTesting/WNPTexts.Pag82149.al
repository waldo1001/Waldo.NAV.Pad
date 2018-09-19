page 82149 "WaldoNAVPad Texts"
{
    PageType = List;
    SourceTable = "WaldoNAVPad Textstore";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; "Entry No")
                {
                }
                field(RecordID; FORMAT("Record ID"))
                {
                }
                field(Textline; Textline)
                {
                }
                field(Separator; Separator)
                {
                }
                field(TableNo; TableNo)
                {
                }
            }
        }
    }

    actions
    {
    }
}

