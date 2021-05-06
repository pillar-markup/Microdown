Class {
	#name : #MDAsPillar,
	#superclass : #MDVisitor,
	#category : #'Microdown-Pillar-Visitor'
}

{ #category : #visiting }
MDAsPillar >> visitMicAnchorBlock: aMicAnchorBlock [
	^ PRAnchor new name: aMicAnchorBlock label; yourself
]

{ #category : #visiting }
MDAsPillar >> visitMicAnnotatedBlock: aMicAnnotatedBlock [
	^ PRAnnotatedParagraph new 
			annotation: aMicAnnotatedBlock label; 
			setChildren: (aMicAnnotatedBlock pillarFromString: aMicAnnotatedBlock text);
			yourself
]

{ #category : #visiting }
MDAsPillar >> visitMicCodeBlock: aMicCodeBlock [
	| prBlock |
	prBlock := PRCodeblock new.
	prBlock text: aMicCodeBlock code.
	aMicCodeBlock arguments keysAndValuesDo: [ :k :v |
		prBlock parameterAt: k put: v
		 ].
	^ prBlock
]

{ #category : #visiting }
MDAsPillar >> visitMicCommentBlock: aMicCommentBlock [
	^ PRCommentedLine new
			text: aMicCommentBlock text ;
			yourself
]

{ #category : #visiting }
MDAsPillar >> visitMicEnvironmentBlock: aMicEnvironmentBlock [
	| classPillar |
	classPillar := PRAbstractAnnotation findClassAcceptingTag: aMicEnvironmentBlock name ifNone: [ PRUndefinedAnnotation ].
	^ classPillar new parameters: aMicEnvironmentBlock arguments
]

{ #category : #visiting }
MDAsPillar >> visitMicFigureBlock: aMicFigureBlock [
	| aPRFigure |
	aPRFigure := self visitMicFormatBlock: aMicFigureBlock.
	^ aPRFigure label: aMicFigureBlock substring; parameters: aMicFigureBlock parameters; yourself
]

{ #category : #visiting }
MDAsPillar >> visitMicFormatBlock: aMicFormatBlock [
	| childrenAsPillar |
	childrenAsPillar := aMicFormatBlock isOnlyChild 
		ifTrue: [ {(PRText new text: aMicFormatBlock substring )} ] 
		ifFalse: [ aMicFormatBlock children collect: [:e | e asPillar ] ].
	 ^ aMicFormatBlock associatedPillarClass new
				setChildren: childrenAsPillar;
				yourself
]

{ #category : #visiting }
MDAsPillar >> visitMicHeaderBlock: aMicHeaderBlock [
	^ PRHeader new
		level: aMicHeaderBlock level;
		setChildren: (aMicHeaderBlock pillarFromString: aMicHeaderBlock header);
		yourself
]

{ #category : #visiting }
MDAsPillar >> visitMicHorizontalLineBlock: aMicHorizontalLineBlock [
	^ PRHorizontalRule new 
]

{ #category : #visiting }
MDAsPillar >> visitMicListItemBlock: aMicListItemBlock [
	^ PRListItem new
		setChildren: (aMicListItemBlock pillarFromString: aMicListItemBlock text), (aMicListItemBlock children collect: [:child| child asPillar]);
		yourself
]

{ #category : #visiting }
MDAsPillar >> visitMicMathBlock: aMicMathBlock [
	^ PRMathEnvironment new 
		add: (PRText content: aMicMathBlock body);
		yourself
]

{ #category : #visiting }
MDAsPillar >> visitMicOrderedListBlock: aMicOrderedListBlock [
	^ PROrderedList new
		setChildren: (aMicOrderedListBlock children collect: [ :child | child asPillar ]);
		counter: aMicOrderedListBlock startIndex;
		yourself
]

{ #category : #visiting }
MDAsPillar >> visitMicParagraphBlock: aMicParagraphBlock [
	^ PRParagraph  new
		setChildren: (aMicParagraphBlock pillarFromString: aMicParagraphBlock text);
		yourself
]

{ #category : #visiting }
MDAsPillar >> visitMicQuoteBlock: aMicQuoteBlock [
	^ PRPreformatted new
		setChildren: (aMicQuoteBlock pillarFromString: aMicQuoteBlock text);
		yourself
]

{ #category : #visiting }
MDAsPillar >> visitMicRootBlock: aMicRootBlock [
	^ PRDocument new
		setChildren: (aMicRootBlock children collect: [ :child | child asPillar ]);
		yourself
]

{ #category : #visiting }
MDAsPillar >> visitMicTextBlock: aMicTextBlock [
	^ PRText new text: aMicTextBlock substring ; yourself 
]

{ #category : #visiting }
MDAsPillar >> visitMicUnorderedListBlock: aMicUnorderedListBlock [
	^ PRUnorderedList new
		setChildren: (aMicUnorderedListBlock children collect:[:child| child asPillar]);
		yourself
]
