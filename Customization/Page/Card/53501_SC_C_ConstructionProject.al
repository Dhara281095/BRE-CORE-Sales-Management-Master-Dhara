page 53501 "Construction Project"
{
    PageType = Card;
    SourceTable = "Construction Project";
    ApplicationArea = All;
    Caption = 'Construction Project Card';
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
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Project type"; Rec."Project type")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Project status"; Rec."Project status")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
            }

            group("Project scope")
            {
                Caption = 'Project scope';
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                }
                field("Objectives"; Rec."Objectives")
                {
                    ApplicationArea = All;
                }
                field("Additional Notes"; Rec."Additional Notes")
                {
                    ApplicationArea = All;
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
                field("Postal code"; Rec."Postal code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                }
                field("latitude"; Rec."latitude")
                {
                    ApplicationArea = All;
                }
                field("longitude"; Rec."longitude")
                {
                    ApplicationArea = All;
                }
                field("Location link"; Rec."Location link")
                {
                    ApplicationArea = All;
                }
            }

            group("Timeline")
            {
                Caption = 'Timeline';
                field("Planned start date"; Rec."Planned start date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Planned end Date"; Rec."Planned end Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Actual start date"; Rec."Actual start date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Final completion date"; Rec."Final completion date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
            }

            group("Performance Metrics")
            {
                Caption = 'Performance Metrics';
                field("Progress percentages"; Rec."Progress percentages")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                }
            }

            group("Financial Details")
            {
                Caption = 'Financial Details';
                field("Approved budget"; Rec."Approved budget")
                {
                    ApplicationArea = All;
                }
                field("Estimated cost breakdown"; Rec."Estimated cost breakdown")
                {
                    ApplicationArea = All;
                }
                field("Funding source"; Rec."Funding source")
                {
                    ApplicationArea = All;
                }
                field("Current spends tracking"; Rec."Current spends tracking")
                {
                    ApplicationArea = All;
                }
            }

            group("Responsible Parties")
            {
                Caption = 'Responsible Parties';
                field("Project owner"; Rec."Project owner")
                {
                    ApplicationArea = All;
                }
                field("Primary contractor"; Rec."Primary contractor")
                {
                    ApplicationArea = All;
                }
                field("Project manager"; Rec."Project manager")
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
                field("Number of floors"; Rec."Number of floors")
                {
                    ApplicationArea = All;
                }
                field("Construction materials"; Rec."Construction materials")
                {
                    ApplicationArea = All;
                }
            }

            group("Stakeholders")
            {
                Caption = 'Stakeholders';
                field("Architect/design firm"; Rec."Architect/design firm")
                {
                    ApplicationArea = All;
                }
                field("Subcontractors list"; Rec."Subcontractors list")
                {
                    ApplicationArea = All;
                }
                field("Key consultants"; Rec."Key consultants")
                {
                    ApplicationArea = All;
                }
            }

            group("Extended Timeline")
            {
                Caption = 'Extended Timeline';
                field("Design completion date"; Rec."Design completion date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Permit approval date"; Rec."Permit approval date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Substantial completion date"; Rec."Substantial completion date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Extended Final completion date"; Rec."Extended Final completion date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
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

            // group("Milestone Details")
            // {
            //     Caption = 'Milestone Details';
            //     field("Milestone No."; Rec."Milestone ID")
            //     {
            //         ApplicationArea = All;

            //     }
            //     field("Milestone Name"; Rec."Milestone Name")
            //     {
            //         ApplicationArea = All;

            //     }
            //     field("Milestone Start Date"; Rec."Milestone Start Date")
            //     {
            //         ApplicationArea = All;

            //     }
            //     field("Milestone End Date"; Rec."Milestone End Date")
            //     {
            //         ApplicationArea = All;

            //     }
            // }
            // group("Task Details")
            // {
            //     Caption = 'Task Details';
            //     field("Task No."; Rec."Task ID")
            //     {
            //         ApplicationArea = All;

            //     }
            //     field("Task Name"; Rec."Task Name")
            //     {
            //         ApplicationArea = All;

            //     }
            //     field("Task Start Date"; Rec."Task Start Date")
            //     {
            //         ApplicationArea = All;

            //     }
            //     field("Task End Date"; Rec."Task End Date")
            //     {
            //         ApplicationArea = All;

            //     }
            // }
            // group("Issue Tracking")
            // {
            //     Caption = 'Issue Tracking';
            //     field("Issue No."; Rec."Issue ID")
            //     {
            //         ApplicationArea = All;

            //     }
            //     field("Issue Description"; Rec."Issue Description")
            //     {
            //         ApplicationArea = All;

            //     }
            //     field("Issue Status"; Rec."Issue Status")
            //     {
            //         ApplicationArea = All;

            //     }
            //     field("Issue Notes"; Rec."Issue Notes")
            //     {
            //         ApplicationArea = All;

            //     }
            // }
            // group("Progress Reporting")
            // {
            //     Caption = 'Progress Reporting';
            //     field("Report ID"; Rec."Report ID")
            //     {
            //         ApplicationArea = All;

            //     }
            //     field("Report Date"; Rec."Report Date")
            //     {
            //         ApplicationArea = All;

            //     }
            //     field("Report Type"; Rec."Report Type")
            //     {
            //         ApplicationArea = All;

            //     }
            //     field("Report File"; Rec."Report File")
            //     {

            //         ApplicationArea = All;

            //     }
            //     field("Report Notes"; Rec."Report Notes")
            //     {
            //         ApplicationArea = All;

            //     }
            // }
        }
    }

    // Insert Validation and trigger 
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
    begin
        Rec.TestField("Project Name");
        Rec.TestField("Planned start Date");
        Rec.TestField("Planned end Date");
        CurrPage."Construction Project Document List Part".Page.SetOwnerId(Rec."Project ID");
    end;

    trigger OnModifyRecord(): Boolean
    begin
        CurrPage."Construction Project Document List Part".Page.SetOwnerId(Rec."Project ID");
    end;

    trigger OnAfterGetRecord()
    begin
        CurrPage."Construction Project Document List Part".Page.SetOwnerId(Rec."Project ID");
    end;
}