codeunit 53505 VendorContractApprovalVendor
{


    procedure VendorContractApproval(Rec: Record "Vendor Contract")
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
        VendorContract: Record "Vendor Contract";
        outStream: OutStream;
        inStream: InStream;
        fileName: Text;
    begin
        // Implementation logic for vendor proposal approval goes here.
        // VendorContract.Get(Rec."Contract ID");

        VendorContract.SetRange("Contract ID", Rec."Contract ID");
        if VendorContract.FindSet() then begin

            RecRef.GetTable(VendorContract);

            TempBlob.CreateOutStream(outStream);

            Report.SaveAs(53751, '', ReportFormat::Pdf, outStream, RecRef);

            TempBlob.CreateInStream(inStream);

            fileName := 'Vendor Contract ' + VendorContract."Contract ID" + '.pdf';

            if CompanyInfo.get() then begin
                EmailMessage.Create(VendorContract."Vendor Email", 'Vendor Contract Approval Request - ' + VendorContract."Contract ID" + ' for Project ' + VendorContract."Project ID",
                '<html>' +
                             '<body>' +
                             '<p>Dear ' + VendorContract."Vendor Name" + ',</p>' +
                             '<h3>Vendor Contract Details</h3>' +
                              '<p>We hope this message finds you well.' + '<br/>' +
                               'The contract ' + VendorContract."Contract ID" + ' related to project ' + VendorContract."Project ID" + ' is now ready for your review and approval.' + '<br/>' +
                               'Please find the Contract details below:' + '<br/>' +
                              '<b>Contract ID:</b> ' + VendorContract."Contract ID" + '<br/>' +
                             '<b>Contract Start date:</b> ' + Format(VendorContract."Contract Start Date") + '<br/>' +
                              '<b>Contract End date:</b> ' + Format(VendorContract."Contract End Date") + '<br/>' +
                             '<b>Project ID:</b> ' + VendorContract."Project ID" + '<br/>' +
                              '<b>Vendor ID:</b> ' + VendorContract."Vendor ID" + '</p>' +
                              '<b>Task ID:</b> ' + VendorContract."Task ID" + '</p>' +
                              '<b>Task Name:</b> ' + VendorContract."Task Name" + '</p>' +
                              '<b>Task Start Date:</b> ' + Format(VendorContract."Task Start Date") + '</p>' +
                              '<b>Task End Date:</b> ' + Format(VendorContract."Task End Date") + '</p>' +
                              '<b>Task Description:</b> ' + VendorContract."Task Description" + '</p>' +
                              '<b>Milestone ID:</b> ' + VendorContract."Milestone ID" + '</p>' +
                              '<p>Please log into the Vendor Portal to review the contract details and approve or refer it back with comments.' + '<br/>' +
                             'If you have any questions or need assistance accessing the portal, please feel free to contact us.' + '<br/>' +
                             'Thank you for your cooperation.</p>' +
                             '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
                            '</body>' +
                            '</html>',
                            true);

                EmailMessage.AddAttachment(fileName, '', inStream);

                if Email.Send(EmailMessage) then begin

                    Message('Email sent successfully to: %1.', VendorContract."Vendor Name");
                end else begin
                    Error('Failed to send email.');
                end;
            end;
        end;
    end;

}