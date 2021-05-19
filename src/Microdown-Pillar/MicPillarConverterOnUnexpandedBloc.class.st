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
MicPillarConverterOnUnexpandedBloc >> visitAnchorBlock: aMicAnchorBlock [
 	^ PRAnchor new name: aMicAnchorBlock label; yourself
]

{ #category : #'visiting inline' }
MicPillarConverterOnUnexpandedBloc >> visitAnchorReference: aMicAnchorReferenceBlock [
 	^ PRInternalLink new anchor: aMicAnchorReferenceBlock substring; yourself
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitAnnotatedBlock: aMicAnnotatedBlock [
 	^ PRAnnotatedParagraph new 
 			annotation: aMicAnnotatedBlock label; 
 			setChildren: (aMicAnnotatedBlock pillarFromString: aMicAnnotatedBlock text);
 			yourself
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitCodeBlock: aMicCodeBlock [
 	| prBlock |
 	prBlock := PRCodeblock new.
 	prBlock text: aMicCodeBlock code.
 	aMicCodeBlock arguments keysAndValuesDo: [ :k :v |
 		prBlock parameterAt: k put: v
 		 ].
 	^ prBlock
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitCommentBlock: aMicCommentBlock [
 	^ PRCommentedLine new
 			text: aMicCommentBlock text ;
 			yourself
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitEnvironmentBlock: aMicEnvironmentBlock [
 	| classPillar |
 	classPillar := PRAbstractAnnotation findClassAcceptingTag: aMicEnvironmentBlock name ifNone: [ PRUndefinedAnnotation ].
 	^ classPillar new parameters: aMicEnvironmentBlock arguments
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitFigure: aMicFigureBlock [
 	| aPRFigure |
 	aPRFigure := super visit: self.
 	^ aPRFigure label: aMicFigureBlock substring; parameters: aMicFigureBlock parameters; yourself
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitFormatBlock: aMicFormatBlock [
 	| childrenAsPillar |
 	childrenAsPillar := aMicFormatBlock isOnlyChild 
 		ifTrue: [ {(PRText new text: aMicFormatBlock substring )} ] 
 		ifFalse: [ aMicFormatBlock children collect: [:e | e asPillar ] ].
 	 ^ aMicFormatBlock associatedPillarClass new
 				setChildren: childrenAsPillar;
 				yourself
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitHeaderBlock: aMicHeaderBlock [
 	^ PRHeader new
 		level: aMicHeaderBlock level;
 		setChildren: (aMicHeaderBlock pillarFromString: aMicHeaderBlock header);
 		yourself
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitHorizontalLineBlock: aMicHorizontalLineBlock [
 	^ PRHorizontalRule new 
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitListItemBlock: aMicListItemBlock [
 	^ PRListItem new
 		setChildren: (aMicListItemBlock pillarFromString: aMicListItemBlock text), (aMicListItemBlock children collect: [:child| child asPillar]);
 		yourself

]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitMathBlock: aMicMathBlock [
 	^ PRMathEnvironment new 
 		add: (PRText content: aMicMathBlock body);
 		yourself
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitOrderedListBlock: aMicOrderedListBlock [
 	^ PROrderedList new
 		setChildren: (aMicOrderedListBlock children collect: [ :child | child asPillar ]);
 		counter: aMicOrderedListBlock startIndex;
 		yourself
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitParagraphBlock: aMicParagraphBlock [
 	^ PRParagraph  new
 		setChildren: (aMicParagraphBlock pillarFromString: aMicParagraphBlock text);
 		yourself
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitQuoteBlock: aMicQuoteBlock [
 	^ PRPreformatted new
 		setChildren: (aMicQuoteBlock pillarFromString: aMicQuoteBlock text);
 		yourself
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitRootBlock: aMicRootBlock [
 	^ PRDocument new
 		setChildren: (aMicRootBlock children collect: [ :child | child asPillar ]);
 		yourself

]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitTextBlock: aMicTextBlock [
 	^ PRText new text: aMicTextBlock substring ; yourself
]

{ #category : #visiting }
MicPillarConverterOnUnexpandedBloc >> visitUnorderedListBlock: aMicUnorderedListBlock [
 	^ PRUnorderedList new
 		setChildren: (aMicUnorderedListBlock children collect:[:child| child asPillar]);
 		yourself
]
