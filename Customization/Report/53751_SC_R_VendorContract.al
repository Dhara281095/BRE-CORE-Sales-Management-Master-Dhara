report 53751 "Vendor Contract"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = "VendorContract.docx";

    dataset
    {
        dataitem("Vendor Contract"; "Vendor Contract")
        {
            column(Day; Day) { }
            column(Month; Month) { }
            column(Year; Year) { }
            column(Contract_ID; "Contract ID") { }
            column(Contract_Date; "Contract Date") { }
            column(Contract_Start_Date; "Contract Start Date") { }
            column(Contract_End_Date; "Contract End Date") { }
            column(Vendor_ID; "Vendor ID") { }
            column(Vendor_Name; "Vendor Name") { }
            column(VendorCountry; VendorCountry) { }
            column(VendorAddess; VendorAddess) { }
            column(CompanyName; CompanyName) { }
            column(CompanyAddress; CompanyAddress) { }
            column(ProjectName; ProjectName) { }
            column(ProjectLocation; ProjectLocation) { }


            trigger OnAfterGetRecord()
            var
                fetchMonth: Codeunit "Fetch Month";
            begin
                if CompanyInfo.Get() then begin
                    CompanyName := CompanyInfo.Name;
                    CompanyAddress := CompanyInfo.Address;
                end;

                if VendorProfile.Get("Vendor ID") then begin
                    VendorCountry := VendorProfile."Country";
                    VendorAddess := VendorProfile.Address + ', ' + VendorProfile."Address 2" + ', ' + VendorProfile."Address 3";
                end;

                if Project.Get("Project ID") then begin
                    ProjectName := Project."Project Name";
                    ProjectLocation := Project."Address Line 1" + ', ' + Project."Address Line 2" + ', ' + Project."Postal Code" + ',';
                end;

                ContractAssigment.SetRange("Contract ID", "Contract ID");
                ContractAssigment.SetRange("Vendor/Subcontractor ID", "Vendor ID");
                if ContractAssigment.FindFirst() then begin

                end;

                Day := AddSuffix(Format(Date2DMY("Contract Date", 1)));
                Month := fetchMonth.GetMonthName(Date2DMY("Contract Date", 2));
                Year := Format(Date2DMY("Contract Date", 3));
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {

                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {

                }
            }
        }
    }

    rendering
    {
        layout("VendorContract.docx")
        {
            Type = Word;
            LayoutFile = './ReportTemplate/VendorContract.docx';

        }
    }

    var
        Day, Month, Year : Text;
        CompanyInfo: Record "Company Information";
        CompanyName: Text;
        CompanyAddress: Text;
        VendorProfile: Record "Facility Vendor Profiles";
        VendorCountry: Text;
        VendorAddess: Text;
        Project: Record "Construction Project";
        ProjectName: Text;
        ProjectLocation: Text;
        ContractAssigment: Record "Contract Assignment";

    procedure AddSuffix(pDay: Text): Text
    var
        onesDigit: Text;
    begin
        onesDigit := CopyStr(pDay, StrLen(pDay) - 1, StrLen(pDay));

        case onesDigit of
            '1':
                exit(pDay + 'st');
            '2':
                exit(pDay + 'nd');
            '3':
                exit(pDay + 'rd');
            else
                exit(pDay + 'th');
        end;
    end;
}