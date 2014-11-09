grammar Slangy::Grammar {
    token TOP { aaa }
    token thing { bbb }
}

class MetamodelX::SlangHOW is Metamodel::ClassHOW {
    has Mu $!grammar;

    method add_attribute(Mu \type, Mu \attribute) {
        if attribute.name eq '$!grammar' {
            $!grammar := attribute;
            #~ self.Metamodel::ClassHOW::add_method(type, 'grammar', $meth);
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
            $*MAIN        := $lang;
            say ::.keys;      # $_ $*DISPATCHER
            say UNIT::.keys;  # $! $/ $_ GLOBALish EXPORT $?PACKAGE ::?PACKAGE Slangy MetamodelX EXPORTHOW &EXPORT $=pod !UNIT_MARKER
            say OUTER::.keys; # $! $/ $_ $lang $*DISPATCHER &?ROUTINE RETURN
            %*LANG{$lang} := GLOBAL.WHO{$lang}.new.grammar;
            {}
        },
    }
}
