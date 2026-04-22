"
I check that references to figures, sections and tables are correctly capitalized before an anchor and that there is no 'the' before. 
When there is a number (given by an anchor) the section/figure... must be uppercased and not preceeded by the or an.

In Microdown, references should be written as and the following texts are correct

```
- in Figure *@figureExample@*
- in Section *@sectionExample@*
- in Table *@tableExample*
```

The following are incorrect and will be flagged:

```
- figure *@figureExample@* (lowercase)
- the figure *@figureExample@* (preceeded by 'the')
- section *@sectionExample@* (lowercase)
```
"
Class {
	#name : 'MicAnchoredSectionTableFigureChecker',
	#superclass : 'MicChecker',
	#instVars : [
		'namedElements'
	],
	#category : 'Microdown-Rules-AnchoredReferences',
	#package : 'Microdown-Rules',
	#tag : 'AnchoredReferences'
}

{ #category : 'public - name' }
MicAnchoredSectionTableFigureChecker class >> checkerName [ 

	^ 'NotTheFigureX'
]

{ #category : 'visiting' }
MicAnchoredSectionTableFigureChecker >> initialize [

	super initialize.
	"in the future we may expose an API to change such element list"
	
	namedElements := #( 'figure' 'table' 'section' 'equation' 'lemma'
	                    'listing' )
]

{ #category : 'visiting' }
MicAnchoredSectionTableFigureChecker >> visitParagraph: aMicParagraph [

	| children |
	children := aMicParagraph children.
	1 to: children size - 1 do: [ :index |
			| child nextChild |
			child := children at: index.
			nextChild := children at: index + 1.
			(nextChild isKindOf: MicAnchorReferenceBlock) ifTrue: [
					(child isKindOf: MicTextBlock) ifTrue: [
							| words lastWord foundThe |
							words := child bodyString substrings.
							words isEmpty ifFalse: [
									lastWord := words last.
									foundThe := false.
									"verify the figure/section/table"
									namedElements do: [ :ref |
											lastWord asLowercase = ref ifTrue: [
													words size > 1 ifTrue: [
															| prevWord |
															prevWord := words at: words size - 1.
															prevWord asLowercase = 'the' ifTrue: [
																	foundThe := true.
																	results add: (MicFigSectTableResult new
																			 micElement: child;
																			 inFile: aMicParagraph fromFile;
																			 detail: 'the ' , lastWord;
																			 yourself) ] ] ] ].
									"check figure/section/table"
									foundThe ifFalse: [
											namedElements
												do: [ :ref |
														lastWord = ref ifTrue: [
																results add: (MicFigSectTableResult new
																		 micElement: child;
																		 inFile: aMicParagraph fromFile;
																		 detail: lastWord;
																		 yourself) ] ] ] ] ] ] ]
]
