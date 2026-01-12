Class {
	#name : 'FigureCaptionVisitorTest',
	#superclass : 'BookSanitizerVisitorTest',
	#category : 'Microdown-BookSanitizer-Tests',
	#package : 'Microdown-BookSanitizer-Tests'
}

{ #category : 'tests' }
FigureCaptionVisitorTest >> testVisitFigure [

	| aFigureBlock legendText anchorLabel captionElementsCollection visitor|

legendText := MicTextBlock new bodyString: 'i love pharo'.
captionElementsCollection := OrderedCollection with: legendText. 

anchorLabel := 'fig:pharo'. 

aFigureBlock := MicFigureBlock new.

aFigureBlock url: '/Users/monUser/Desktop/ventes_fig.png'. 

aFigureBlock 
    argumentAt: #label
    put: anchorLabel.

aFigureBlock captionElements: captionElementsCollection.

visitor := FigureCaptionVisitor new.

visitor visitFigure: aFigureBlock.

self assert: (aFigureBlock children first bodyString ) equals: 'I love pharo.'.

]
