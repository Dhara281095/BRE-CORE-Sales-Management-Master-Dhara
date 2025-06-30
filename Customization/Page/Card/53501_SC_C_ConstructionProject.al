page 53501 "Construction Project"
{
    PageType = Card;
    SourceTable = "Construction Project";
    ApplicationArea = All;
    Caption = 'Construction Project Card';
    RefreshOnActivate = true;
    UsageCategory = Administration;
    layout
    {
        area(Content)
        {
            group("Project Details")
            {
                Caption = 'Project Details';
                field("Project ID"; Rec."Project ID")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Project Type"; Rec."Project Type")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Project Status"; Rec."Project Status")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                    Editable = approvaleditable;
                    trigger OnValidate()
                    var
                        dialogboxConstProjectRejection: Codeunit DialogboxConstProjectRejection;
                    begin
                        if Rec."Approval Status" = Rec."Approval Status"::Rejected then begin
                            dialogboxConstProjectRejection.DialogboxForRejection(Rec);
                        end;
                    end;

                }
                field("Reason for Rejection"; Rec."Reason for Rejection")
                {
                    Editable = approvaleditable;
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;

                }

            }

            group("Project Scope")
            {
                Caption = 'Project Scope';
                group("")
                {
                    Caption = ' ';
                    field("Description"; Rec."Description")
                    {
                        ApplicationArea = All;
                        MultiLine = true;


                    }
                }

                field("Objectives"; Rec."Objectives")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Additional Notes"; Rec."Additional Notes")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }

            group("Project Location")
            {
                Caption = 'Project Location';
                field("Address Line 1"; Rec."Address Line 1")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Address Line 2"; Rec."Address Line 2")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                }
                field("Latitude"; Rec."Latitude")
                {
                    ApplicationArea = All;
                }
                field("Longitude"; Rec."Longitude")
                {
                    ApplicationArea = All;
                }
                field("Location Link"; Rec."Location Link")
                {
                    ApplicationArea = All;
                }
            }

            group("Timeline")
            {
                Caption = 'Timeline';
                field("Planned Start Date"; Rec."Planned Start Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Planned End Date"; Rec."Planned End Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Actual Start Date"; Rec."Actual Start Date")
                {
                    ApplicationArea = All;
                }
                field("Final Completion Date"; Rec."Final Completion Date")
                {
                    ApplicationArea = All;
                }
            }
            part("Project Milestone List Part"; "Project Milestone List Part")
            {
                ApplicationArea = All;
                Caption = 'Project Milestones';
                Visible = true;
                SubPageLink = "Project ID" = field("Project ID");
                UpdatePropagation = Both;
            }

            part("Project Milestone Tasks"; "Project Milestone Task LP")
            {
                ApplicationArea = All;
                Caption = 'Milestone Tasks';
                Visible = true;
                Provider = "Project Milestone List Part";
                SubPageLink = "Milestone ID" = field("Milestone ID");
                UpdatePropagation = Both;
            }

            part("Project Milestone Sub Tasks"; "Project Milestone Sub Task LP")
            {
                ApplicationArea = All;
                Caption = 'Milestone Sub Tasks';
                Visible = true;
                Provider = "Project Milestone Tasks";
                SubPageLink = "Task ID" = field("Task ID");
                UpdatePropagation = Both;
            }

            group("Performance Metrics")
            {
                Caption = 'Performance Metrics';
                field("Progress Percentages"; Rec."Progress Percentages")
                {
                    ApplicationArea = All;
                    // ShowMandatory = true;
                    Editable = false;

                }
            }

            group("Financial Details")
            {
                Caption = 'Financial Details';
                field("Approved Budget"; Rec."Approved Budget")
                {
                    ApplicationArea = All;
                }
                field("Estimated Cost Breakdown"; Rec."Estimated Cost Breakdown")
                {
                    ApplicationArea = All;
                }
                field("Funding Source"; Rec."Funding Source")
                {
                    ApplicationArea = All;
                }
                field("Current Spends Tracking"; Rec."Current Spends Tracking")
                {
                    ApplicationArea = All;
                }
            }

            group("Responsible Parties")
            {
                Caption = 'Responsible Parties';
                field("Project Owner"; Rec."Project Owner")
                {
                    ApplicationArea = All;
                }
                field("Primary Contractor"; Rec."Primary Contractor")
                {
                    ApplicationArea = All;
                }
                field("Project Manager"; Rec."Project Manager")
                {
                    ApplicationArea = All;
                }
            }
            part("Construction Project Document List Part"; "Construction Project Documents")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Project Documents';
                Visible = true;
                SubPageLink = "Project ID" = field("Project ID");
            }
            group("Construction Specifications")
            {
                Caption = 'Construction Specifications';
                field("Building Type or Classification"; Rec."Building Type/Classification")
                {
                    ApplicationArea = All;
                }
                field("UOM"; Rec."UOM")
                {
                    ApplicationArea = All;
                }
                field("Number of Floors"; Rec."Number of Floors")
                {
                    ApplicationArea = All;
                }
                field("Construction Materials"; Rec."Construction Materials")
                {
                    ApplicationArea = All;
                }
            }

            group("Stakeholders")
            {
                Caption = 'Stakeholders';
                field("Architect/Design Firm"; Rec."Architect/Design Firm")
                {
                    ApplicationArea = All;
                }
                field("Subcontractors List"; Rec."Subcontractors List")
                {
                    ApplicationArea = All;
                }
                field("Key Consultants"; Rec."Key Consultants")
                {
                    ApplicationArea = All;
                }
            }

            group("Extended Timeline")
            {
                Caption = 'Extended Timeline';
                field("Design Completion Date"; Rec."Design Completion Date")
                {
                    ApplicationArea = All;
                }
                field("Permit Approval Date"; Rec."Permit Approval Date")
                {
                    ApplicationArea = All;
                }
                field("Substantial Completion Date"; Rec."Substantial Completion Date")
                {
                    ApplicationArea = All;
                }
                field("Extended Final Completion Date"; Rec."Extended Final Completion Date")
                {
                    ApplicationArea = All;
                }
            }

            // group(ContractAssignment)
            // {
            //     Caption = 'Contract Assignment';

            //     part("Contract Assignment List Part"; "Contract Assignment List Part")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Contract Assignments';
            //         Visible = true;
            //         Editable = false;
            //         SubPageLink = "Project ID" = field("Project ID");
            //     }
            // }
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
                    ConstructionProjectApproval: Codeunit ConstructionProjectApproval;
                begin
                    ConstructionProjectApproval.ConstructionProApproval(Rec);
                    Rec."Approval Status" := Rec."Approval Status"::Pending;
                    Rec.Modify(true);
                end;
            }

        }
        area(Promoted)
        {
            actionref(submitforapprovaltoprojectmanager; "Submission for Approval")
            {
            }
        }
    }


    // Insert Validation and trigger 
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
    begin
        Rec.TestField("Project Name");
        Rec.TestField("Planned Start Date");
        Rec.TestField("Planned End Date");
        Rec.TestField("Project Status");

        Rec.TestField("Address Line 1");
        Rec.TestField("Address Line 2");
        Rec.TestField("Postal Code");

        // CurrPage."Construction Project Document List Part".Page.SetProjectId(Rec."Project ID");
    end;

    trigger OnModifyRecord(): Boolean
    begin
        // CurrPage."Construction Project Document List Part".Page.SetProjectId(Rec."Project ID");
    end;

    trigger OnAfterGetRecord()
    begin
        // CurrPage."Construction Project Document List Part".Page.SetProjectId(Rec."Project ID");
        approvaleditable := UserApprovalProjectStatus();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        Rec.RecalculateProgress();
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