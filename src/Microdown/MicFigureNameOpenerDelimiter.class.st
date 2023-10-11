"
I am the opener delimiter for figure name.
"
Class {
	#name : 'MicFigureNameOpenerDelimiter',
	#superclass : 'MicAbstractDelimiter',
	#category : 'Microdown-Parser',
	#package : 'Microdown',
	#tag : 'Parser'
}

{ #category : 'accessing' }
MicFigureNameOpenerDelimiter class >> associatedInlineBlock [
	^ MicFigureBlock
]

{ #category : 'accessing' }
MicFigureNameOpenerDelimiter class >> associatedTypes [

	^ {  
		MicLinkNameDelimiter type.
		self type.
	}
]

{ #category : 'accessing' }
MicFigureNameOpenerDelimiter class >> isCloser [
	^ false
]

{ #category : 'accessing' }
MicFigureNameOpenerDelimiter class >> isOpener [
	^ true
]

{ #category : 'accessing' }
MicFigureNameOpenerDelimiter class >> markup [
	^ FigureNameOpenerMarkup
]

{ #category : 'accessing' }
MicFigureNameOpenerDelimiter class >> type [
	^ #figure
]

{ #category : 'dispatching' }
MicFigureNameOpenerDelimiter >> addInlineBlock: anIndex to: inlineParser [

	inlineParser linkOrFigureProcess: anIndex
]
