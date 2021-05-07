"
This visitor is about to disappeared. It was created just to make sure that we can have asPillar expressed as a visitor. 
Now this visitor is working on non expanded code blocks.
"
Class {
	#name : #MicPillarConverterOnUnexpandedBloc,
	#superclass : #MicrodownVisitor,
	#category : #'Microdown-Pillar-Visitor'
}

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitMicAnchorBlock: aMicAnchorBlock [
 	^ PRAnchor new name: aMicAnchorBlock label; yourself
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitMicAnnotatedBlock: aMicAnnotatedBlock [
 	^ PRAnnotatedParagraph new 
 			annotation: aMicAnnotatedBlock label; 
 			setChildren: (aMicAnnotatedBlock pillarFromString: aMicAnnotatedBlock text);
 			yourself
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitMicCodeBlock: aMicCodeBlock [
 	| prBlock |
 	prBlock := PRCodeblock new.
 	prBlock text: aMicCodeBlock code.
 	aMicCodeBlock arguments keysAndValuesDo: [ :k :v |
 		prBlock parameterAt: k put: v
 		 ].
 	^ prBlock
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitMicCommentBlock: aMicCommentBlock [
 	^ PRCommentedLine new
 			text: aMicCommentBlock text ;
 			yourself
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitMicEnvironmentBlock: aMicEnvironmentBlock [
 	| classPillar |
 	classPillar := PRAbstractAnnotation findClassAcceptingTag: aMicEnvironmentBlock name ifNone: [ PRUndefinedAnnotation ].
 	^ classPillar new parameters: aMicEnvironmentBlock arguments
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitMicFigureBlock: aMicFigureBlock [
 	| aPRFigure |
 	aPRFigure := self accept: super.
 	^ aPRFigure label: aMicFigureBlock substring; parameters: aMicFigureBlock parameters; yourself
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitMicFormatBlock: aMicFormatBlock [
 	| childrenAsPillar |
 	childrenAsPillar := aMicFormatBlock isOnlyChild 
 		ifTrue: [ {(PRText new text: aMicFormatBlock substring )} ] 
 		ifFalse: [ aMicFormatBlock children collect: [:e | e asPillar ] ].
 	 ^ aMicFormatBlock associatedPillarClass new
 				setChildren: childrenAsPillar;
 				yourself
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitMicHeaderBlock: aMicHeaderBlock [
 	^ PRHeader new
 		level: aMicHeaderBlock level;
 		setChildren: (aMicHeaderBlock pillarFromString: aMicHeaderBlock header);
 		yourself
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitMicHorizontalLineBlock: aMicHorizontalLineBlock [
 	^ PRHorizontalRule new 
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitMicListItemBlock: aMicListItemBlock [
 	^ PRListItem new
 		setChildren: (aMicListItemBlock pillarFromString: aMicListItemBlock text), (aMicListItemBlock children collect: [:child| child asPillar]);
 		yourself

]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitMicMathBlock: aMicMathBlock [
 	^ PRMathEnvironment new 
 		add: (PRText content: aMicMathBlock body);
 		yourself
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitMicOrderedListBlock: aMicOrderedListBlock [
 	^ PROrderedList new
 		setChildren: (aMicOrderedListBlock children collect: [ :child | child asPillar ]);
 		counter: aMicOrderedListBlock startIndex;
 		yourself
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitMicParagraphBlock: aMicParagraphBlock [
 	^ PRParagraph  new
 		setChildren: (aMicParagraphBlock pillarFromString: aMicParagraphBlock text);
 		yourself
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitMicQuoteBlock: aMicQuoteBlock [
 	^ PRPreformatted new
 		setChildren: (aMicQuoteBlock pillarFromString: aMicQuoteBlock text);
 		yourself
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitMicRootBlock: aMicRootBlock [
 	^ PRDocument new
 		setChildren: (aMicRootBlock children collect: [ :child | child asPillar ]);
 		yourself

]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitMicTextBlock: aMicTextBlock [
 	^ PRText new text: aMicTextBlock substring ; yourself
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitMicUnorderedListBlock: aMicUnorderedListBlock [
 	^ PRUnorderedList new
 		setChildren: (aMicUnorderedListBlock children collect:[:child| child asPillar]);
 		yourself
]
