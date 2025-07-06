page 53753 "Vendor Assignment"
{
    PageType = Card;
    SourceTable = "Vendor Assignment";
    ApplicationArea = All;
    Caption = 'Vendor Assignment';

    layout
    {
        area(Content)
        {
            group(ProjectDetails)
            {
                Caption = 'Project Details';
                field("Assignment ID"; Rec."Assignment ID")
                {
                    ApplicationArea = All;
                }
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
            }
            group(ContractDetails)
            {
                Caption = 'Contract Details';
                field("Contract ID"; Rec."Contract ID")
                {
                    ApplicationArea = All;
                }
                field("Contract Date"; Rec."Contract Date")
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

                field("Remark On Rejection"; Rec."Remark On Rejection")
                {
                    ApplicationArea = All;
                }
                field("Contract Template"; Rec."Contract Template")
                {
                    ApplicationArea = All;
                }
                field("Contract File"; Rec."Contract File")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        azureBlobUploader: Codeunit "Azure AD Blob Storage";
                        fileName: Text;
                        folderName: Text;
                        uploadResult: Text;
                    begin
                        folderName := 'ConstructionContracts';
                        fileName := azureBlobUploader.ValidateDocument(uploadResult, folderName);
                        if fileName <> '' then begin
                            Rec."Contract File" := uploadResult;
                            Rec.Modify();
                            Message('File uploaded successfully: %1', fileName);
                        end;
                    end;
                }
                field("Contract Notes"; Rec."Contract Notes")
                {
                    ApplicationArea = All;
                }
            }

            group(VendorDetails)
            {
                Caption = 'Vendor/Subcontractor Details';
                field("ID"; Rec."Vendor/Subcontractor ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Name"; Rec."Vendor/Subcontractor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Email"; Rec."Vendor Email")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(ProjectMilestoneTask; "Project Milestone Tasks")
            {
                Editable = false;
                SubPageLink = "Contract ID" = field("Contract ID");
            }
            group(FinancialDetails)
            {
                Caption = 'Financial Details';
                field("Total Contract Amount"; Rec."Total Contract Amount")
                {
                    ApplicationArea = All;
                }
                field("Payment Schedule"; Rec."Payment Schedule")
                {
                    ApplicationArea = All;
                }
                field("Payment Method"; Rec."Payment Method")
                {
                    ApplicationArea = All;
                }
            }
            group(WorkDetails)
            {
                Caption = 'Work Scope and Timelines';
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
            }
            group(ApprovalDetails)
            {
                Caption = 'Approval Details';

                field("Vendor Assignment Status"; Rec."Vendor Assignment Status")
                {
                    ApplicationArea = All;
                }

                field("Remark"; Rec."Remark")
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
            group(QualityNCompliance)
            {
                Caption = 'Quality & Compliance';
                field("UAE Regulatory Requirements"; Rec."UAE Regulatory Requirements")
                {
                    ApplicationArea = All;
                }
                field("Industry Standards"; Rec."Industry Standards")
                {
                    ApplicationArea = All;
                }
            }
            group(Miscellaneous)
            {
                field("Delivery Schedule"; Rec."Delivery Schedule")
                {
                    ApplicationArea = All;
                }
                field("Work SPecifications"; Rec."Work SPecifications")
                {
                    ApplicationArea = All;
                }
                field("Penalty Clauses"; Rec."Penalty Clauses")
                {
                    ApplicationArea = All;
                }
                field(Incoterms; Rec.Incoterms)
                {
                    ApplicationArea = All;
                }
                field("Warranty Period"; Rec."Warranty Period")
                {
                    ApplicationArea = All;
                    Caption = 'Warranty Period (Months)';
                }
                field("Governing Law & Dispute Rsln."; Rec."Governing Law & Dispute Rsln.")
                {
                    Caption = 'Governing Law & Dispte Resolution';
                    ApplicationArea = All;
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
                    ApprovalVendorProposal: Codeunit "Vendor Assignment Approval";
                begin
                    ApprovalVendorProposal.SubmitVendorAssignment(Rec);
                    Dialog.Message('✅ Your request has been submitted successfully.');
                end;
            }

            action("Change Vendor Assignment Status")
            {
                ApplicationArea = All;
                Caption = 'Change Vendor Assignment Status';
                Image = Action;
                Visible = IsPropertyManager;

                trigger OnAction()
                var
                    selectedOption: Integer;
                begin

                    if not (Rec."Vendor Assignment Status" in [Rec."Vendor Assignment Status"::Approved, Rec."Vendor Assignment Status"::Suspended, Rec."Vendor Assignment Status"::Active]) then begin
                        Message('You can only change the Vendor Assignment Status if it is Approved , Active  or Suspended.');
                        exit;
                    end;


                    selectedOption := Dialog.StrMenu('Activate  Vendor Assignment Status, Suspend Vendor Assignment Status', 1);
                    case selectedOption of
                        1:
                            begin
                                Rec."Vendor Assignment Status" := Rec."Vendor Assignment Status"::Active;
                                Rec.Modify();
                                Message('Vendor Assignment Status has been updated to Active.');
                            end;
                        2:
                            begin
                                Rec."Vendor Assignment Status" := Rec."Vendor Assignment Status"::Suspended;
                                Rec.Modify();
                                Message('Vendor Assignment Status has been updated to Suspended.');
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
            actionref(submitforapprovaltoprojectmanager1; "Change Vendor Assignment Status")
            {
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        // CurrPage."Construction Project Document List Part".Page.SetProjectId(Rec."Project ID");

        CanSubmitForApproval := (Rec."Vendor Assignment Status" in [Rec."Vendor Assignment Status"::Draft, Rec."Vendor Assignment Status"::Rejected]);
    end;


    trigger OnOpenPage()
    begin
        IsPropertyManager := CheckUserRole();
    end;

    procedure CheckUserRole(): Boolean
    var
        UserPersonalization: Record "User Personalization";
    begin
        if UserPersonalization.Get(UserSecurityId()) then begin
            case UserPersonalization."Profile ID" of
                'PROJECT MANAGER':
                    exit(true);  // Only property managers can approve/reject
                else
                    exit(false);
            end;
        end;
        exit(false);
    end;

    var
        IsPropertyManager: Boolean;
        CanSubmitForApproval: Boolean;
}
