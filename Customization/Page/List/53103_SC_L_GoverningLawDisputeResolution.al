page 53103 "GoverningLawDisputeResolution"
{
    PageType = List;
    SourceTable = "GoverningLawDisputeResolution";
    ApplicationArea = All;
    Caption = 'Governing Law & Dispute Resolution List';
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