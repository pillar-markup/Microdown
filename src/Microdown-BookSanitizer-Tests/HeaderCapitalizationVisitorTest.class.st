Class {
	#name : 'HeaderCapitalizationVisitorTest',
	#superclass : 'BookSanitizerVisitorTest',
	#category : 'Microdown-BookSanitizer-Tests',
	#package : 'Microdown-BookSanitizer-Tests'
}

{ #category : 'tests' }
HeaderCapitalizationVisitorTest >> testVisitHeader [

    | aHeader aParagraph aTextBlock aHeaderCapitalizationVisitor |

    aHeaderCapitalizationVisitor := HeaderCapitalizationVisitor new.
    aHeader := MicHeaderBlock new.

    aParagraph := MicParagraphBlock new.

    aTextBlock := MicTextBlock new.
    aTextBlock bodyString: 'I made A C3P project'.
    aHeader children add: aTextBlock.

    aHeaderCapitalizationVisitor visitHeader: aHeader.
	
    self 
		assert: aHeader children first bodyString 
		equals: 'I Made a C3P Project'.

]
