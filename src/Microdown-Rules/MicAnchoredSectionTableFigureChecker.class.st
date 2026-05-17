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
		'anchoredElements'
	],
	#category : 'Microdown-Rules-AnchoredReferences',
	#package : 'Microdown-Rules',
	#tag : 'AnchoredReferences'
}

{ #category : 'public - name' }
MicAnchoredSectionTableFigureChecker class >> checkerName [ 

	^ 'NotTheFigureX'
]

{ #category : 'configuration help' }
MicAnchoredSectionTableFigureChecker class >> objectsForJSONConfigurationPart [

	^ { #extraAnchoredElements -> {'note' }} asDictionary 
]

{ #category : 'checking' }
MicAnchoredSectionTableFigureChecker >> addErrorDetail: detailString on: aTextBlock inParagraph: aParagraph [

	results add: (MicFigSectTableResult new
		micElement: aTextBlock;
		inFile: aParagraph fromFile;
		detail: detailString;
		yourself)
]

{ #category : 'checking' }
MicAnchoredSectionTableFigureChecker >> analyzeWords: words inTextBlock: aTextBlock inParagraph: aParagraph anchorBlock: anchorBlock [

	anchoredElements do: [ :ref |
		self checkNamingFor: words 
			reference: ref 
			anchorBlock: anchorBlock 
			inTextBlock: aTextBlock 
			inParagraph: aParagraph.
		self checkMissingAnchorsFor: words 
			reference: ref 
			anchorBlock: anchorBlock 
			inTextBlock: aTextBlock 
			inParagraph: aParagraph ]
]

{ #category : 'accessing' }
MicAnchoredSectionTableFigureChecker >> anchoredElements [

	^ anchoredElements 
]

{ #category : 'checking' }
MicAnchoredSectionTableFigureChecker >> checkMissingAnchorsFor: words reference: ref anchorBlock: anchorBlock inTextBlock: aTextBlock inParagraph: aParagraph [

	| lastWord |
	lastWord := words last.
	words do: [ :word |
		(word = ref capitalized and: [ word ~= lastWord or: [ anchorBlock isNil ] ]) ifTrue: [
			self addErrorDetail: 'missing anchor for ' , word on: aTextBlock inParagraph: aParagraph ] ]
]

{ #category : 'checking' }
MicAnchoredSectionTableFigureChecker >> checkNamingFor: words reference: ref anchorBlock: anchorBlock inTextBlock: aTextBlock inParagraph: aParagraph [

	| lastWord anchorString |
	anchorBlock ifNil: [ ^ self ].
	lastWord := words last.
	lastWord asLowercase = ref ifFalse: [ ^ self ].

	(words size > 1 and: [
		 (words at: words size - 1) asLowercase = 'the' ])
		ifTrue: [
				anchorString := ' *@' , (anchorBlock bodyString ifNil: [ '' ])
				                , '@*'.
				self
					addErrorDetail:
					(words at: words size - 1) , ' ' , lastWord , anchorString
					on: aTextBlock
					inParagraph: aParagraph ]
		ifFalse: [
				lastWord = ref ifTrue: [
						anchorString := ' *@' , (anchorBlock bodyString ifNil: [ '' ])
						                , '@*'.
						self
							addErrorDetail: lastWord , anchorString
							on: aTextBlock
							inParagraph: aParagraph ] ]
]

{ #category : 'configuration' }
MicAnchoredSectionTableFigureChecker >> configureFrom: aDictionary [
	super configureFrom: aDictionary.
	
	aDictionary isDictionary ifFalse: [ ^ self ].
	
	aDictionary at: 'extraAnchoredElements' ifPresent: [ :elements |
		anchoredElements := (anchoredElements , elements) asSet asArray ]
]

{ #category : 'initialization' }
MicAnchoredSectionTableFigureChecker >> initialize [

	super initialize.
	anchoredElements := #( 'figure' 'table' 'section' 'equation' 'lemma'
	                    'listing' )
]

{ #category : 'checking' }
MicAnchoredSectionTableFigureChecker >> processTextBlock: aTextBlock atIndex: index withChildren: children inParagraph: aParagraph [
	| words anchorBlock |
	words := aTextBlock bodyString substrings.
	words isEmpty ifTrue: [ ^ self ].
	anchorBlock := (index < children size and: [ (children at: index + 1) isKindOf: MicAnchorReferenceBlock ])
		ifTrue: [ children at: index + 1 ]
		ifFalse: [ nil ].
	
	self analyzeWords: words inTextBlock: aTextBlock inParagraph: aParagraph anchorBlock: anchorBlock
]

{ #category : 'visiting' }
MicAnchoredSectionTableFigureChecker >> visitParagraph: aMicParagraph [
	| children |
	children := aMicParagraph children.
	children doWithIndex: [ :child :index |
		(child isKindOf: MicTextBlock) ifTrue: [
			self processTextBlock: child atIndex: index withChildren: children inParagraph: aMicParagraph ] ]
]
