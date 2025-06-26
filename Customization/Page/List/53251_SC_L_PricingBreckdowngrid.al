page 53251 "Pricing Breakdown Grid"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Pricing Breakdown";

    // Caption = 'Pricing Breakdown';

    layout
    {
        area(Content)
        {
            repeater(Prices)
            {

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;

                }

                field("Profile ID"; Rec."Profile ID")
                {
                    ApplicationArea = All;

                }


                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;

                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Quantity"; Rec."Quantity")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec."Total Cost" := Rec."Quantity" * Rec."Price Per Unit";
                    end;
                }
                field("Unit"; Rec."Unit")
                {
                    ApplicationArea = All;
                }
                field("Price Per Unit"; Rec."Price Per Unit")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec."Total Cost" := Rec."Quantity" * Rec."Price Per Unit";
                    end;
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(CalculateTotal)
    //         {
    //             Caption = 'Recalculate Total';
    //             ApplicationArea = All;
    //             Image = Calculate;
    //             trigger OnAction()
    //             begin
    //                 Rec."Total Cost" := Rec."Quantity" * Rec."Price Per Unit";
    //                 Rec.Modify();
    //                 Message('Total cost updated to: %1', Rec."Total Cost");
    //             end;
    //         }
    //     }
    // }

}
