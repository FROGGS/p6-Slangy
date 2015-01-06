role Slangy::Grammar { }
role Slangy::Actions { }

class MetamodelX::SlangHOW is Metamodel::ClassHOW {
    has Mu $!grammar;
    has Mu $!actions;

    method add_attribute(Mu \type, Mu \attribute) {
        if attribute.name eq '$!grammar' {
            $!grammar := attribute;
            #~ self.Metamodel::ClassHOW::add_method(type, 'grammar', $meth);
        }
        elsif attribute.name eq '$!actions' {
            $!actions := attribute;
            #~ self.Metamodel::ClassHOW::add_method(type, 'actions', $meth);
        }
        #~ else {
            self.Metamodel::ClassHOW::add_attribute(type, attribute);
        #~ }
    }

    method compose(Mu \type) {
        die "A Slangy class needs to implement an attribute '\$!grammar'" unless $!grammar;

        my \composed := self.Metamodel::ClassHOW::compose(type);
        
        #~ %*LANG<COBOL> := Proxy.new( FETCH => -> | { composed.new.grammar }, STORE => -> | { } );
        #~ %*LANG<COBOL-actions> := $module{~$longname}.new.actions;
        
        composed
    }
}

my package EXPORTHOW {
    package DECLARE {
        constant slang = MetamodelX::SlangHOW;
    }
}

multi EXPORT(|) {
    die "Please provide the slang name like in: 'use Slangy <COBOL>;'";
}
multi EXPORT($lang) {
    {
        '&EXPORT' => -> {
            die "Could not find class '$lang'" unless GLOBAL.WHO{$lang}:exists;
            my $lang-class = GLOBAL.WHO{$lang}.new;
            die "'$lang' is not a slang" unless $lang-class.HOW ~~ MetamodelX::SlangHOW;
            %*LANG{$lang} := $lang-class.grammar;
            %*LANG{$lang~'-actions'} := $lang-class.actions;
            $*MAIN := $lang;
            {}
        },
    }
}
