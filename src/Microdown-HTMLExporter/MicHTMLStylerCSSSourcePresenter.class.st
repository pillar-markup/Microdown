Class {
	#name : #MicHTMLStylerCSSSourcePresenter,
	#superclass : #MicHTMLStylerAbstractPresenter,
	#instVars : [
		'cssSourceCodePresenter',
		'cssStatusbarPresenter'
	],
	#category : #'Microdown-HTMLExporter-Spec'
}

{ #category : #accessing }
MicHTMLStylerCSSSourcePresenter >> cssSourceCodePresenter [

	^ cssSourceCodePresenter
]

{ #category : #accessing }
MicHTMLStylerCSSSourcePresenter >> cssSourceCodePresenter: anObject [

	cssSourceCodePresenter := anObject
]

{ #category : #accessing }
MicHTMLStylerCSSSourcePresenter >> cssStatusbarPresenter [

	^ cssStatusbarPresenter
]

{ #category : #accessing }
MicHTMLStylerCSSSourcePresenter >> cssStatusbarPresenter: anObject [

	cssStatusbarPresenter := anObject
]

{ #category : #layout }
MicHTMLStylerCSSSourcePresenter >> defaultLayout [ 

	^ self layout: (SpBoxLayout newTopToBottom 
		add: cssSourceCodePresenter;
		add: cssStatusbarPresenter height: self statusBarHeight;
		yourself)
]

{ #category : #initialization }
MicHTMLStylerCSSSourcePresenter >> initializePresenters [

	cssSourceCodePresenter := self newText
		beWrapWord;
		beNotEditable;
		text: self selectedCssFrameworkSourceCode;
		whenChangedDo: [ : text | self cssStatusbarPresenter pushMessage: text size asString ]
		yourself.
	cssStatusbarPresenter := self newStatusBar
]

{ #category : #private }
MicHTMLStylerCSSSourcePresenter >> selectedCssFrameworkSourceCode [

	^ styler selectedCssFrameworkSourceCode
]

{ #category : #accessing }
MicHTMLStylerCSSSourcePresenter >> text: aString [

	self cssSourceCodePresenter text: aString
]
