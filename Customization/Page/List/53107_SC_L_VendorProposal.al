page 53107 "VendorProposal"
{
    PageType = List;
    SourceTable = "Vendor Proposal";
    ApplicationArea = All;
    Caption = 'Vendor Proposal List';
    UsageCategory = Lists;
    CardPageId = 53106;
    ModifyAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(ID; Rec."Proposal ID")
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
                field(ProposalDate; Rec."Proposal Date")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}