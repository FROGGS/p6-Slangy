BEGIN {} # Currently required, or Slangy dies with "Can't find class 'COBOL'"
use Test;

BEGIN plan 1;

{
    use COBOL;
    parse_okay
}
