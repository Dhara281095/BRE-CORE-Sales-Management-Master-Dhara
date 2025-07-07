page 53253 "Vendor Proposal Approval List"
{
    PageType = List;
    SourceTable = "Vendor Proposal Approval";
    ApplicationArea = All;
    Caption = 'Vendor Proposal Approval List';
    UsageCategory = Lists;
    // CardPageId = 50320;

    InsertAllowed = false;
    ModifyAllowed = false;
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
                field("Vendor Proposal ID"; Rec."Vendor Proposal ID")
                {
                    ApplicationArea = All;

                    // DrillDown trigger to navigate to the Tenancy Contract Card
                    trigger OnDrillDown()
                    var
                        TenancyContractRec: Record "Vendor Proposal"; // Replace with the correct table name for Tenancy Contract
                    begin
                        // Debugging: Log the Contract ID value
                        Message('Checking Proposal ID: %1', Rec."Vendor Proposal ID");

                        // Use SetRange and FindFirst to locate the record
                        TenancyContractRec.SetRange("Proposal ID", Rec."Vendor Proposal ID");

                        if TenancyContractRec.FindFirst() then begin
                            // Record found, open the Tenancy Contract Card page
                            PAGE.Run(PAGE::"Vendor Proposal", TenancyContractRec); // Replace with the correct card page ID or name
                        end else begin
                            // Record not found
                            Message('The selected Contract ID (%1) does not exist in the Tenancy Contract table.', Rec."Vendor Proposal ID");
                        end;
                    end;
                }

                field("Vendor ID"; Rec."Vendor ID")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
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

            // action(Approve)
            // {
            //     Caption = 'Approve';
            //     ApplicationArea = All;
            //     Image = Approve;
            //     Visible = IsPropertyManager;

            //     trigger OnAction()
            //     var
            //         SelectedRec: Record "Vendor Proposal Approval";
            //         VendorProposalRec: Record "Vendor Proposal";
            //         RemarkDialog: Page "DialogBoxForInvoiceRejection";
            //         RemarkText: Text;
            //         DialogResult: Action;
            //     begin
            //         if Rec.Status = 'Pending' then begin
            //             DialogResult := RemarkDialog.RunModal();

            //             if DialogResult = Action::OK then begin
            //                 RemarkText := RemarkDialog.GetReason();

            //                 if RemarkText <> '' then begin
            //                     // Update approval table
            //                     SelectedRec := Rec;
            //                     SelectedRec.Status := 'Approved';
            //                     SelectedRec.Remark := RemarkText;
            //                     SelectedRec.Modify();

            //                     // Update all matching Vendor Proposal records
            //                     VendorProposalRec.SetRange("Proposal ID", SelectedRec."Vendor Proposal ID");
            //                     if VendorProposalRec.FindSet() then begin
            //                         repeat
            //                             VendorProposalRec."Internal Remarks" := RemarkText;
            //                             VendorProposalRec."Internal Approval Status" := VendorProposalRec."Internal Approval Status"::Approved;
            //                             VendorProposalRec.Modify();
            //                         until VendorProposalRec.Next() = 0;
            //                     end;

            //                     Commit();
            //                     CurrPage.Update();
            //                     Message('Request Approved Successfully with Remarks.');
            //                 end;
            //             end;
            //         end else
            //             Message('Selected record is not in "Pending" status.');
            //     end;
            // }


            action(Approve)
            {
                Caption = 'Approve';
                ApplicationArea = All;
                Image = Approve;
                Visible = IsPropertyManager;

                trigger OnAction()
                var
                    SelectedRec: Record "Vendor Proposal Approval";
                    VendorProposalRec: Record "Vendor Proposal";
                    RemarkDialog: Page "DialogBoxForInvoiceRejection";
                    RemarkText: Text;
                    DialogResult: Action;
                    NotificationCodeunit: Codeunit "Vendor Proposal Notification"; // 💡 Include your codeunit
                    RecipientEmail: Text; // ✅ Add this
                    VendorProposalApprovalVendor: Codeunit VendorProposalApprovalVendor;
                begin
                    if Rec.Status = 'Pending' then begin
                        DialogResult := RemarkDialog.RunModal();

                        if DialogResult = Action::OK then begin
                            RemarkText := RemarkDialog.GetReason();

                            if RemarkText <> '' then begin
                                // Update approval table
                                SelectedRec := Rec;
                                SelectedRec.Status := 'Approved';
                                SelectedRec.Remark := RemarkText;
                                SelectedRec.Modify();

                                // Update all matching Vendor Proposal records
                                VendorProposalRec.SetRange("Proposal ID", SelectedRec."Vendor Proposal ID");
                                if VendorProposalRec.FindSet() then begin
                                    repeat
                                        VendorProposalRec."Internal Remarks" := RemarkText;
                                        VendorProposalRec."Internal Approval Status" := VendorProposalRec."Internal Approval Status"::Approved;
                                        VendorProposalRec.Modify();
                                    until VendorProposalRec.Next() = 0;
                                end;

                                // ✅ Call the external codeunit to send email
                                RecipientEmail := NotificationCodeunit.SendApprovalEmail(
                                    SelectedRec."Vendor Proposal ID",
                                    SelectedRec."Created By",
                                    RemarkText
                                );

                                Commit();
                                CurrPage.Update();
                                Message('Request Approved Successfully with Remarks and Email Sent to: %1', RecipientEmail);
                                VendorProposalApprovalVendor.VendorProposalApproval(VendorProposalRec);
                                VendorProposalRec."Vendor Approval Status" := VendorProposalRec."Vendor Approval Status"::Pending;
                                VendorProposalRec.Modify(true);
                            end;
                        end;
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
                    SelectedRec: Record "Vendor Proposal Approval";
                    VendorProposalRec: Record "Vendor Proposal";
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
                                VendorProposalRec.SetRange("Proposal ID", SelectedRec."Vendor Proposal ID");
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




        area(navigation)
        {
            action("Open Vendor Proposal")
            {
                Caption = 'Open Vendor Proposal';
                ApplicationArea = All;
                Image = OpenRecord;

                trigger OnAction()
                var
                    TenancyContractRec: Record "Vendor Proposal"; // Replace with the correct table name for Tenancy Contract
                begin
                    // Debugging: Log the Contract ID value
                    Message('Checking Vendor Proposal ID: %1', Rec."Vendor Proposal ID");

                    // Use SetRange and FindFirst to locate the record
                    TenancyContractRec.SetRange("Proposal ID", Rec."Vendor Proposal ID");

                    if TenancyContractRec.FindFirst() then begin
                        // Record found, open the Tenancy Contract Card page
                        PAGE.Run(PAGE::"Vendor Proposal", TenancyContractRec); // Replace with the correct card page ID or name
                    end else begin
                        // Record not found
                        Message('The selected Proposal ID (%1) does not exist in the Vendor Proposal table.', Rec."Vendor Proposal ID");
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
}

