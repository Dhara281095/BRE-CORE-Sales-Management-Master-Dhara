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

                        end else begin
                            Rec."Vendor ID" := '';
                            Rec."Vendor Name" := '';
                            Rec."Vendor Email" := '';
                            Rec."Vendor Designation" := '';
                            Rec."Project ID" := '';
                            Rec."Work Scope" := '';
                            Rec."Payment Terms" := '';
                            Rec."Created By" := '';


                        end;
                    end;

                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                    Caption = 'Project Name';
                    Editable = false;
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

                trigger OnAction()
                var
                    ApprovalVendorProposal: Codeunit "Approval Vendor Contract";
                begin
                    ApprovalVendorProposal.SubmitVendorContract(Rec);
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
                     (Rec."Vendor Approval Status" = Rec."Vendor Approval Status"::Approved) then
                        if Confirm('Are you sure you want to submit again this contract for approval?', true) then begin
                            VendorContractApprovalVendor.VendorContractApproval(Rec);
                            Rec."Vendor Approval Status" := Rec."Vendor Approval Status"::Pending;
                            Rec.Modify(true);
                        end else begin
                            VendorContractApprovalVendor.VendorContractApproval(Rec);
                            Rec."Vendor Approval Status" := Rec."Vendor Approval Status"::Pending;
                            Rec.Modify(true);
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
        Rec.TestField("Project ID");
        Rec.TestField("Vendor ID");
    end;

    trigger OnAfterGetRecord()
    begin
        // CurrPage."Construction Project Document List Part".Page.SetProjectId(Rec."Project ID");
        approvaleditable := UserApprovalProjectStatus();
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

}