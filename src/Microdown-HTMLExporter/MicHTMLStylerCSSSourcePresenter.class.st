"
Holds a text presenter to display CSS source, and a status bar indicating the size of the CSS.

"
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
		add: 'CSS' height: self class labelHeight;
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
		whenTextChangedDo: [ : text | self updateSizeMessage: text size ]
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

{ #category : #initialization }
MicHTMLStylerCSSSourcePresenter >> updateSizeMessage: anInteger [

	self cssStatusbarPresenter 
		pushMessage: 
			(String streamContents: [ : stream |
				stream
					<< 'File size: ';
					<< anInteger asFileSizeString ])
]
