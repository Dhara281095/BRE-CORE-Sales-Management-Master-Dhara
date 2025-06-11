page 53753 "Contract Assignment"
{
    PageType = Card;
    SourceTable = "Contract Assignment";
    ApplicationArea = All;
    Caption = 'Contract Assignment';

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
                        uploadAttachment: Codeunit UploadAttachment;
                        fileName: Text;
                        uploadResult: Text;
                    begin
                        fileName := uploadAttachment.UploadDocument(uploadResult);
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
        }
    }
}