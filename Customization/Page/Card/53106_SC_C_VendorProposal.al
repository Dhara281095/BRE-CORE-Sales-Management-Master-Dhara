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
            group("General Information")
            {
                Caption = 'General Information';
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
                field("Proposal Date"; Rec."Proposal Date")
                {
                    ApplicationArea = All;
                }
            }

            group("Vendor Information")
            {
                Caption = 'Vendor Information';
                field("Vendor ID"; Rec."Vendor ID")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        VendorRec: Record "Facility Vendor Profiles";
                    begin
                        VendorRec.SetRange("Vendor ID", Rec."Vendor ID");
                        if VendorRec.FindFirst() then begin
                            Rec."Vendor Name" := VendorRec."Vendor Name";
                            Rec."Vendor Email" := VendorRec."Email Address";
                            Rec."Vendor Designation" := VendorRec."Designation"; // Change to correct field if needed
                        end else begin
                            Rec."Vendor Name" := '';
                            Rec."Vendor Email" := '';
                            Rec."Vendor Designation" := '';
                        end;
                    end;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Email"; Rec."Vendor Email")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Designation"; Rec."Vendor Designation")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Vendor Proposal Details")
            {
                Caption = 'Vendor Proposal Details';

                field("Work Scope"; Rec."Work Scope")
                {
                    ApplicationArea = All;
                    multiLine = true;
                }
                field("Start Date"; Rec."Start Date")
                {
                    Caption = 'Proposal Start Date';
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    Caption = 'Proposal End Date';
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

            }
            group("Vendor Proposale Status")
            {
                Caption = 'Vendor Proposal Status';

                field("Internal Approval Status"; Rec."Internal Approval Status")
                {
                    ApplicationArea = All;
                }
                field("Internal Remarks"; Rec."Internal Remarks")
                {
                    ApplicationArea = All;
                    multiLine = true;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Vendor Approval Status"; Rec."Vendor Approval Status")
                {
                    ApplicationArea = All;
                }
                field("Vendor Remarks"; Rec."Vendor Remarks")
                {
                    ApplicationArea = All;
                    multiLine = true;
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