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

                field("Created By"; Rec."Created By")
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
                    RemarkDialog: Page "DialogBoxForInvoiceRejection";
                    RemarkText: Text;
                    DialogResult: Action;
                    NotificationCodeunit: Codeunit "Vendor Proposal Notification"; // Replace with your actual codeunit name
                    RecipientEmail: Text; // ✅ Add this
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

                                // Update all Vendor Assignment records with matching Assignment ID
                                VendorProposalRec.SetRange("Assignment ID", SelectedRec."Vendor Assignment ID");
                                if VendorProposalRec.FindSet() then begin
                                    repeat
                                        VendorProposalRec."Vendor Assignment Status" := VendorProposalRec."Vendor Assignment Status"::Approved;
                                        VendorProposalRec."Approved By" := GetCurrentUserName();
                                        VendorProposalRec."Reviewed By" := GetCurrentUserName();
                                        VendorProposalRec."Approval Date" := Today;
                                        VendorProposalRec.Remark := RemarkText;
                                        VendorProposalRec.Modify();
                                    until VendorProposalRec.Next() = 0;
                                end;

                                // ✅ Call Notification Codeunit to send approval email
                                RecipientEmail := NotificationCodeunit.SendAssignmentApprovalEmail(
                                    SelectedRec."Vendor Assignment ID",
                                    SelectedRec."Created By",
                                    RemarkText
                                );

                                Commit();
                                CurrPage.Update();
                                Message('Request Approved Successfully with Remarks and Email Sent to: %1', RecipientEmail);
                            end;
                        end;
                    end else
                        Message('Selected record is not in "Pending" status.');
                end;
            }

            // action(Approve)
            // {
            //     Caption = 'Approve';
            //     ApplicationArea = All;
            //     Image = Approve;
            //     Visible = IsPropertyManager;

            //     trigger OnAction()
            //     var
            //         SelectedRec: Record "Vendor Assignment Approval";
            //         VendorProposalRec: Record "Vendor Assignment";
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

            //                     // Update all Vendor Assignment records with matching Assignment ID
            //                     VendorProposalRec.SetRange("Assignment ID", SelectedRec."Vendor Assignment ID");
            //                     if VendorProposalRec.FindSet() then begin
            //                         repeat
            //                             VendorProposalRec."Vendor Assignment Status" := VendorProposalRec."Vendor Assignment Status"::Approved;
            //                             VendorProposalRec."Approved By" := GetCurrentUserName();
            //                             VendorProposalRec."Reviewed By" := GetCurrentUserName();
            //                             VendorProposalRec."Approval Date" := Today;
            //                             VendorProposalRec.Remark := RemarkText;
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
                                        VendorProposalRec.Remark := RemarkText;
                                        VendorProposalRec."Vendor Assignment Status" := VendorProposalRec."Vendor Assignment Status"::Rejected;
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

