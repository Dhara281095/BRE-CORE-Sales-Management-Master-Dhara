page 53758 "Project Milestone List Part"
{
    PageType = ListPart;
    SourceTable = "Project Milestone";
    ApplicationArea = All;
    Caption = 'Project Milestone List';
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Milestone ID"; Rec."Milestone ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique identifier for the milestone.';
                    Editable = false;
                }
                field("Milestone Name"; Rec."Milestone Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Name of the milestone.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    ToolTip = 'Indicates the current status of the milestone.';
                }
                field(Progress; Rec.Progress)
                {
                    ApplicationArea = All;
                    Caption = 'Progress (%)';
                    ToolTip = 'Indicates the progress percentage of the milestone.';
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates the start date of the milestone.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates the end date of the milestone.';
                }
                field(Weight; Rec.Weight)
                {
                    ApplicationArea = All;
                    Caption = 'Weight (%)';
                    ToolTip = 'Indicates the weight of the milestone in the project.';

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                    ToolTip = 'Provides additional details about the milestone.';
                }
                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                    Caption = 'Notes';
                    ToolTip = 'Contains any notes related to the milestone.';
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        CurrPage.Update(false);
    end;

    // trigger OnAfterGetCurrRecord()
    // begin
    //     Rec.RecalculateProgress();
    //     CurrPage.Update(false);
    // end;

    procedure UpdatedPage()
    begin
        CurrPage.Update(false);
    end;
}