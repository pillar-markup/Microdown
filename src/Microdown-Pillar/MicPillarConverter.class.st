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

{ #category : #'visiting inline' }
MicPillarConverter >> visitAnchorReferenceBlock: aMicAnchorReferenceBlock [
 	^ PRInternalLink new anchor: aMicAnchorReferenceBlock substring; yourself
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
 	| prBlock |
 	prBlock := PRCodeblock new.
 	prBlock text: aMicCodeBlock code.
 	aMicCodeBlock arguments keysAndValuesDo: [ :k :v |
 		prBlock parameterAt: k put: v
 		 ].
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
 	| classPillar |
 	classPillar := PRAbstractAnnotation findClassAcceptingTag: aMicEnvironmentBlock name ifNone: [ PRUndefinedAnnotation ].
 	^ classPillar new parameters: aMicEnvironmentBlock arguments
]

{ #category : #'visiting inline' }
MicPillarConverter >> visitFigure: aMicFigureBlock [
 	| aPRFigure |
 	aPRFigure := self urlBlock: aMicFigureBlock.
 	^ aPRFigure label: aMicFigureBlock substring; parameters: aMicFigureBlock parameters; yourself
]

{ #category : #visiting }
MicPillarConverter >> visitFormatBlock: aMicFormatBlock [
 	| childrenAsPillar |
 	childrenAsPillar := aMicFormatBlock isOnlyChild 
 		ifTrue: [ {(PRText new text: aMicFormatBlock substring )} ] 
 		ifFalse: [ aMicFormatBlock children collect: [:e | e asPillar ] ].
 	 ^ aMicFormatBlock associatedPillarClass new
 				setChildren: childrenAsPillar;
 				yourself
]

{ #category : #visiting }
MicPillarConverter >> visitHeader: aMicHeaderBlock [
 	^ PRHeader new
 		level: aMicHeaderBlock level;
 		setChildren: (aMicHeaderBlock pillarFromString: aMicHeaderBlock header);
 		yourself
]

{ #category : #visiting }
MicPillarConverter >> visitHorizontalLine: aMicHorizontalLineBlock [
 	^ PRHorizontalRule new 
]

{ #category : #'visiting inline' }
MicPillarConverter >> visitItalic: aMicItalic [
 	^ self formatBlock: aMicItalic
]

{ #category : #'visiting inline' }
MicPillarConverter >> visitLink: aMicLink [
 	^ self urlBlock: aMicLink
]

{ #category : #visiting }
MicPillarConverter >> visitListItem: aMicListItemBlock [
 	^ PRListItem new
 		setChildren: (aMicListItemBlock pillarFromString: aMicListItemBlock text), (aMicListItemBlock children collect: [:child| child asPillar]);
 		yourself

]

{ #category : #visiting }
MicPillarConverter >> visitMath: aMicMathBlock [
 	^ PRMathEnvironment new 
 		add: (PRText content: aMicMathBlock body);
 		yourself
]

{ #category : #'visiting inline' }
MicPillarConverter >> visitMathInline: aMicMathInline [
 	^ self formatBlock: aMicMathInline
]

{ #category : #'visiting inline' }
MicPillarConverter >> visitMonospace: aMicMonospace [
 	^ self formatBlock: aMicMonospace
]

{ #category : #visiting }
MicPillarConverter >> visitOrderedList: aMicOrderedListBlock [
 	^ PROrderedList new
 		setChildren: (aMicOrderedListBlock children collect: [ :child | child asPillar ]);
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
	^  self formatBlock: aMicRaw
	
]

{ #category : #visiting }
MicPillarConverter >> visitRoot: aMicRootBlock [
 	^ PRDocument new
 		setChildren: (aMicRootBlock children collect: [ :child | child asPillar ]);
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
 		setChildren: (aMicUnorderedListBlock children collect:[:child| child asPillar]);
 		yourself
]
