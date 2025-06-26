page 53255 "Vendor Contract Approval List"
{
    PageType = List;
    SourceTable = "Vendor Contract Approval";
    ApplicationArea = All;
    Caption = 'Vendor Contract Approval List';
    UsageCategory = Lists;
    // CardPageId = 50320;

    // InsertAllowed = false;
    // ModifyAllowed = false;
    // DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
                field("Vendor Contract ID"; Rec."Vendor Contract ID")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        TenancyContractRec: Record "Vendor Contract"; // Replace with the correct table name for Tenancy Contract
                    begin
                        // Debugging: Log the Contract ID value
                        Message('Checking Contract ID: %1', Rec."Vendor Contract ID");

                        // Use SetRange and FindFirst to locate the record
                        TenancyContractRec.SetRange("Proposal ID", Rec."Vendor Contract ID");

                        if TenancyContractRec.FindFirst() then begin
                            // Record found, open the Tenancy Contract Card page
                            PAGE.Run(PAGE::"Vendor Proposal", TenancyContractRec); // Replace with the correct card page ID or name
                        end else begin
                            // Record not found
                            Message('The selected Contract ID (%1) does not exist in the Tenancy Contract table.', Rec."Vendor Contract ID");
                        end;
                    end;
                }

                field("Vendor ID"; Rec."Vendor ID")
                {
                    ApplicationArea = All;
                }



                field("Remark"; Rec."Remark")
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
                    SelectedRec: Record "Vendor Contract Approval";
                    VendorProposalRec: Record "Vendor Contract";
                begin
                    if Rec.Status = 'Pending' then begin
                        SelectedRec := Rec;
                        SelectedRec.Status := 'Approved';
                        SelectedRec.Modify();

                        // Update all Vendor Proposal records with matching Proposal ID
                        VendorProposalRec.SetRange("Contract ID", SelectedRec."Vendor Contract ID");
                        if VendorProposalRec.FindSet() then begin
                            repeat
                                VendorProposalRec."Internal Approval Status" := VendorProposalRec."Internal Approval Status"::Approved;
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
                    SelectedRec: Record "Vendor Contract Approval";
                    VendorProposalRec: Record "Vendor Contract";
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
                                VendorProposalRec.SetRange("Contract ID", SelectedRec."Vendor Contract ID");
                                if VendorProposalRec.FindSet() then begin
                                    repeat
                                        VendorProposalRec."Internal Remarks" := RemarkText;
                                        VendorProposalRec."Internal Approval Status" := VendorProposalRec."Internal Approval Status"::Rejected;
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

