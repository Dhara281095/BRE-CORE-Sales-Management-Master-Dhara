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

                    trigger OnValidate()
                    var
                        ProjectRec: Record "Construction Project";
                    begin
                        ProjectRec.SetRange("Project ID", Rec."Project ID");
                        if ProjectRec.FindFirst() then begin
                            Rec."Project Name" := ProjectRec."Project Name";

                        end else begin
                            Rec."Project Name" := '';

                        end;
                    end;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                    Caption = 'Project Name';
                    Editable = false;
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
                        VendorRec.SetRange("Profile ID", Rec."Vendor ID");
                        if VendorRec.FindFirst() then begin
                            // Rec."Vendor Name" := VendorRec."Vendor Name";
                            // Rec."Vendor Email" := VendorRec."Email Address";
                            // Rec."Vendor Designation" := VendorRec."Designation"; 
                            Rec."Vendor Name" := VendorRec."Profile Name";
                            Rec."Vendor Email" := VendorRec."Email Address";
                            Rec."Vendor Designation" := VendorRec.Designation;
                            // Change to correct field if needed
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
                field("Created DateTime"; Rec."Created DateTime")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part("Pricing Breakdown Grid"; "Pricing Breakdown Grid")
            {
                ApplicationArea = All;
                Caption = 'Pricing Breakdown Grid';
                Visible = true;
                SubPageLink = "Profile ID" = field("Project ID");
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
                Caption = 'Submit for Approval';
                Image = Approve;
                trigger OnAction()
                var
                    ApprovalVendorProposal: Codeunit "Approval Vendor Proposal";
                begin

                    ApprovalVendorProposal.SubmitVendorProposal(Rec);

                end;
            }
            action("Send to Vendor for Approval")
            {
                ApplicationArea = All;
                Caption = 'Send to Vendor for Approval';
                Image = Approve;
                trigger OnAction()
                var
                    VendorProposalApprovalVendor: Codeunit VendorProposalApprovalVendor;
                begin
                    if (Rec."Vendor Approval Status" = Rec."Vendor Approval Status"::Pending) or
                     (Rec."Vendor Approval Status" = Rec."Vendor Approval Status"::Approved) then begin
                        if Confirm('Are you sure you want to submit again this proposal for approval?', true) then begin
                            VendorProposalApprovalVendor.VendorProposalApproval(Rec);
                            Rec."Vendor Approval Status" := Rec."Vendor Approval Status"::Pending;
                            Rec.Modify(true);
                        end else begin
                            exit;
                        end;

                    end
                    else begin
                        VendorProposalApprovalVendor.VendorProposalApproval(Rec);
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







