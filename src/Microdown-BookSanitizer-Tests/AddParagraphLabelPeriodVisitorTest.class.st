Class {
	#name : 'AddParagraphLabelPeriodVisitorTest',
	#superclass : 'BookSanitizerVisitorTest',
	#category : 'Microdown-BookSanitizer-Tests',
	#package : 'Microdown-BookSanitizer-Tests'
}

{ #category : 'tests' }
AddParagraphLabelPeriodVisitorTest >> testVisitParagraph [

	| aParagraph aTextBlock aAddParagraphLabelPeriodVisitor |
	aAddParagraphLabelPeriodVisitor := AddParagraphLabelPeriodVisitor new.

	aParagraph := MicParagraphBlock new.

	aTextBlock := MicTextBlock new.
	aTextBlock bodyString: '2. Analyse

Bonjour tout le monde1

Bonjour tout le monde2

3 Contact

Bonjour tout le monde3

4. ttttt

Bonjour tout le monde4

5. fpzfpe'.
	aParagraph children add: aTextBlock.

	aAddParagraphLabelPeriodVisitor visitParagraph: aParagraph.

	self
		assert: aParagraph children first bodyString
		equals: '2. Analyse

Bonjour tout le monde1

Bonjour tout le monde2

3. Contact

Bonjour tout le monde3

4. ttttt

Bonjour tout le monde4

5. fpzfpe'.
]
