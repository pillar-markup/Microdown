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
MicAnchoredSectionTableFigureChecker >> addResultFor: aTextBlock in: aParagraph detail: aString [
	results add: (MicFigSectTableResult new
		micElement: aTextBlock;
		inFile: aParagraph fromFile;
		detail: aString;
		yourself)
]

{ #category : 'visiting' }
MicAnchoredSectionTableFigureChecker >> analyzeWords: words of: aTextBlock hasAnchor: hasAnchor in: aParagraph [
	namedElements do: [ :ref |
		self checkNamingIn: words of: aTextBlock reference: ref hasAnchor: hasAnchor in: aParagraph.
		self checkMissingAnchorsIn: words of: aTextBlock reference: ref hasAnchor: hasAnchor in: aParagraph ]
]

{ #category : 'visiting' }
MicAnchoredSectionTableFigureChecker >> checkMissingAnchorsIn: words of: aTextBlock reference: ref hasAnchor: hasAnchor in: aParagraph [
	| lastWord |
	lastWord := words last.
	
	words do: [ :word |
		(word = ref capitalized and: [ word ~= lastWord or: [ hasAnchor not ] ]) ifTrue: [
			self addResultFor: aTextBlock in: aParagraph detail: 'missing anchor for ' , word ] ]
]

{ #category : 'visiting' }
MicAnchoredSectionTableFigureChecker >> checkNamingIn: words of: aTextBlock reference: ref hasAnchor: hasAnchor in: aParagraph [
	| lastWord |
	hasAnchor ifFalse: [ ^ self ].
	lastWord := words last.
	lastWord asLowercase = ref ifFalse: [ ^ self ].
	
	(words size > 1 and: [ (words at: words size - 1) asLowercase = 'the' ])
		ifTrue: [ self addResultFor: aTextBlock in: aParagraph detail: (words at: words size - 1) , ' ' , lastWord ]
		ifFalse: [ lastWord = ref ifTrue: [ self addResultFor: aTextBlock in: aParagraph detail: lastWord ] ]
]

{ #category : 'visiting' }
MicAnchoredSectionTableFigureChecker >> initialize [

	super initialize.
	"in the future we may expose an API to change such element list"
	
	namedElements := #( 'figure' 'table' 'section' 'equation' 'lemma'
	                    'listing' )
]

{ #category : 'visiting' }
MicAnchoredSectionTableFigureChecker >> processTextBlock: aTextBlock at: index in: aParagraph children: children [
	| words hasAnchor |
	words := aTextBlock bodyString substrings.
	words isEmpty ifTrue: [ ^ self ].
	hasAnchor := index < children size and: [ (children at: index + 1) isKindOf: MicAnchorReferenceBlock ].
	
	self analyzeWords: words of: aTextBlock hasAnchor: hasAnchor in: aParagraph
]

{ #category : 'visiting' }
MicAnchoredSectionTableFigureChecker >> visitParagraph: aMicParagraph [
	| children |
	children := aMicParagraph children.
	
	children doWithIndex: [ :child :index |
		(child isKindOf: MicTextBlock) ifTrue: [
			self processTextBlock: child at: index in: aMicParagraph children: children ] ]
]
