Class {
	#name : 'HeaderCapitalizationVisitor',
	#superclass : 'BookSanitizerVisitor',
	#category : 'Microdown-BookSanitizer-ToCure',
	#package : 'Microdown-BookSanitizer',
	#tag : 'ToCure'
}

{ #category : 'visiting' }
HeaderCapitalizationVisitor >> visitHeader: aHeader [
	
|aText aMicHeaderCapitalizationStrategy atext2|
aText := aHeader text.
aMicHeaderCapitalizationStrategy := MicHeaderCapitalizer new.
atext2 := aMicHeaderCapitalizationStrategy sanitize: aText.
aHeader children first bodyString: atext2.
]
