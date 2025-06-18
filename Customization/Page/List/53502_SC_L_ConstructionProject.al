page 53502 "Construction Project List"
{
    PageType = List;
    SourceTable = "Construction Project";
    ApplicationArea = All;
    Caption = 'Construction Project List';
    UsageCategory = Lists;
    CardPageId = 53501; // "Construction Project"
    ModifyAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Project ID"; Rec."Project ID")
                {
                    ApplicationArea = All;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                }
                field("Planned Start Date"; Rec."Planned start date")
                {
                    ApplicationArea = All;
                }
                field("Planned End Date"; Rec."Planned End Date")
                {
                    ApplicationArea = All;
                }
                field("Project Status"; Rec."Project Status")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}