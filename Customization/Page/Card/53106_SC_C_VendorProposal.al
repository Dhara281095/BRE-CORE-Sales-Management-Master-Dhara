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
                field("Project Location"; Rec."Project Location")
                {
                    ApplicationArea = All;
                    Caption = 'Project Location';
                    Editable = false;
                }
                field("Proposal Date"; Rec."Proposal Date")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
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

            group("Delivery & Performance")
            {
                Caption = 'Delivery & Performance';
                field("Delivery Location"; Rec."Delivery Location")
                {
                    ApplicationArea = All;
                    Caption = 'Delivery Location';
                }
                field("Delivery Date"; Rec."Delivery Date")
                {
                    ApplicationArea = All;
                    Caption = 'Delivery Date';
                }
                field(Incoterms; Rec.Incoterms)
                {
                    ApplicationArea = All;
                    Caption = 'Incoterms';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        IncotermsList: Page "Incoterms List";
                        incoterms: Record Incoterms;
                        isFirst: Boolean;
                    begin
                        IncotermsList.LookupMode(true);
                        if not (IncotermsList.RunModal() = Action::LookupOK) then
                            exit(false);

                        Text := IncotermsList.GetLookUpValues(IncotermsList, incoterms);
                        exit(true);
                    end;
                }
                field("Late Delivery Penalty %"; Rec."Late Delivery Penalty %")
                {
                    ApplicationArea = All;
                    Caption = 'Late Delivery Penalty %';
                }
            }
            group("Price & Payment Terms")
            {
                Caption = 'Price & Payment Terms';
                field("Total Contract Value (AED)"; Rec."Total Contract Value (AED)")
                {
                    ApplicationArea = All;
                    Caption = 'Total Contract Value (AED)';
                }
                field("Advance Payment (%)"; Rec."Advance Payment (%)")
                {
                    ApplicationArea = All;
                    Caption = 'Advance Payment (%)';
                }
                field("Interim Payment (%)"; Rec."Interim Payment (%)")
                {
                    ApplicationArea = All;
                    Caption = 'Interim Payment (%)';
                }
                field("Final Payment (%)"; Rec."Final Payment (%)")
                {
                    ApplicationArea = All;
                    Caption = 'Final Payment (%)';
                }
                field("Payment Method"; Rec."Payment Method")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Method';
                }
            }
            group("Quality & Compliance")
            {
                Caption = 'Quality & Compliance';
                field("UAE Compliance Requirements"; Rec."UAE Compliance Requirements")
                {
                    ApplicationArea = All;
                    Caption = 'UAE Compliance Requirements';
                    ShowMandatory = true;
                    // TableRelation = "UAE Regulatory Requirements".Name;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        UAERegulatoryList: Page "UAE Regulatory Reqs. List";
                        UAERegulatoryReq: Record "UAE Regulatory Requirements";
                        isFirst: Boolean;
                    begin
                        UAERegulatoryList.LookupMode(true);
                        if not (UAERegulatoryList.RunModal() = Action::LookupOK) then
                            exit(false);

                        Text := UAERegulatoryList.GetLookUpValues(UAERegulatoryList, UAERegulatoryReq);
                        exit(true);
                    end;
                }
                field("Industry Standards"; Rec."Industry Standards")
                {
                    ApplicationArea = All;
                    Caption = 'Industry Standards';
                    ShowMandatory = true;
                    // TableRelation = "Industry Standards".Name;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        industryStandardsList: Page "Industry Standards";
                        industryStandard: Record "Industry Standards";
                        isFirst: Boolean;
                    begin
                        industryStandardsList.LookupMode(true);
                        if not (industryStandardsList.RunModal() = Action::LookupOK) then
                            exit(false);

                        Text := industryStandardsList.GetLookUpValues(industryStandardsList, industryStandard);
                        exit(true);
                    end;
                }

            }
            field("Warranty Period (Months)"; Rec."Warranty Period (Months)")
            {
                ApplicationArea = All;
                Caption = 'Warranty Period (Months)';
            }
            field("Dispute Resolution"; Rec."Dispute Resolution")
            {
                ApplicationArea = All;
                Caption = 'Dispute Resolution';
                ShowMandatory = true;
                TableRelation = GoverningLawDisputeResolution.Name;
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
                    Caption = 'Proposed Contract Start Date';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CalculateDuration();
                    end;
                }
                field("End Date"; Rec."End Date")
                {
                    Caption = 'Proposed Contract End Date';
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
                        if Rec."Internal Approval Status" = Rec."Internal Approval Status"::Approved then begin
                            VendorProposalApprovalVendor.VendorProposalApproval(Rec);
                            Rec."Vendor Approval Status" := Rec."Vendor Approval Status"::Pending;
                            Rec.Modify(true);
                        end else begin
                            Message('Vendor proposal must be approved internally before sending to the vendor for approval.');
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

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.TestField("Project ID");
        Rec.TestField("Vendor ID");
        Rec."Proposal Date" := Today;
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







