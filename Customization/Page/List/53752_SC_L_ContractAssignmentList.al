page 53752 "Contract Assignment List"
{
    PageType = List;
    SourceTable = "Contract Assignment";
    ApplicationArea = All;
    Caption = 'Vendor Assignment List';
    UsageCategory = Lists;
    CardPageId = 53753;
    ModifyAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Assignment ID"; Rec."Assignment ID")
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
                field("Vendor/Subcontractor Name"; Rec."Vendor/Subcontractor Name")
                {
                    ApplicationArea = All;
                }
                field("Contract ID"; Rec."Contract ID")
                {
                    ApplicationArea = All;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = All;
                }
                field("Contract Status"; Rec."Contract Status")
                {
                    ApplicationArea = All;
                }
                field("Contract Date"; Rec."Contract Date")
                {
                    ApplicationArea = All;
                }
                field("Total Contract Amount"; Rec."Total Contract Amount")
                {
                    ApplicationArea = All;
                }
                field("Work Scope"; Rec."Work Scope")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Reviewed By"; Rec."Reviewed By")
                {
                    ApplicationArea = All;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}