page 53755 "Project Types"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Project Type";

    layout
    {
        area(Content)
        {
            repeater(ProjectTypes)
            {
                field("Project Type"; Rec."Project Type")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}