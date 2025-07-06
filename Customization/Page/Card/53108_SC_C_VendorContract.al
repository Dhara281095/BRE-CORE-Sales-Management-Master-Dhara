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
                            Rec."Vendor Designation" := VendorRec."Vendor Designation";
                            Rec."Project ID" := VendorRec."Project ID";
                            Rec."Work Scope" := VendorRec."Work Scope";
                            Rec."Contract Start Date" := VendorRec."Start Date";
                            Rec."Contract End Date" := VendorRec."End Date";
                            Rec."Payment Terms" := VendorRec."Payment Terms";
                            Rec."Compliance Required" := VendorRec."Compliance Required";
                            Rec."Created By" := VendorRec."Created By";
                            Rec."Project Name" := VendorRec."Project Name";
                            Rec."Duration" := VendorRec."Duration";
                            Rec."Project Location" := VendorRec."Project Location";
                            Rec."Delivery Location" := VendorRec."Delivery Location";
                            Rec."Delivery Date" := VendorRec."Delivery Date";
                            Rec."Late Delivery Penalty %" := VendorRec."Late Delivery Penalty %";
                            Rec."Total Contract Value (AED)" := VendorRec."Total Contract Value (AED)";
                            Rec."Advance Payment (%)" := VendorRec."Advance Payment (%)";
                            Rec."Interim Payment (%)" := VendorRec."Interim Payment (%)";
                            Rec."Final Payment (%)" := VendorRec."Final Payment (%)";
                            Rec."VAT %" := VendorRec."VAT %";
                            Rec."Payment Method" := VendorRec."Payment Method";
                            Rec."UAE Compliance Requirements" := VendorRec."UAE Compliance Requirements";
                            Rec."Industry Standards" := VendorRec."Industry Standards";
                            Rec."Warranty Period (Months)" := VendorRec."Warranty Period (Months)";
                            Rec."Dispute Resolution" := VendorRec."Dispute Resolution";
                            Rec.Description := VendorRec.Description;
                            Rec.Incoterms := VendorRec.Incoterms;
                            Rec."Work Scope" := VendorRec."Work Scope";
                            Rec."Contract Start Date" := VendorRec."Start Date";
                            Rec."Contract End Date" := VendorRec."End Date";
                            Rec.Description := VendorRec.Description;
                            Rec.Duration := VendorRec.Duration;

                        end else begin
                            Rec."Vendor ID" := '';
                            Rec."Vendor Name" := '';
                            Rec."Vendor Email" := '';
                            Rec."Vendor Designation" := '';
                            Rec."Project ID" := '';
                            Rec."Work Scope" := '';
                            Rec."Contract Start Date" := 0D;
                            Rec."Contract End Date" := 0D;
                            Rec."Payment Terms" := '';

                            Rec."Created By" := '';
                            Rec."Project Name" := '';
                            Rec."Duration" := '';
                            Rec."Project Location" := '';
                            Rec."Delivery Location" := '';
                            Rec."Delivery Date" := 0D;
                            Rec."Late Delivery Penalty %" := 0;
                            Rec."Total Contract Value (AED)" := 0;
                            Rec."Advance Payment (%)" := 0;
                            Rec."Interim Payment (%)" := 0;
                            Rec."Final Payment (%)" := 0;

                            Rec."Payment Method" := 0;
                            Rec."UAE Compliance Requirements" := '';
                            Rec."Industry Standards" := '';
                            Rec."Warranty Period (Months)" := 0;
                            Rec."Dispute Resolution" := '';
                            Rec.Description := '';
                            Rec.Incoterms := '';


                        end;
                    end;

                }

                field("Project ID"; Rec."Project ID")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                    Caption = 'Project Name';
                    Editable = false;
                }
                field("Project Location"; Rec."Project Location")
                {
                    ApplicationArea = All;
                    Caption = 'Project Location';
                    Editable = false;
                }
                field("Contract Date"; Rec."Contract Date")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
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
            group("Delivery & Performance")
            {
                Caption = 'Delivery & Performance';
                field("Delivery Location"; Rec."Delivery Location")
                {
                    ApplicationArea = All;
                    Caption = 'Delivery Location';
                    Editable = false;
                }
                field("Delivery Date"; Rec."Delivery Date")
                {
                    ApplicationArea = All;
                    Caption = 'Delivery Date';
                    Editable = false;
                }
                field(Incoterms; Rec.Incoterms)
                {
                    ApplicationArea = All;
                    Caption = 'Incoterms';
                    Editable = false;
                }
                field("Late Delivery Penalty %"; Rec."Late Delivery Penalty %")
                {
                    ApplicationArea = All;
                    Caption = 'Late Delivery Penalty %';
                    Editable = false;
                }
            }
            group("Price & Payment Terms")
            {
                Caption = 'Price & Payment Terms';
                field("Total Contract Value (AED)"; Rec."Total Contract Value (AED)")
                {
                    ApplicationArea = All;
                    Caption = 'Total Contract Value (AED)';
                    Editable = false;
                }
                field("Advance Payment (%)"; Rec."Advance Payment (%)")
                {
                    ApplicationArea = All;
                    Caption = 'Advance Payment (%)';
                    Editable = false;
                }
                field("Interim Payment (%)"; Rec."Interim Payment (%)")
                {
                    ApplicationArea = All;
                    Caption = 'Interim Payment (%)';
                    Editable = false;
                }
                field("Final Payment (%)"; Rec."Final Payment (%)")
                {
                    ApplicationArea = All;
                    Caption = 'Final Payment (%)';
                    Editable = false;
                }
                field("Payment Method"; Rec."Payment Method")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Method';
                    Editable = false;
                }
                field("Warranty Period (Months)"; Rec."Warranty Period (Months)")
                {
                    ApplicationArea = All;
                    Caption = 'Warranty Period (Months)';
                    Editable = false;
                }
            }
            group("Quality & Compliance")
            {
                Caption = 'Quality & Compliance';
                field("UAE Compliance Requirements"; Rec."UAE Compliance Requirements")
                {
                    ApplicationArea = All;
                    Caption = 'UAE Compliance Requirements';

                    Editable = false;
                }
                field("Industry Standards"; Rec."Industry Standards")
                {
                    ApplicationArea = All;
                    Caption = 'Industry Standards';
                    ShowMandatory = true;
                    Editable = false;
                }

            }

            group("GOVERNING LAW & DISPUTE RESOLUTION")
            {
                Caption = 'Governing Law & Dispute Resolution';


                field("Dispute Resolution"; Rec."Dispute Resolution")
                {
                    ApplicationArea = All;
                    Caption = 'Dispute Resolution';
                    ShowMandatory = true;
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
                    Editable = false;
                }
                field("Contract Start Date"; Rec."Contract Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Duration"; Rec."Duration")
                {
                    ApplicationArea = All;
                    Editable = false;
                }


            }

            group("Vendor Contract Status")
            {
                Caption = 'Vendor Contract Status';
                field("Internal Approval Status"; Rec."Internal Approval Status")
                {
                    ApplicationArea = All;
                    Editable = approvaleditable;
                }
                field("Internal Remarks"; Rec."Internal Remarks")
                {
                    ApplicationArea = All;
                    multiLine = true;
                    Editable = approvaleditable;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Approval Status"; Rec."Vendor Approval Status")
                {
                    ApplicationArea = All;
                    Editable = approvaleditable;
                }
                field("Vendor Remarks"; Rec."Vendor Remarks")
                {
                    ApplicationArea = All;
                    multiLine = true;
                    Editable = approvaleditable;
                }

            }
            part("Pricing Breakdown Grid"; "Pricing Breakdown Grid")
            {
                ApplicationArea = All;
                Caption = 'Pricing Breakdown Grid';
                Visible = true;
                Editable = false;
                SubPageLink = "Vendor Contract ID" = field("Contract ID");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {

        area(Processing)
        {

            action("Submission for Approval")
            {
                ApplicationArea = All;
                Caption = 'Send for Approval';
                Image = Approve;
                Enabled = CanSubmitForApproval;

                trigger OnAction()
                var
                    ApprovalVendorProposal: Codeunit "Approval Vendor Contract";
                begin
                    ApprovalVendorProposal.SubmitVendorContract(Rec);
                    Dialog.Message('✅ Your request has been submitted successfully.');

                end;
            }
            action("Send to Vendor for Approval")
            {
                ApplicationArea = All;
                Caption = 'Send to Vendor for Approval';
                Image = Approve;
                trigger OnAction()
                var
                    VendorContractApprovalVendor: Codeunit VendorContractApprovalVendor;
                begin
                    if (Rec."Vendor Approval Status" = Rec."Vendor Approval Status"::Pending) or
                     (Rec."Vendor Approval Status" = Rec."Vendor Approval Status"::Approved) then begin
                        if Confirm('Are you sure you want to send again this contract for approval?', true) then begin
                            VendorContractApprovalVendor.VendorContractApproval(Rec);
                            Rec."Vendor Approval Status" := Rec."Vendor Approval Status"::Pending;
                            Rec.Modify(true);
                        end;
                    end else begin
                        if Rec."Internal Approval Status" = Rec."Internal Approval Status"::Approved then begin
                            VendorContractApprovalVendor.VendorContractApproval(Rec);
                            Rec."Vendor Approval Status" := Rec."Vendor Approval Status"::Pending;
                            Rec.Modify(true);
                        end else begin
                            Message('Vendor contract must be approved internally before sending to the vendor for approval.');
                        end;

                    end;
                end;
            }
        }
        area(Promoted)
        {
            actionref(submitforapprovaltoprojectmanager; "Submission for Approval")
            {
            }
            actionref(sendtovendortoprojectmanager; "Send to Vendor for Approval")
            {
            }
        }
    }

    // Insert Validation and trigger
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
    begin
        Rec.TestField("Proposal ID");
    end;

    trigger OnAfterGetRecord()
    begin
        // CurrPage."Construction Project Document List Part".Page.SetProjectId(Rec."Project ID");
        approvaleditable := UserApprovalProjectStatus();
        CanSubmitForApproval := (Rec."Internal Approval Status" in [Rec."Internal Approval Status"::Draft, Rec."Internal Approval Status"::Rejected]);
    end;

    procedure UserApprovalProjectStatus(): Boolean
    var
        UserPersonalization: Record "User Personalization";
    begin

        if UserPersonalization.Get(UserSecurityId()) then begin

            case UserPersonalization."Profile ID" of
                'PROJECT MANAGER':
                    exit(true);
                'PROJECT OWNER':
                    exit(false);
                'FINANCE MANAGER':
                    exit(false);
            end;
        end;

        exit(false);
    end;

    var
        approvaleditable: Boolean;
        CanSubmitForApproval: Boolean;

}