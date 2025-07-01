page 53101 "Incoterms List"
{
    PageType = List;
    SourceTable = "Incoterms";
    ApplicationArea = All;
    Caption = 'Incoterms List';
    UsageCategory = Lists;


    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;


                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    // trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    // var
    // begin
    //     Rec.TestField("Name");
    //     Rec.TestField("Description");
    // end;
}