Class {
	#name : 'FigureCaptionVisitor',
	#superclass : 'MicrodownVisitor',
	#category : 'Microdown-BookSanitizer-Checkers',
	#package : 'Microdown-BookSanitizer',
	#tag : 'Checkers'
}

{ #category : 'visiting - inline elements' }
FigureCaptionVisitor >> visitFigure: aFigure [

	| aText aFigureCaption atext2 |
	aText := aFigure text.
	aFigureCaption := MicFigureCaptionSanitizer new.
	atext2 := aFigureCaption sanitize: aText.
	aFigure children first bodyString: atext2
]
