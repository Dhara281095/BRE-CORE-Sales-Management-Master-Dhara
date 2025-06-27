codeunit 53504 VendorProposalApprovalVendor
{


    procedure VendorProposalApproval(Rec: Record "Vendor Proposal")
    var
        EmailBody: Text;
        TempBlob: Codeunit "Temp Blob";
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        FileManagement: Codeunit "File Management";
        TodayDate: Date;
        EmailAddress: List of [Text];
        CCMail: List of [Text];
        UserRec: Record User; // Record for User
        Username: Text;
        BCCMail: List of [Text];
        TempEmailBody: Text;
        TotalAmount: Decimal;
        CompanyInfo: Record "Company Information";
        RecRef: RecordRef;
        InvoiceLink: Text;
        VendorProposalLink: Text;
        fullname: List of [Text];
        FullNameText: Text;
        FullNameItem: Text;
        VendorProposal: Record "Vendor Proposal";
    begin
        // Implementation logic for vendor proposal approval goes here.
        VendorProposal.Get(Rec."Proposal ID");

        if CompanyInfo.get() then begin
            EmailMessage.Create(VendorProposal."Vendor Email", 'Vendor Proposal Approval Request - ' + VendorProposal."Proposal ID" + ' for Project ' + VendorProposal."Project ID",
            '<html>' +
                         '<body>' +
                         '<p>Dear ' + VendorProposal."Vendor Name" + ',</p>' +
                         '<h3>Vendor Proposal Details</h3>' +
                          '<p>We hope this message finds you well.' + '<br/>' +
                           'The Proposal ' + VendorProposal."Proposal ID" + ' related to project ' + VendorProposal."Project ID" + ' is now ready for your review and approval.' + '<br/>' +
                           'Please find the proposal details below:' + '<br/>' +
                          '<b>Project ID:</b> ' + VendorProposal."Proposal ID" + '<br/>' +
                         '<b>Proposal Date:</b> ' + Format(VendorProposal."Proposal Date") + '<br/>' +
                         '<b>Project ID:</b> ' + VendorProposal."Project ID" + '<br/>' +
                          '<b>Vendor ID:</b> ' + VendorProposal."Vendor ID" + '</p>' +
                         '<p>Please log into the Vendor Portal to review the proposal details and approve or refer it back with comments.' + '<br/>' +
                         'If you have any questions or need assistance accessing the portal, please feel free to contact us.' + '<br/>' +
                         'Thank you for your cooperation.</p>' +
                         '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
                        '</body>' +
                        '</html>',
                        true);

            if Email.Send(EmailMessage) then begin

                Message('Email sent successfully to: %1.', VendorProposal."Vendor Name");
            end else begin
                Error('Failed to send email.');
            end;
        end;
    end;

}