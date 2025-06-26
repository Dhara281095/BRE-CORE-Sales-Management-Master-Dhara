page 53109 "VendorContract"
{
    PageType = List;
    SourceTable = "Vendor Contract";
    ApplicationArea = All;
    Caption = 'Vendor Contract List';
    UsageCategory = Lists;
    CardPageId = 53108;
    ModifyAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(ID; Rec."Contract ID")
                {
                    ApplicationArea = All;
                }
                field("Proposal ID"; Rec."Proposal ID")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec."Project ID")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec."Vendor ID")
                {
                    ApplicationArea = All;
                }
                field("Contract Date"; Rec."Contract Date")
                {
                    ApplicationArea = All;
                }
                field("Contract Start Date"; Rec."Contract Start Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}