page 53759 "Project Milestone Task LP"
{
    PageType = ListPart;
    SourceTable = "Project Milestone Task";
    ApplicationArea = All;
    Caption = 'Milestone Tasks List';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Task ID"; Rec."Task ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique identifier for the task.';
                }

                field("Task Name"; Rec."Task Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Name of the task associated with the milestone.';
                }
                field("Milestone ID"; Rec."Milestone ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Identifier for the milestone to which this task belongs.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    ToolTip = 'Indicates the current status of the task.';
                }
                field(Progress; Rec.Progress)
                {
                    ApplicationArea = All;
                    Caption = 'Progress (%)';
                    ToolTip = 'Indicates the progress percentage of the task.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates the start date of the task.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates the end date of the task.';
                }
                field(Weight; Rec.Weight)
                {
                    ApplicationArea = All;
                    Caption = 'Weight (%)';
                    ToolTip = 'Indicates the weight of the task in the project.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                    ToolTip = 'Provides additional details about the task.';
                }
                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                    Caption = 'Notes';
                    ToolTip = 'Contains any notes related to the task.';
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Milestone ID" := MilestoneId;
    end;

    var
        MilestoneId: Code[20];

    procedure SetMilestoneId(pMilestoneId: Code[20])
    begin
        MilestoneId := pMilestoneId;
    end;
}