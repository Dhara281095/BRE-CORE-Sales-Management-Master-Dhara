codeunit 53503 ConstructionProjectRejection
{

    procedure ConstructionProjectRejection(Rec: Record "Construction Project")
    var
        EmailBody: Text;
        TempBlob: Codeunit "Temp Blob";
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        customer: Record Customer;
        SalesHeader: Record "Sales Header";
        FileManagement: Codeunit "File Management";
        TodayDate: Date;
        CCMail: List of [Text];
        UserRec: Record User; // Record for User
        Username: Text;
        BCCMail: List of [Text];
        // Record for User Personalization
        TempEmailBody: Text;
        SalesLine: Record "Sales Line";
        TotalAmount: Decimal;
        CompanyInfo: Record "Company Information";
        RecRef: RecordRef;
        UserPersonalizationRec: Record "User Personalization";
        InvoiceLink: Text;
        ConstructionProject: Record "Construction Project";
        ConstructionProjectLink: Text;
        useremail: List of [Text];
    begin

        ConstructionProject.Get(Rec."Project ID");
        UserRec.SetRange("User Name", ConstructionProject."Created By");
        if UserRec.FindFirst() then begin
            if UserRec."Contact Email" <> '' then begin
                useremail.Add(UserRec."Contact Email");
            end else begin
                Error('User %1 does not have a valid email address.', UserRec."User Name");
            end;
        end;

        if Rec.Get(Rec."Project ID") then begin
            ConstructionProject.Get(Rec."Project ID");
            ConstructionProjectLink := GETURL(ClientType::Current, COMPANYNAME, ObjectType::Page, PAGE::"Construction Project", Rec);
            if CompanyInfo.get() then begin
                EmailMessage.Create(useremail, 'Construction Project Rejection Notification - ' + ConstructionProject."Project ID",
                '<html>' +
                '<body>' +
                '<p>Dear ' + UserRec."Full Name" + ',</p>' +
                '<h3>Construction Project Details</h3>' +
                '<p><b>Project ID:</b> ' + ConstructionProject."Project ID" + '<br/>' +
                '<b>Project Name:</b> ' + ConstructionProject."Project Name" + '<br/>' +
                 '<b>Reason for Rejection:</b> ' + Rec."Reason for Rejection" + '<br/>' +
                '<p>Please review the details and update the record at your earliest convenience.</p>' +
                '<p><a href="' + ConstructionProjectLink + '" target="_blank">Click here to view the Construction Project</a></p>' +
                '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
                '</body>' +
                '</html>',
                true);
                if Email.Send(EmailMessage) then begin
                    // Combine all names into a comma-separated string


                    Message('Email sent successfully to: %1.', UserRec."User Name");
                end else begin
                    Error('Failed to send email.');
                end;
            end;
        end else begin
            Error('Construction Project not found.');
        end;
    end;
}