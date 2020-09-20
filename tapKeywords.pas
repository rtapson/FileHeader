unit tapKeywords;

interface

type
  THeaderKeywords = class
  public
    class function ProjectGroup: string;
    class function Project: string;
    class function FileName: string;

    class function CurrentMonth: string;
    class function CurrentYear: string;
    class function CurrentDay: string;
    class function CurrentTime: string;

    class function ProcessKeywords(const Header: string): string;
  end;

implementation

uses
  SysUtils,
  StrUtils,
  DateUtils,
  tapToolsApiUtils;

{ THeaderKeywords }

class function THeaderKeywords.CurrentDay: string;
begin
  Result := '$CURRENT_DAY$';
end;

class function THeaderKeywords.CurrentMonth: string;
begin
  Result := '$CURRENT_MONTH$';
end;

class function THeaderKeywords.CurrentTime: string;
begin
  Result := '$CURRENT_TIME$';
end;

class function THeaderKeywords.CurrentYear: string;
begin
  Result := '$CURRENT_YEAR$';
end;

class function THeaderKeywords.FileName: string;
begin
  Result := '$FILENAME$';
end;

class function THeaderKeywords.ProcessKeywords(const Header: string): string;
begin
  Result := Header;
  Result := Result.Replace(CurrentYear, YearOf(Today).ToString, [rfReplaceAll]);
  Result := Result.Replace(CurrentMonth, MonthOf(Today).ToString, [rfReplaceAll]);
  Result := Result.Replace(CurrentDay, DayOf(Today).ToString, [rfReplaceAll]);
  Result := Result.Replace(CurrentTime, TimeToStr(Now), [rfReplaceAll]);
  Result := Result.Replace(FileName, TToolsApiUtils.ActiveSourceEditor.FileName, [rfReplaceAll]);
  Result := Result.Replace(ProjectGroup, TToolsApiUtils.CurrentProjectGroup.FileName, [rfReplaceAll]);
  Result := Result.Replace(Project, TToolsApiUtils.CurrentProjectGroup.ActiveProject.FileName, [rfReplaceAll]);
end;

class function THeaderKeywords.Project: string;
begin
  Result := '$PROJECT$';
end;

class function THeaderKeywords.ProjectGroup: string;
begin
  Result := '$PROJECTGROUP$';
end;

end.
