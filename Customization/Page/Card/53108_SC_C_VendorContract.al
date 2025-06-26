page 53108 "Vendor Contract"
{
    PageType = Card;
    SourceTable = "Vendor Contract";
    ApplicationArea = All;
    Caption = 'Vendor Contract Card';

    layout
    {
        area(Content)
        {
            group("General Information")
            {
                Caption = 'General Information';

                field("Contract ID"; Rec."Contract ID")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                }
                field("Proposal ID"; Rec."Proposal ID")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        VendorRec: Record "Vendor Proposal";
                    begin
                        VendorRec.SetRange("Proposal ID", Rec."Proposal ID");
                        if VendorRec.FindFirst() then begin
                            Rec."Vendor ID" := VendorRec."Vendor ID";
                            Rec."Vendor Name" := VendorRec."Vendor Name";
                            Rec."Vendor Email" := VendorRec."Vendor Email";
                            Rec."Vendor Designation" := VendorRec."Vendor Designation"; // Change to correct field if needed
                        end else begin
                            Rec."Vendor ID" := '';
                            Rec."Vendor Name" := '';
                            Rec."Vendor Email" := '';
                            Rec."Vendor Designation" := '';
                        end;
                    end;
                }
                field("Project ID"; Rec."Project ID")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Contract Date"; Rec."Contract Date")
                {
                    ApplicationArea = All;
                }
            }
            group("Vendor Information")
            {
                field("Vendor ID"; Rec."Vendor ID")
                {
                    ApplicationArea = All;
                    Editable = false;
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
            group("Vendor Contract Details")
            {
                Caption = 'Vendor Contract Details';
                field("Work Scope"; Rec."Work Scope")
                {
                    ApplicationArea = All;
                    multiLine = true;
                }
                field("Compliance Required"; Rec."Compliance Required")
                {
                    ApplicationArea = All;
                }
                field("Contract Start Date"; Rec."Contract Start Date")
                {
                    ApplicationArea = All;
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Terms"; Rec."Payment Terms")
                {
                    ApplicationArea = All;
                }

            }

            group("Vendor Contract Status")
            {
                Caption = 'Vendor Contract Status';
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

            }
        }
    }

    // actions
    // {
    //     area(Navigation)
    //     {
    //         action("Submission for Approval")
    //         {
    //             ApplicationArea = All;
    //             Caption = 'Submit for Approval';
    //             Image = Approve;
    //             trigger OnAction()
    //             var
    //                 ApprovalVendorProposal: Codeunit "Approval Vendor Proposal";
    //             begin
    //                 ApprovalVendorProposal.SubmitVendorProposal(Rec);
    //             end;
    //         }
    //     }
    // }

    // Insert Validation and trigger 
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
    begin
        Rec.TestField("Proposal ID");
        Rec.TestField("Project ID");
        Rec.TestField("Vendor ID");
    end;

}