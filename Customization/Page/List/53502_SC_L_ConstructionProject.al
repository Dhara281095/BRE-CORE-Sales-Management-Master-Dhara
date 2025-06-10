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
                field("Project Location"; Rec."Project Location")
                {
                    ApplicationArea = All;
                }
                field("Project Scope"; Rec."Project Scope")
                {
                    ApplicationArea = All;
                }
                field("Project Start Date"; Rec."Project Start Date")
                {
                    ApplicationArea = All;
                }
                field("Project End Date"; Rec."Project End Date")
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