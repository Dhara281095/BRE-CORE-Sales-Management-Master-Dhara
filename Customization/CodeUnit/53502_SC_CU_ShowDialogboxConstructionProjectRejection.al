codeunit 53502 DialogboxConstProjectRejection
{
    procedure DialogboxForRejection(var Rec: Record "Construction Project")
    var
        ReasonForRejection: Text;
        DialogConfirmed: Boolean;
        dialogpage: Page DialogBoxForRejection;
        ConstructionProjectRec: Record "Construction Project";
        Rejectionmail: Codeunit ConstructionProjectRejection;

    begin
        // Initialize the dialog page
        ConstructionProjectRec.Get(Rec."Project ID");
        if ConstructionProjectRec.FindSet() then begin
            if dialogpage.RunModal() = Action::OK then begin
                ReasonForRejection := dialogpage.GetReason();
                Rec."Reason for Rejection" := ReasonForRejection;
                Rec.Modify();
                Rejectionmail.ConstructionProjectRejection(Rec);
            end else begin
                Message('Please Enter Reason');
            end;
        end;

    end;

}