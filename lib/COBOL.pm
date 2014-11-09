BEGIN say 'before';
use Slangy <COBOL>;
BEGIN say 'after';

slang COBOL {
    has $.grammar = grammar :: is Slangy::Grammar {
        rule statementlist(|) { ';'? bb }
    }
}

#~ sub EXPORT(|) {
    #~ $*MAIN        := 'COBOL';
    #~ %*LANG<COBOL> := COBOL.new.grammar;
    #~ {}
#~ }
