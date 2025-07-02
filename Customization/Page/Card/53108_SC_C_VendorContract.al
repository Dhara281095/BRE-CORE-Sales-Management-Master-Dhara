page 53108 "Vendor Contract"
{
    PageType = Card;
    SourceTable = "Vendor Contract";
    ApplicationArea = All;
    Caption = 'Vendor Contract Card';

    layout
    {
        area(Content)
        {
            group("General Information")
            {
                Caption = 'General Information';

                field("Contract ID"; Rec."Contract ID")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;

                }

                field("Proposal ID"; Rec."Proposal ID")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    trigger OnValidate()
                    var
                        VendorRec: Record "Vendor Proposal";
                    begin
                        VendorRec.SetRange("Proposal ID", Rec."Proposal ID");
                        if VendorRec.FindFirst() then begin
                            Rec."Vendor ID" := VendorRec."Vendor ID";
                            Rec."Vendor Name" := VendorRec."Vendor Name";
                            Rec."Vendor Email" := VendorRec."Vendor Email";
                            Rec."Vendor Designation" := VendorRec."Vendor Designation";
                            Rec."Project ID" := VendorRec."Project ID";
                            Rec."Work Scope" := VendorRec."Work Scope";
                            Rec."Contract Start Date" := VendorRec."Start Date";
                            Rec."Contract End Date" := VendorRec."End Date";
                            Rec."Payment Terms" := VendorRec."Payment Terms";
                            Rec."Compliance Required" := VendorRec."Compliance Required";
                            Rec."Created By" := VendorRec."Created By";
                            Rec."Project Name" := VendorRec."Project Name";
                            Rec."Duration" := VendorRec."Duration";
                            Rec."Project Location" := VendorRec."Project Location";
                            Rec."Delivery Location" := VendorRec."Delivery Location";
                            Rec."Delivery Date" := VendorRec."Delivery Date";
                            Rec."Late Delivery Penalty %" := VendorRec."Late Delivery Penalty %";
                            Rec."Total Contract Value (AED)" := VendorRec."Total Contract Value (AED)";
                            Rec."Advance Payment (%)" := VendorRec."Advance Payment (%)";
                            Rec."Interim Payment (%)" := VendorRec."Interim Payment (%)";
                            Rec."Final Payment (%)" := VendorRec."Final Payment (%)";
                            Rec."VAT %" := VendorRec."VAT %";
                            Rec."Payment Method" := VendorRec."Payment Method";
                            Rec."UAE Compliance Requirements" := VendorRec."UAE Compliance Requirements";
                            Rec."Industry Standards" := VendorRec."Industry Standards";
                            Rec."Warranty Period (Months)" := VendorRec."Warranty Period (Months)";
                            Rec."Dispute Resolution" := VendorRec."Dispute Resolution";
                            Rec.Description := VendorRec.Description;
                            Rec.Incoterms := VendorRec.Incoterms;

                        end else begin
                            Rec."Vendor ID" := '';
                            Rec."Vendor Name" := '';
                            Rec."Vendor Email" := '';
                            Rec."Vendor Designation" := '';
                            Rec."Project ID" := '';
                            Rec."Work Scope" := '';
                            Rec."Contract Start Date" := 0D;
                            Rec."Contract End Date" := 0D;
                            Rec."Payment Terms" := '';

                            Rec."Created By" := '';
                            Rec."Project Name" := '';
                            Rec."Duration" := '';
                            Rec."Project Location" := '';
                            Rec."Delivery Location" := '';
                            Rec."Delivery Date" := 0D;
                            Rec."Late Delivery Penalty %" := 0;
                            Rec."Total Contract Value (AED)" := 0;
                            Rec."Advance Payment (%)" := 0;
                            Rec."Interim Payment (%)" := 0;
                            Rec."Final Payment (%)" := 0;

                            Rec."Payment Method" := 0;
                            Rec."UAE Compliance Requirements" := '';
                            Rec."Industry Standards" := '';
                            Rec."Warranty Period (Months)" := 0;
                            Rec."Dispute Resolution" := '';
                            Rec.Description := '';
                            Rec.Incoterms := '';


                        end;
                    end;

                }

                field("Project ID"; Rec."Project ID")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
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
                field("Contract Date"; Rec."Contract Date")
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
                {
                    {IDRec."Vendor ID")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Vendor Name"; 
                    {
                        Editable = false;
                }    
                    }
                    {
                    {
                        Editable = false;
                }    
                    }
                    {
                    {
                        Editable = false;
                }    
            }    }
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
                        }
                        field("Industry Standards"; Rec."Industry Standards")
                        {
                            ApplicationArea = All;
                            Caption = 'Industry Standards';
                            ShowMandatory = true;
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
                    }



                    {
                    {
                        field("Work Scope"; Rec."Work Scope")
                        {
                        {
                            multiLine = true;
                }        
                        }
                        {
                        {
                        }
                        }
                        {
                        {
                        }
                        }
                        {
                        {
                        }


            }
            }

                        {
                        {
                            field("Internal Approval Status"; Rec."Internal Approval Status")
                            {
                            {
                                Editable = approvaleditable;
                }            
                            }
                            {
                            {
                                multiLine = true;
                                Editable = approvaleditable;
                }            
                            }
                            {
                            {
                                Editable = false;
                }            
                            }
                            {
                            {
                                Editable = approvaleditable;
                }            
                            }
                            {
                            {
                                multiLine = true;
                                Editable = approvaleditable;
                }            
                            }
                            part("Pricing Breakdown Grid"; "Pricing Breakdown Grid")
                            {
                                ApplicationArea = All;
                                Caption = 'Pricing Breakdown Grid';
                                Visible = true;
                                Editable = false;
                                SubPageLink = "Vendor Contract ID" = field("Contract ID");
            }                
        }                }
                        }
                    }

                    actions
                    {

                        {
                {

                            {
                            {
                                Caption = 'Send for Approval';
                                Image = Approve;
                
                trigger OnAction()
                                var
                                var
                                begin
                                begin
                                    Dialog.Message('✅ Your request has been submitted successfully.');
                
                end;
            }                end;
                            }
                            {
                            {
                                Caption = 'Send to Vendor for Approval';
                                Image = Approve;
                                trigger OnAction()
                                var
                                var
                                begin
                                begin
                                     (Rec."Vendor Approval Status" = Rec."Vendor Approval Status"::Approved) then begin
                                        if Confirm('Are you sure you want to send again this contract for approval?', true) then begin
                                            VendorContractApprovalVendor.VendorContractApproval(Rec);
                                            Rec."Vendor Approval Status" := Rec."Vendor Approval Status"::Pending;
                                            Rec.Modify(true);
                        end;                
                    end                 end;
                                        VendorContractApprovalVendor.VendorContractApproval(Rec);
                                        Rec."Vendor Approval Status" := Rec."Vendor Approval Status"::Pending;
                                        Rec.Modify(true);
                    end;                
                end;                end;
                                end;
                            }
                        }
                        {
                        {
                            {
                            {
                            }
                            {
                            {
                            }
                        }
                 
    // Insert Validation and trigger 
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
    begin
        Rec.TestField("Proposal ID");
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
}