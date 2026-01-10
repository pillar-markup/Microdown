Class {
	#name : 'FormatCodeTabsVisitor',
	#superclass : 'BookSanitizerVisitor',
	#category : 'Microdown-BookSanitizer-ToCure',
	#package : 'Microdown-BookSanitizer',
	#tag : 'ToCure'
}

{ #category : 'visiting' }
FormatCodeTabsVisitor >> visitCode: aMicCodeBlock [

	aMicCodeBlock body: (MicCodeCorrectTabs new sanitize: aMicCodeBlock code)
]
