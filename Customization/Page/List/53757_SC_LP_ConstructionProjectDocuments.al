page 53757 "Construction Project Documents"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Construction Project Documents";

    layout
    {
        area(Content)
        {
            repeater(Documents)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Upload Document"; Rec."Upload Document")
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        azureBlobUploader: Codeunit "Azure AD Blob Storage";
                        fileName: Text;
                        folderName: Text;
                        uploadResult: Text;
                    begin
                        folderName := 'ConstructionContracts';
                        fileName := azureBlobUploader.ValidateDocument(uploadResult, folderName);
                        if fileName <> '' then begin
                            Rec."Upload Document" := fileName;
                            Rec."Document URL" := uploadResult;
                            Rec.Modify();
                            Message('File uploaded successfully: %1', fileName);
                        end;
                    end;
                }
                field("View & Download"; Rec."View & Download")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        // Check if the file URL is not empty
                        if Rec."Document URL" = '' then
                            Error('No document is available to view.')
                        else
                            Hyperlink(Rec."Document URL");
                    end;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(UploadDocument)
            {
                ApplicationArea = All;
                Caption = 'Upload Document';
                Image = Insert;
                trigger OnAction()
                var
                    azureBlobUploader: Codeunit "Azure AD Blob Storage";
                    fileName: Text;
                    folderName: Text;
                    uploadResult: Text;
                begin
                    folderName := 'ConstructionContracts';
                    fileName := azureBlobUploader.ValidateDocument(uploadResult, folderName);
                    if fileName <> '' then begin
                        Rec."Upload Document" := fileName;
                        Rec."Document URL" := uploadResult;
                        Rec.Modify();
                        Message('File uploaded successfully: %1', fileName);
                    end;
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Project ID" := ProjectId;
    end;

    var
        ProjectId: Code[20];

    procedure SetProjectId(pProjectId: Code[20])
    begin
        ProjectId := pProjectId;
    end;
}