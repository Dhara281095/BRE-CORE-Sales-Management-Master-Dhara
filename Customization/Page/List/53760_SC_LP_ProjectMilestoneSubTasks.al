page 53760 "Project Milestone Sub Task LP"
{
    PageType = ListPart;
    SourceTable = "Project Milestone Sub Task";
    ApplicationArea = All;
    Caption = 'Milestone Sub Tasks';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Sub Task ID"; Rec."Sub Task ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique identifier for the sub task.';
                    Editable = false;
                }
                field("Sub Task Name"; Rec."Sub Task Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Name of the sub task associated with the milestone.';
                }
                field("Task ID"; Rec."Task ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Identifier for the task to which this sub task belongs.';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    ToolTip = 'Indicates the current status of the sub task.';
                }
                field(Progress; Rec.Progress)
                {
                    ApplicationArea = All;
                    Caption = 'Progress (%)';
                    ToolTip = 'Indicates the progress percentage of the sub task.';

                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates the start date of the sub task.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates the end date of the sub task.';
                }
                field(Weight; Rec.Weight)
                {
                    ApplicationArea = All;
                    Caption = 'Weight (%)';
                    ToolTip = 'Indicates the weight of the sub task in the task.';

                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                    ToolTip = 'Provides additional details about the sub task.';
                }
                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                    Caption = 'Notes';
                    ToolTip = 'Contains any notes related to the sub task.';
                }
            }
        }
    }

    // trigger OnAfterGetCurrRecord()
    // begin
    //     CurrPage.Update(false);
    // end;
}