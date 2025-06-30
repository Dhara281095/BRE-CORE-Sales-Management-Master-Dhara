page 53102 "UAE Regulatory Reqs. List"
{
    PageType = List;
    SourceTable = "UAE Regulatory Requirements";
    ApplicationArea = All;
    Caption = 'UAE Regulatory Requirements List';
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
}