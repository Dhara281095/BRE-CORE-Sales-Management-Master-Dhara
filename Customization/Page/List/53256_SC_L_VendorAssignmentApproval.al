page 53256 "Vendor Assignment Approval"
{
    PageType = List;
    SourceTable = "Vendor Assignment Approval";
    ApplicationArea = All;
    Caption = 'Vendor Assignment Approval List';
    UsageCategory = Lists;
    InsertAllowed = false;
    ModifyAllowed = false;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
                field("Vendor Assignment ID"; Rec."Vendor Assignment ID")
                {
                    ApplicationArea = All;
                    // DrillDown trigger to navigate to the Tenancy Contract Card
                    trigger OnDrillDown()
                    var
                        TenancyContractRec: Record "Vendor Assignment"; // Replace with the correct table name for Tenancy Contract
                    begin
                        // Debugging: Log the Contract ID value
                        Message('Checking Vendor Assignment ID: %1', Rec."Vendor Assignment ID");

                        // Use SetRange and FindFirst to locate the record
                        TenancyContractRec.SetRange("Assignment ID", Rec."Vendor Assignment ID");

                        if TenancyContractRec.FindFirst() then begin
                            // Record found, open the Tenancy Contract Card page
                            PAGE.Run(PAGE::"Vendor Assignment", TenancyContractRec); // Replace with the correct card page ID or name
                        end else begin
                            // Record not found
                            Message('The selected Vendor Assignment ID (%1) does not exist in the Vendor Assignment Table.', Rec."Vendor Assignment ID");
                        end;
                    end;


                }
                field(Remark; Rec.Remark)
                {
                    ApplicationArea = All;
                }
                field("Vendor ID"; Rec."Vendor ID")
                {
                    ApplicationArea = All;
                }
                field("Contract ID"; Rec."Contract ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {

            action(Approve)
            {
                Caption = 'Approve';
                ApplicationArea = All;
                Image = Approve;
                Visible = IsPropertyManager;

                trigger OnAction()
                var
                    SelectedRec: Record "Vendor Assignment Approval";
                    VendorProposalRec: Record "Vendor Assignment";
                begin
                    if Rec.Status = 'Pending' then begin
                        SelectedRec := Rec;
                        SelectedRec.Status := 'Approved';
                        SelectedRec.Modify();

                        // Update all Vendor Proposal records with matching Proposal ID
                        VendorProposalRec.SetRange("Assignment ID", SelectedRec."Vendor Assignment ID");
                        if VendorProposalRec.FindSet() then begin
                            repeat
                                VendorProposalRec."Contract Status" := VendorProposalRec."Contract Status"::Approved;
                                VendorProposalRec."Approved By" := GetCurrentUserName();
                                VendorProposalRec."Reviewed By" := GetCurrentUserName();
                                VendorProposalRec."Approval Date" := Today;
                                VendorProposalRec.Modify();
                            until VendorProposalRec.Next() = 0;
                        end;


                        Commit();
                        CurrPage.Update();
                        Message('Request Approved Successfully');
                    end else
                        Message('Selected record is not in "Pending" status.');
                end;
            }

            action(Reject)
            {
                Caption = 'Reject';
                ApplicationArea = All;
                Image = Reject;
                Visible = IsPropertyManager;

                trigger OnAction()
                var
                    SelectedRec: Record "Vendor Assignment Approval";
                    VendorProposalRec: Record "Vendor Assignment";
                    RemarkDialog: Page "DialogBoxForInvoiceRejection";
                    RemarkText: Text;
                    DialogResult: Action;
                begin
                    if Rec.Status = 'Pending' then begin
                        DialogResult := RemarkDialog.RunModal();

                        if DialogResult = Action::OK then begin
                            RemarkText := RemarkDialog.GetReason();

                            if RemarkText <> '' then begin
                                // Update in approval table
                                SelectedRec := Rec;
                                SelectedRec.Status := 'Declined';
                                SelectedRec.Remark := RemarkText;
                                SelectedRec.Modify();

                                // Update in vendor proposal table
                                VendorProposalRec.SetRange("Assignment ID", SelectedRec."Vendor Assignment ID");
                                if VendorProposalRec.FindSet() then begin
                                    repeat
                                        VendorProposalRec."Remark On Rejection" := RemarkText;
                                        VendorProposalRec."Contract Status" := VendorProposalRec."Contract Status"::Rejected;
                                        VendorProposalRec."Approved By" := GetCurrentUserName();
                                        VendorProposalRec."Reviewed By" := GetCurrentUserName();
                                        VendorProposalRec."Approval Date" := Today;
                                        VendorProposalRec.Modify();
                                    until VendorProposalRec.Next() = 0;
                                end;

                                Commit();
                                CurrPage.Update();
                                Message('Request Rejected with Remark.');
                            end;
                        end;
                    end else
                        Message('Selected record is not in "Pending" status.');
                end;
            }
        }




        area(navigation)
        {
            action("Open Vendor Assignment")
            {
                Caption = 'Open Vendor Assignment';
                ApplicationArea = All;
                Image = OpenRecord;

                trigger OnAction()
                var
                    TenancyContractRec: Record "Vendor Assignment"; // Replace with the correct table name for Tenancy Contract
                begin
                    // Debugging: Log the Contract ID value
                    Message('Checking Contract ID: %1', Rec."Vendor Assignment ID");

                    // Use SetRange and FindFirst to locate the record
                    TenancyContractRec.SetRange("Assignment ID", Rec."Vendor Assignment ID");

                    if TenancyContractRec.FindFirst() then begin
                        // Record found, open the Tenancy Contract Card page
                        PAGE.Run(PAGE::"Vendor Assignment", TenancyContractRec); // Replace with the correct card page ID or name
                    end else begin
                        // Record not found
                        Message('The selected Vendor Assignment(%1) does not exist in the Vendor Assignment table.', Rec."Vendor Assignment ID");
                    end;
                end;
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

    local procedure GetCurrentUserName(): Text[100]
    var
        User: Record User;
    begin
        if User.Get(UserSecurityId()) then
            exit(User."Full Name");
        exit(UserId()); // fallback to user ID
    end;
}

