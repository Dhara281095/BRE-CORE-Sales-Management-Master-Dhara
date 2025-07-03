page 53504 "Industry Standards"
{
    PageType = List;
    SourceTable = "Industry Standards";
    ApplicationArea = All;
    Caption = 'Industry Standards List';
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

    procedure GetLookUpValues(pIndustryStandardsList: Page "Industry Standards"; pIndustryStandard: Record "Industry Standards"): Text
    var
        isFirst: Boolean;
        lookUpValues: Text;
    begin
        pIndustryStandardsList.SetSelectionFilter(pIndustryStandard);
        if pIndustryStandard.FindSet() then begin
            isFirst := true;
            repeat
                if isFirst then begin
                    lookUpValues := pIndustryStandard.Name;
                    isFirst := false;
                end else
                    lookUpValues += ', ' + pIndustryStandard.Name;
            until pIndustryStandard.Next() = 0;
        end;
        exit(lookUpValues);
    end;
}