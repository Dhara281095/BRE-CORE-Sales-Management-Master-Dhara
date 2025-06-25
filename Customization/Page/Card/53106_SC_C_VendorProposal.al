page 53106 "Vendor Proposal"
{
    PageType = Card;
    SourceTable = "Vendor Proposal";
    ApplicationArea = All;
    Caption = 'Vendor Proposal Card';

    layout
    {
        area(Content)
        {
            group("Vendor Proposal")
            {
                Caption = 'Vendor Proposal';
                field("Proposal ID"; Rec."Proposal ID")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                }
                field("Project ID"; Rec."Project ID")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Vendor ID"; Rec."Vendor ID")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Proposal Date"; Rec."Proposal Date")
                {
                    ApplicationArea = All;
                }
                field("Work Scope"; Rec."Work Scope")
                {
                    ApplicationArea = All;
                    multiLine = true;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Quoted Price"; Rec."Quoted Price")
                {
                    ApplicationArea = All;
                }
                field("Payment Terms"; Rec."Payment Terms")
                {
                    ApplicationArea = All;
                }
                field("Compliance Required"; Rec."Compliance Required")
                {
                    ApplicationArea = All;
                }
                field("Internal Remarks"; Rec."Internal Remarks")
                {
                    ApplicationArea = All;
                    multiLine = true;
                }
                field("Vendor Remarks"; Rec."Vendor Remarks")
                {
                    ApplicationArea = All;
                    multiLine = true;
                }
                field("Internal Approval Status"; Rec."Internal Approval Status")
                {
                    ApplicationArea = All;
                }
                field("Vendor Approval Status"; Rec."Vendor Approval Status")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created DateTime"; Rec."Created DateTime")
                {
                    ApplicationArea = All;
                }

            }


        }
    }

    actions
    {
        area(Navigation)
        {
            action("Submission for Approval")
            {
                ApplicationArea = All;
                Caption = 'Submit for Approval';
                Image = Approve;
                trigger OnAction()
                var
                    ApprovalVendorProposal: Codeunit "Approval Vendor Proposal";
                begin
                    ApprovalVendorProposal.SubmitVendorProposal(Rec);
                end;
            }
        }
    }

    // Insert Validation and trigger 
    // trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    // var
    // begin
    //     Rec.TestField("Project ID");
    //     // Rec.TestField("Vendor ID");
    // end;

}