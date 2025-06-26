codeunit 53501 ConstructionProjectApproval
{
    procedure ConstructionProApproval(Rec: Record "Construction Project")
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
        UserPersonalizationRec: Record "User Personalization";
        InvoiceLink: Text;
        ConstructionProject: Record "Construction Project";
        ConstructionProjectlink: Text;
        fullname: List of [Text];
        FullNameText: Text;
        FullNameItem: Text;
    begin
        UserPersonalizationRec.SetRange("Profile ID", 'PROJECT MANAGER');
        if UserPersonalizationRec.FindSet() then
            repeat
                if UserRec.Get(UserPersonalizationRec."User SID") then
                    if UserRec."Contact Email" <> '' then
                        EmailAddress.Add(UserRec."Contact Email");
                fullname.Add(UserRec."Full Name");
            until UserPersonalizationRec.Next() = 0;
        if EmailAddress.Count() = 0 then
            Error('No users with the "Project Manager" profile have a valid email address.');

        ConstructionProject.Get(Rec."Project ID");
        ConstructionProjectlink := GETURL(ClientType::Current, COMPANYNAME, ObjectType::Page, PAGE::"Construction Project", Rec);
        if CompanyInfo.get() then begin
            EmailMessage.Create(EmailAddress, 'Construction Project Approval Notification - ' + ConstructionProject."Project ID",
            '<html>' +
                         '<body>' +
                         '<p>Dear ' + UserRec."Full Name" + ',</p>' +
                         '<h3>Construction Project Details</h3>' +
                         //  '<p>The following invoice has been Updated:</p>' +
                         '<p><b>Project ID:</b> ' + ConstructionProject."Project ID" + '<br/>' +
                         // '<b>Contract ID:</b> ' + Format(ConstructionProject."Contract ID") + '<br/>' +
                         '<b>Project Name:</b> ' + ConstructionProject."Project Name" + '<br/>' +
                         //  '<b>Project Type:</b> ' + Format(ConstructionProject."Project Type") + '<br/>' +
                         //   '<b>Project Location:</b> ' + ConstructionProject."Project Location" + '<br/>' +
                         '<p>Please review the Project details and provide your approval at your earliest convenience. If any adjustments are needed, kindly let us know.</p>' +
                       '<p><a href="' + ConstructionProjectlink + '" target="_blank">Click here to view the Construction Project</a></p>' +
                         '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +

                        '</body>' +
                        '</html>',
                        true);

            if Email.Send(EmailMessage) then begin
                // Combine all names into a comma-separated string
                foreach FullNameItem in fullname do
                    if FullNameText = '' then
                        FullNameText := FullNameItem
                    else
                        FullNameText := FullNameText + ', ' + FullNameItem;

                Message('Email sent successfully to: %1.', FullNameText);
            end else begin
                Error('Failed to send email.');
            end;
        end;
    end;



}