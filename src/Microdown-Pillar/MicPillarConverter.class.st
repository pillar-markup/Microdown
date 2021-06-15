"
This visitor is about to disappeared. It was created just to make sure that we can have asPillar expressed as a visitor. 
Now this visitor is working on non expanded code blocks.
"
Class {
	#name : #MicPillarConverter,
	#superclass : #MicrodownVisitor,
	#category : #'Microdown-Pillar-Visitor'
}

{ #category : #formatting }
MicPillarConverter >> formatBlock: aMicFormatBlock [
	| childrenAsPillar |
	childrenAsPillar := aMicFormatBlock isOnlyChild 
		ifTrue: [ {(PRText new text: aMicFormatBlock substring )} ] 
		ifFalse: [ aMicFormatBlock children collect: [:e | e accept: self ] ].
	 ^ aMicFormatBlock associatedPillarClass new
				setChildren: childrenAsPillar;
				yourself
]

{ #category : #formatting }
MicPillarConverter >> urlBlock: aMicUrlBlock [
	^ aMicUrlBlock associatedPillarClass new
		setChildren: (( aMicUrlBlock inlineParse: aMicUrlBlock substring) collect: [:n | n accept: self]);
		reference: aMicUrlBlock url;
		yourself
]

{ #category : #visiting }
MicPillarConverter >> visitAnchor: aMicAnchorBlock [
 	^ PRAnchor new name: aMicAnchorBlock label; yourself
]

{ #category : #'visiting inline' }
MicPillarConverter >> visitAnchorReference: aMicAnchorReference [
	^ PRInternalLink new anchor: aMicAnchorReference substring; yourself
]

{ #category : #visiting }
MicPillarConverter >> visitAnnotated: aMicAnnotatedBlock [
 	^ PRAnnotatedParagraph new 
			annotation: aMicAnnotatedBlock label; 
			setChildren: (aMicAnnotatedBlock pillarFrom: aMicAnnotatedBlock textElements);
			yourself
]

{ #category : #'visiting inline' }
MicPillarConverter >> visitAnnotation: aMicAnnotation [
	| argumentsSplitter |
	argumentsSplitter := MicArgumentsSplitter withString: aMicAnnotation substring.
	aMicAnnotation name: argumentsSplitter  name.
	aMicAnnotation arguments: argumentsSplitter arguments.
	^ aMicAnnotation associatedPillarClass new parameters: aMicAnnotation arguments
]

{ #category : #'visiting inline' }
MicPillarConverter >> visitBold: aMicBold [
 	^ self formatBlock: aMicBold
]

{ #category : #visiting }
MicPillarConverter >> visitCode: aMicCodeBlock [

	| prBlock par pillars |
	prBlock := PRCodeblock new.
	prBlock text: aMicCodeBlock code.

	aMicCodeBlock arguments keysAndValuesDo: [ :k :v | 
		(aMicCodeBlock arguments includesKey: #language)
			ifFalse: [ 
				(aMicCodeBlock arguments keys first = k and: v isEmptyOrNil)
					ifTrue: [ prBlock parameterAt: 'language' put: k ]
					ifFalse: [ prBlock parameterAt: k put: v ] ]
			ifTrue: [ prBlock parameterAt: k put: v ] ].

	aMicCodeBlock hasCaption
		ifTrue: [ 
			prBlock parameters removeKey: #caption.
			par := PRParagraph new.
			pillars := aMicCodeBlock captionElements collect: [ :each | 
				           each accept: MicPillarConverter new ].
			pillars do: [ :each | par add: each ].
			prBlock setCaption: par ]
		ifFalse: [ 
			prBlock caption "Yes this is not an accessor but something with side effect" ].
	^ prBlock
]

{ #category : #visiting }
MicPillarConverter >> visitComment: aMicCommentBlock [
 	^ PRCommentedLine new
 			text: aMicCommentBlock text ;
 			yourself
]

{ #category : #visiting }
MicPillarConverter >> visitEnvironment: aMicEnvironmentBlock [
	
	| env |
	env := PREnvironment new 
			name: aMicEnvironmentBlock name;
			parameters: aMicEnvironmentBlock arguments; yourself.
	env add: (PRParagraph withAll: (aMicEnvironmentBlock pillarFrom: aMicEnvironmentBlock bodyElements)).
	^ env
]

{ #category : #'visiting inline' }
MicPillarConverter >> visitFigure: aMicFigureBlock [

	| aPRFigure |
	aPRFigure := self urlBlock: aMicFigureBlock.
	^ aPRFigure
		  label: aMicFigureBlock substring;
		  parameters: aMicFigureBlock arguments;
		  yourself
]

{ #category : #visiting }
MicPillarConverter >> visitFormatBlock: aMicFormatBlock [
 	| childrenAsPillar |
 	childrenAsPillar := aMicFormatBlock isOnlyChild 
 		ifTrue: [ {(PRText new text: aMicFormatBlock substring )} ] 
 		ifFalse: [ aMicFormatBlock children collect: [:e | e accept: self ] ].
 	 ^ aMicFormatBlock associatedPillarClass new
 				setChildren: childrenAsPillar;
 				yourself
]

{ #category : #visiting }
MicPillarConverter >> visitHeader: aMicHeaderBlock [

 	^ PRHeader new
		level: aMicHeaderBlock level;
		setChildren: (aMicHeaderBlock children collect: [:each | each accept: self ]);
		yourself
]

{ #category : #visiting }
MicPillarConverter >> visitHorizontalLine: anHorizontalLineBlock [
 	^ PRHorizontalRule new 
]

{ #category : #'visiting inline' }
MicPillarConverter >> visitItalic: aMicItalic [
 	^ self formatBlock: aMicItalic
]

{ #category : #'visiting inline' }
MicPillarConverter >> visitLink: aMicLink [

	^ aMicLink associatedPillarClass new
		  setChildren:
			  ((aMicLink inlineParse: aMicLink substring) collect: [ :n | 
					   n accept: MicPillarConverter new ]);
		  reference: aMicLink url;
		  yourself
]

{ #category : #visiting }
MicPillarConverter >> visitListItem: aMicListItemBlock [
 	^ PRListItem new
		setChildren: (aMicListItemBlock pillarFrom: aMicListItemBlock textElements), (aMicListItemBlock children collect: [:child| child accept: self]);
		yourself;
		yourself

]

{ #category : #visiting }
MicPillarConverter >> visitMath: aMicMathBlock [
 	| captionElements |
	captionElements := aMicMathBlock arguments at: 'caption' ifAbsent: [ nil ]. 
	captionElements isNotNil 
		ifTrue: [ aMicMathBlock arguments at: 'caption' put: (aMicMathBlock pillarFrom: captionElements) ].
	^ PRMathEnvironment new 
	 	parameters: aMicMathBlock arguments;   
		add: (PRText content: aMicMathBlock body);
		yourself
]

{ #category : #'visiting inline' }
MicPillarConverter >> visitMathInline: aMicMathInline [
 	^ self formatBlock: aMicMathInline
]

{ #category : #'visiting inline' }
MicPillarConverter >> visitMetaData: aMicMetaData [
 	^ PRMetadata new 
			metadata: (STON fromString: '{', aMicMetaData body, '}'); yourself
]

{ #category : #'visiting inline' }
MicPillarConverter >> visitMonospace: aMicMonospace [
 	^ self formatBlock: aMicMonospace
]

{ #category : #visiting }
MicPillarConverter >> visitOrderedList: aMicOrderedListBlock [
 	^ PROrderedList new
		setChildren: (aMicOrderedListBlock children collect: [ :child | child accept: self ]);
		counter: aMicOrderedListBlock startIndex;
		yourself
]

{ #category : #visiting }
MicPillarConverter >> visitParagraph: aMicParagraphBlock [
 	^ PRParagraph  new
		setChildren: (aMicParagraphBlock pillarFromString: aMicParagraphBlock text);
		yourself
]

{ #category : #visiting }
MicPillarConverter >> visitQuote: aMicQuoteBlock [
 	^ PRPreformatted new
 		setChildren: (aMicQuoteBlock pillarFromString: aMicQuoteBlock text);
 		yourself
]

{ #category : #'visiting inline' }
MicPillarConverter >> visitRaw: aMicRaw [
	^ PRRaw new text: aMicRaw substring ; yourself 
	
]

{ #category : #visiting }
MicPillarConverter >> visitRoot: aMicRootBlock [
 	^ PRDocument new
 		setChildren: (aMicRootBlock children collect: [ :child | child accept: self ]);
 		yourself

]

{ #category : #'visiting inline' }
MicPillarConverter >> visitStrike: aMicStrike [
 	^ self formatBlock: aMicStrike
]

{ #category : #'visiting inline' }
MicPillarConverter >> visitText: aMicTextBlock [
 	^ PRText new text: aMicTextBlock substring ; yourself
]

{ #category : #visiting }
MicPillarConverter >> visitUnorderedList: aMicUnorderedListBlock [
 	^ PRUnorderedList new
 		setChildren: (aMicUnorderedListBlock children collect:[:child| child accept: self]);
 		yourself
]
