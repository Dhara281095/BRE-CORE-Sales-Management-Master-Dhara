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
            group("Task Details")
            {
                Caption = 'Task Details';
                field("Task ID"; Rec."Task ID")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        TaskRec: Record "Project Milestone Task";
                    begin
                        TaskRec.SetRange("Task ID", Rec."Task ID");
                        if TaskRec.FindFirst() then begin
                            Rec."Task Name" := TaskRec."Task Name";
                            Rec."Task Start Date" := TaskRec."Start Date";
                            Rec."Task End Date" := TaskRec."End Date";
                            Rec."Task Description" := TaskRec."Description";
                            Rec.Notes := TaskRec.Notes;
                            Rec."Milestone ID" := TaskRec."Milestone ID";
                        end else begin
                            Rec."Task Name" := '';
                            Rec."Task Start Date" := 0D;
                            Rec."Task End Date" := 0D;
                            Rec."Task Description" := '';
                            Rec.Notes := '';
                            Rec."Milestone ID" := '';
                        end;
                    end;
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
                    trigger OnValidate()
                    begin
                        CalculateDuration();
                    end;
                }
                field("End Date"; Rec."End Date")
                {
                    Caption = 'Proposal End Date';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CalculateDuration();
                    end;
                }
                field("Duration"; Rec."Duration")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                SubPageLink = "Vendor Proposal ID" = field("Proposal ID");
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
                Caption = 'Submit for Approval';
                Image = Approve;
                trigger OnAction()
                var
                    ApprovalVendorProposal: Codeunit "Approval Vendor Proposal";
                begin

                    ApprovalVendorProposal.SubmitVendorProposal(Rec);
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
                    VendorProposalApprovalVendor: Codeunit VendorProposalApprovalVendor;
                begin
                    if (Rec."Vendor Approval Status" = Rec."Vendor Approval Status"::Pending) or
                     (Rec."Vendor Approval Status" = Rec."Vendor Approval Status"::Approved) then begin
                        if Confirm('Are you sure you want to send again this proposal for approval?', true) then begin
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

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.TestField("Project ID");
        Rec.TestField("Task ID");
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

    // Calculate the duration based on start and end dates
    procedure CalculateDuration()
    var
        ProposalStartDate: Date;
        ProposalEndDate: Date;
        Years: Integer;
        Months: Integer;
        Days: Integer;
        DurationText: Text[50];
        TempStartDate: Date;
        DaysDifference: Integer;
    begin
        ProposalStartDate := Rec."Start Date";
        ProposalEndDate := Rec."End Date";
        if (ProposalStartDate <> 0D) and (ProposalEndDate <> 0D) then begin
            if ProposalEndDate >= ProposalStartDate then begin
                // Calculate total days difference
                DaysDifference := ProposalEndDate - ProposalStartDate + 1;

                // If the difference is exactly 365 or 366 days (accounting for leap year)
                if (DaysDifference = 365) or (DaysDifference = 366) then begin
                    Years := 1;
                    Months := 0;
                    Days := 0;
                end else begin
                    TempStartDate := ProposalStartDate;

                    // Calculate the years
                    Years := 0;
                    while (CALCDATE('<+1Y>', TempStartDate) <= ProposalEndDate) or
                          (CALCDATE('<+1Y-1D>', TempStartDate) = ProposalEndDate) do begin
                        TempStartDate := CALCDATE('<+1Y>', TempStartDate);
                        Years := Years + 1;
                    end;

                    // Calculate the months
                    Months := 0;
                    while CALCDATE('<+1M>', TempStartDate) <= ProposalEndDate do begin
                        TempStartDate := CALCDATE('<+1M>', TempStartDate);
                        Months := Months + 1;
                    end;

                    // Calculate the remaining days
                    Days := ProposalEndDate - TempStartDate + 1;
                end;

                // Build the duration text
                DurationText := '';
                if Years > 0 then
                    DurationText := Format(Years) + ' year(s) ';

                if Months > 0 then
                    DurationText := DurationText + Format(Months) + ' month(s) ';

                if Days > 0 then
                    DurationText := DurationText + Format(Days) + ' day(s)';

                Rec."Duration" := DelChr(DurationText, '<>', ' ');
            end else
                Rec."Duration" := '';
        end else
            Rec."Duration" := '';
    end;
    //-------------Calculate Lease Duration--------------//
    // Trasfer from Table End

}







