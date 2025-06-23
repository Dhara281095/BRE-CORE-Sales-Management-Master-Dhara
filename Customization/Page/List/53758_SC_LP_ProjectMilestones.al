page 53758 "Project Milestone List Part"
{
    PageType = ListPart;
    SourceTable = "Project Milestone";
    ApplicationArea = All;
    Caption = 'Project Milestone List';

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

                    trigger OnDrillDown()
                    var
                        milestoneTask: Record "Project Milestone Task";
                        projectMilestoneTaskLP: Page "Project Milestone Task LP";
                    begin
                        milestoneTask.SetRange("Milestone ID", Rec."Milestone ID");
                        projectMilestoneTaskLP.SetMilestoneId(Rec."Milestone ID");
                        projectMilestoneTaskLP.SetTableView(milestoneTask);
                        projectMilestoneTaskLP.RunModal();
                    end;
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
    trigger OnAfterGetCurrRecord()
    var
        constructionProject: Record "Construction Project";
        projectMilestoneTaskLP: Page "Project Milestone Task LP";
    begin
        if constructionProject.Get(Rec."Project ID") then begin
            if constructionProject.SelectedMilestoneID <> Rec."Milestone ID" then begin
                constructionProject.SelectedMilestoneID := Rec."Milestone ID";
                constructionProject.Modify(true); // Save change and trigger OnAfterGetRecord on other subpages
                Rec.RecalculateProgress();
            end;
        end;
    end;

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