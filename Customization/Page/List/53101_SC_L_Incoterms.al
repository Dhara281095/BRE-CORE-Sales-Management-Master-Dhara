page 53101 "Incoterms List"
{
    PageType = List;
    SourceTable = "Incoterms";
    ApplicationArea = All;
    Caption = 'Incoterms List';
    UsageCategory = Lists;


    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;


                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    // trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    // var
    // begin
    //     Rec.TestField("Name");
    //     Rec.TestField("Description");
    // end;

    procedure GetLookUpValues(pIncotermsList: Page "Incoterms List"; pIncoterms: Record Incoterms): Text
    var
        isFirst: Boolean;
        lookUpValues: Text;
    begin
        pIncotermsList.SetSelectionFilter(pIncoterms);
        if pIncoterms.FindSet() then begin
            isFirst := true;
            repeat
                if isFirst then begin
                    lookUpValues := pIncoterms.Name;
                    isFirst := false;
                end else
                    lookUpValues += ', ' + pIncoterms.Name;
            until pIncoterms.Next() = 0;
        end;
        exit(lookUpValues);
    end;
}