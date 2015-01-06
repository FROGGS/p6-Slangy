use Slangy <COBOL>;
use Test;

slang COBOL {
    has $.grammar = grammar :: does Slangy::Grammar {
        rule statementlist(|) {
            '' parse_okay || <.panic: "Confused">
        }
    }
    has $.actions = class :: does Slangy::Actions {
        method statementlist($/) {
            ok True, "Can parse a simple statementlist";
        }
    }
}

#~ sub EXPORT(|) {
    #~ $*MAIN        := 'COBOL';
    #~ %*LANG<COBOL> := COBOL.new.grammar;
    #~ {}
#~ }
