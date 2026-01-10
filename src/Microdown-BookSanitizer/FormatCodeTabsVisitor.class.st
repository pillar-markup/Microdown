Class {
	#name : 'FormatCodeTabsVisitor',
	#superclass : 'BookSanitizerVisitor',
	#category : 'Microdown-BookSanitizer',
	#package : 'Microdown-BookSanitizer'
}

{ #category : 'visiting' }
FormatCodeTabsVisitor >> visitCode: aMicCodeBlock [

	aMicCodeBlock body: (MicCodeCorrectTabs new sanitize: aMicCodeBlock code)
]
