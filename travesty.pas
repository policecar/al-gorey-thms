program Travesty;

{ TRAVESTY -- after Hugh Kenner & Joseph O'Rourke,               }
{ "A Travesty Generator for Micros", BYTE, November 1984, p.129: }
{ a reconstruction in the manner of the original Pascal listing, }
{ whose text could not be exhumed whole.  The method is theirs:  }
{ no frequency tables are built, for the micro has no memory to  }
{ spare; instead, for every character emitted, the entire source }
{ text is searched anew for each place the last n-1 characters   }
{ occur, and one of the characters found standing after them is  }
{ chosen by lot.  English decays into drivel that remains        }
{ unsettlingly like the author.                                  }
{                                                                }
{   fpc -Mtp -v0 travesty.pas                                    }
{   ./travesty lovecraft_complete.txt 5 600                      }

const
  MaxText = 60000;                      { the whole of the micro's memory }
  MaxPat  = 9;

var
  Text    : array [1 .. MaxText + MaxPat] of char;
  TextLen : longint;
  Pattern : array [1 .. MaxPat] of char;
  Order   : integer;                    { n: match on the last n-1 chars }
  OutLen  : longint;
  Emitted : longint;
  Chosen  : char;

procedure LoadText;
var
  F        : file of char;
  C        : char;
  LastBlank: boolean;
  I        : longint;
begin
  Assign(F, ParamStr(1));
  Reset(F);
  TextLen := 0;
  LastBlank := true;
  while (not Eof(F)) and (TextLen < MaxText) do
  begin
    Read(F, C);
    if C in [' ', ^I, ^J, ^M] then
    begin
      if not LastBlank then
      begin
        TextLen := TextLen + 1;
        Text[TextLen] := ' ';
      end;
      LastBlank := true
    end
    else
    begin
      TextLen := TextLen + 1;
      Text[TextLen] := C;
      LastBlank := false
    end
  end;
  Close(F);
  { the serpent swallows its tail, so no pattern is ever a dead end }
  for I := 1 to Order do
    Text[TextLen + I] := Text[I]
end;

procedure NextChar;
var
  I, J    : longint;
  Matches : longint;
  Hit     : boolean;
begin
  { one pass over the text; each match may, by dwindling lot, }
  { seize the succession -- Waterman's reservoir of size one  }
  Matches := 0;
  Chosen := ' ';
  for I := 1 to TextLen do
  begin
    Hit := true;
    for J := 1 to Order - 1 do
      if Text[I + J - 1] <> Pattern[J] then Hit := false;
    if Hit then
    begin
      Matches := Matches + 1;
      if Random(Matches) = 0 then
        Chosen := Text[I + Order - 1]
    end
  end
end;

procedure SlidePattern;
var
  J : integer;
begin
  for J := 1 to Order - 2 do
    Pattern[J] := Pattern[J + 1];
  Pattern[Order - 1] := Chosen
end;

var
  Code : integer;
  K    : integer;

begin
  if ParamCount < 3 then
  begin
    Writeln('usage: travesty <textfile> <order 2..', MaxPat, '> <output length>');
    Halt(1)
  end;
  Val(ParamStr(2), Order, Code);
  Val(ParamStr(3), OutLen, Code);
  if (Order < 2) or (Order > MaxPat) then Halt(1);

  Randomize;
  LoadText;

  for K := 1 to Order - 1 do
  begin
    Pattern[K] := Text[K];
    Write(Pattern[K])
  end;

  Emitted := Order - 1;
  while Emitted < OutLen do
  begin
    NextChar;
    Write(Chosen);
    SlidePattern;
    Emitted := Emitted + 1
  end;
  Writeln
end.
