Class {
	#name : 'FigureCaptionVisitor',
	#superclass : 'BookSanitizerVisitor',
	#category : 'Microdown-BookSanitizer',
	#package : 'Microdown-BookSanitizer'
}

{ #category : 'visiting - inline elements' }
FigureCaptionVisitor >> visitFigure: aFigure [

	| aText aFigureCaption atext2 |
	aText := aFigure text.
	aFigureCaption := MicFigureCaptionSanitizer new.
	atext2 := aFigureCaption sanitize: aText.
	aFigure children first bodyString: atext2
]
