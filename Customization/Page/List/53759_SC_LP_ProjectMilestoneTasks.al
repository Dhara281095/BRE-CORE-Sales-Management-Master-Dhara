page 53759 "Project Milestone Task LP"
{
    PageType = ListPart;
    SourceTable = "Project Milestone Task";
    ApplicationArea = All;
    Caption = 'Milestone Tasks List';
    RefreshOnActivate = true;

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
                    Editable = false;
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
                    Editable = false;
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
                    Editable = false;
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
                    ToolTip = 'Indicates the weight of the task in the milestone.';

                    // trigger OnValidate()
                    // begin
                    //     CurrPage.Update(false);
                    // end;
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
                field("Contract ID"; Rec."Contract ID")
                {
                    ApplicationArea = All;
                    Caption = 'Contract ID';
                    TableRelation = "Vendor Contract"."Contract ID" where("Project ID" = field("Project ID"));
                    trigger OnValidate()
                    var
                        ContractRec: Record "Vendor Contract";
                    begin
                        ContractRec.SetRange("Contract ID", Rec."Contract ID");
                        if ContractRec.FindFirst() then begin
                            Rec."Vendor Profile ID" := ContractRec."Contract ID";

                        end else begin
                            Rec."Contract ID" := '';

                        end;
                    end;
                }
                field("Vendor Profile ID"; Rec."Vendor Profile ID")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Profile ID';
                    Editable = false;
                }


            }
        }
    }

    trigger OnAfterGetRecord()
    var
        milestone: Page "Project Milestone List Part";
    begin
        // Rec.RecalculateProgress();
        CurrPage.Update(false);
        milestone.UpdatedPage();
    end;
}