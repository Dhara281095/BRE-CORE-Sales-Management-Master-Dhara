page 53253 "Vendor Proposal Approval List"
{
    PageType = List;
    SourceTable = "Vendor Proposal Approval";
    ApplicationArea = All;
    Caption = 'Vendor Proposal Approval List';
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
                field("Vendor Proposal ID"; Rec."Vendor Proposal ID")
                {
                    ApplicationArea = All;

                    // DrillDown trigger to navigate to the Tenancy Contract Card
                    // trigger OnDrillDown()
                    // var
                    //     TenancyContractRec: Record "Tenancy Contract"; // Replace with the correct table name for Tenancy Contract
                    // begin
                    //     // Debugging: Log the Contract ID value
                    //     Message('Checking Contract ID: %1', Rec."Contract ID");

                    //     // Use SetRange and FindFirst to locate the record
                    //     TenancyContractRec.SetRange("Contract ID", Rec."Contract ID");

                    //     if TenancyContractRec.FindFirst() then begin
                    //         // Record found, open the Tenancy Contract Card page
                    //         PAGE.Run(PAGE::"Tenancy Contract Card", TenancyContractRec); // Replace with the correct card page ID or name
                    //     end else begin
                    //         // Record not found
                    //         Message('The selected Contract ID (%1) does not exist in the Tenancy Contract table.', Rec."Contract ID");
                    //     end;
                    // end;
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
            // action(Approve)
            // {
            //     Caption = 'Approve';
            //     ApplicationArea = All;
            //     Image = Approve;
            //     Visible = IsPropertyManager; // Button visible only for Property Manager

            //     trigger OnAction()
            //     var
            //         SelectedRec: Record "Vendor Proposal Approval";
            //     // StatusUpdateCU: Codeunit "Contract Status Synchronizer";
            //     // ContractRenewal: Codeunit "Contract Renewal Response";
            //     begin
            //         if Rec.Status = 'Pending' then begin
            //             SelectedRec := Rec;
            //             SelectedRec.Status := 'Approved';
            //             SelectedRec.Modify();
            //             // StatusUpdateCU.SyncToTenancyContract(SelectedRec); // ✅
            //             // ContractRenewal.SyncToTenancyContractRenewal(SelectedRec);


            //             Message('Request Approved Successfully');
            //             Commit();
            //             CurrPage.Update();

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
                begin
                    if Rec.Status = 'Pending' then begin
                        SelectedRec := Rec;
                        SelectedRec.Status := 'Approved';
                        SelectedRec.Modify();

                        // Update all Vendor Proposal records with matching Proposal ID
                        VendorProposalRec.SetRange("Proposal ID", SelectedRec."Vendor Proposal ID");
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



            // action(Reject)
            // {
            //     Caption = 'Reject';
            //     ApplicationArea = All;
            //     Image = Reject;
            //     Visible = IsPropertyManager; // Button visible only for Property Manager

            //     trigger OnAction()
            //     var
            //         SelectedRec: Record "Vendor Proposal Approval";
            //     // StatusUpdateCU: Codeunit "Contract Status Synchronizer";
            //     // ContractRenewal: Codeunit "Contract Renewal Response";
            //     begin
            //         if Rec.Status = 'Pending' then begin
            //             SelectedRec := Rec;
            //             SelectedRec.Status := 'Declined';
            //             SelectedRec.Modify();

            //             Commit();
            //             CurrPage.Update();
            //             // StatusUpdateCU.SyncToTenancyContract(SelectedRec); // ✅
            //             // ContractRenewal.SyncToTenancyContractRenewal(SelectedRec);

            //         end else
            //             Message('Selected record is not in "Pending" status.');
            //     end;
            // }
        }

        //  action(Reject)
        //         {
        //      Caption = 'Reject';
        //      ApplicationArea = All;
        //      Image = Reject;
        //      Visible = IsPropertyManager;

        //             trigger OnAction()
        //             var
        //                 SelectedRec: Record "Vendor Proposal Approval";
        //                 VendorProposalRec: Record "Vendor Proposal";
        //                 RemarkPage: Page "Enter Rejection Remark";
        //                 RemarkText: Text;
        //                 DialogResult: Integer;
        //             begin
        //                 if Rec.Status = 'Pending' then begin
        //                     // Correct way to run StandardDialog page
        //                     RemarkPage := Page::"Enter Rejection Remark";
        //                     DialogResult := RemarkPage.RunModal();

        //                     if DialogResult = ACTION::OK then begin
        //                         RemarkText := RemarkPage.GetRemark();

        //                         // Update status and remark in approval table
        //                         SelectedRec := Rec;
        //                         SelectedRec.Status := 'Declined';
        //                         SelectedRec.Remark := RemarkText;
        //                         SelectedRec.Modify();

        //                         // Update internal remarks in Vendor Proposal
        //                         if VendorProposalRec.Get(SelectedRec."Vendor Proposal ID") then begin
        //                             VendorProposalRec."Internal Remarks" := RemarkText;
        //                             VendorProposalRec.Modify();
        //                         end;

        //                         Commit();
        //                         CurrPage.Update();
        //                         Message('Request Rejected with Remark.');
        //                     end;
        //                 end else
        //                     Message('Selected record is not in "Pending" status.');
        //             end;
        //         }

        //     area(navigation)
        //     {
        //         action("Open Tenancy Contract")
        //         {
        //             Caption = 'Open Tenancy Contract';
        //             ApplicationArea = All;
        //             Image = OpenRecord;

        //             trigger OnAction()
        //             var
        //                 TenancyContractRec: Record "Tenancy Contract"; // Replace with the correct table name for Tenancy Contract
        //             begin
        //                 // Debugging: Log the Contract ID value
        //                 Message('Checking Contract ID: %1', Rec."Contract ID");

        //                 // Use SetRange and FindFirst to locate the record
        //                 TenancyContractRec.SetRange("Contract ID", Rec."Contract ID");

        //                 if TenancyContractRec.FindFirst() then begin
        //                     // Record found, open the Tenancy Contract Card page
        //                     PAGE.Run(PAGE::"Tenancy Contract Card", TenancyContractRec); // Replace with the correct card page ID or name
        //                 end else begin
        //                     // Record not found
        //                     Message('The selected Contract ID (%1) does not exist in the Tenancy Contract table.', Rec."Contract ID");
        //                 end;
        //             end;
        //         }

        //         action("Open Renewal Contract")
        //         {
        //             Caption = 'Open Renewal Contract';
        //             ApplicationArea = All;
        //             Image = OpenRecord;


        //             trigger OnAction()
        //             var
        //                 RenewalContractRec: Record "Contract Renewal"; // Replace with the correct table name for the Renewal Contract
        //             begin
        //                 // Debugging: Log the Renewal Contract ID value
        //                 Message('Checking Renewal Contract ID: %1', Rec."Renewal Contract ID");

        //                 // Use SetRange and FindFirst to locate the record
        //                 RenewalContractRec.SetRange("ID", Rec."Renewal Contract ID");

        //                 if RenewalContractRec.FindFirst() then begin
        //                     // Record found, open the Renewal Contract Card page
        //                     PAGE.Run(PAGE::"Contract Renewal Card", RenewalContractRec); // Replace with the correct card page ID or name
        //                 end else begin
        //                     // Record not found
        //                     Message('The selected Renewal Contract ID (%1) does not exist in the Contract Renewal table.', Rec."Renewal Contract ID");
        //                 end;
        //             end;
        //         }
        //     }
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

