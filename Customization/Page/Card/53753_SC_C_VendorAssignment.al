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
            group(VendorDetails)
            {
                Caption = 'Vendor/Subcontractor Details';
                field("ID"; Rec."Vendor/Subcontractor ID")
                {
                    ApplicationArea = All;
                }
                field("Name"; Rec."Vendor/Subcontractor Name")
                {
                    ApplicationArea = All;
                }
                field("Contact"; Rec."Vendor Contact")
                {
                    ApplicationArea = All;
                }
                field("Email"; Rec."Vendor Email")
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
                }
                field("Governing Law & Dispute Rsln."; Rec."Governing Law & Dispute Rsln.")
                {
                    Caption = 'Governing Law & Dispte Resolution';
                    ApplicationArea = All;
                }
            }

            group("Task Details")
            {
                Caption = 'Task Details';
                field("Task ID"; Rec."Task ID")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;

                }
                field("Milestone ID"; Rec."Milestone ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Milestone ID';
                }
                field("Task Name"; Rec."Task Name")
                {
                    ApplicationArea = All;
                    Caption = 'Task Name';
                    Editable = false;
                }
                field("Task Start Date"; Rec."Task Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Task Start Date';
                    Editable = false;
                }
                field("Task End Date"; Rec."Task End Date")
                {
                    ApplicationArea = All;
                    Caption = 'Task End Date';
                    Editable = false;
                }
                field("Task Description"; Rec."Task Description")
                {
                    ApplicationArea = All;
                    Caption = 'Task Description';
                    Editable = false;
                    MultiLine = true;

                }
                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                    Caption = 'Notes';
                    Editable = false;
                    MultiLine = true;
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
                    ApprovalVendorProposal: Codeunit "Vendor Assignment Approval";
                begin
                    ApprovalVendorProposal.SubmitVendorAssignment(Rec);
                    Dialog.Message('✅ Your request has been submitted successfully.');
                end;
            }

            action("Change Contract Status")
            {
                ApplicationArea = All;
                Caption = 'Change Contract Status';
                Image = Action;
                Visible = IsPropertyManager;

                trigger OnAction()
                var
                    selectedOption: Integer;
                begin

                    if not (Rec."Contract Status" in [Rec."Contract Status"::Approved, Rec."Contract Status"::Suspended]) then begin
                        Message('You can only change the contract status if it is Approved or Suspended.');
                        exit;
                    end;


                    selectedOption := Dialog.StrMenu('Activate Contract, Suspend Contract', 1);
                    case selectedOption of
                        1:
                            begin
                                Rec."Contract Status" := Rec."Contract Status"::Active;
                                Rec.Modify();
                                Message('Contract status has been updated to Active.');
                            end;
                        2:
                            begin
                                Rec."Contract Status" := Rec."Contract Status"::Suspended;
                                Rec.Modify();
                                Message('Contract status has been updated to Suspended.');
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
            actionref(submitforapprovaltoprojectmanager1; "Change Contract Status")
            {
            }

        }
    }



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
}
