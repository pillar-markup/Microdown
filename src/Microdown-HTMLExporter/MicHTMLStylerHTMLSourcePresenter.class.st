"
Holds a text presenter to display HTML source, and a status bar indicating the size of the HTML.

"
Class {
	#name : #MicHTMLStylerHTMLSourcePresenter,
	#superclass : #MicHTMLStylerAbstractPresenter,
	#instVars : [
		'htmlSourceCodePresenter',
		'htmlStatusbarPresenter'
	],
	#category : #'Microdown-HTMLExporter-Spec'
}

{ #category : #layout }
MicHTMLStylerHTMLSourcePresenter >> defaultLayout [ 

	^ self layout: (SpBoxLayout newTopToBottom 
		add: 'HTML' height: self class labelHeight;
		add: htmlSourceCodePresenter;
		add: htmlStatusbarPresenter height: self statusBarHeight;
		yourself)
]

{ #category : #accessing }
MicHTMLStylerHTMLSourcePresenter >> htmlSourceCodePresenter [

	^ htmlSourceCodePresenter
]

{ #category : #accessing }
MicHTMLStylerHTMLSourcePresenter >> htmlSourceCodePresenter: anObject [

	htmlSourceCodePresenter := anObject
]

{ #category : #accessing }
MicHTMLStylerHTMLSourcePresenter >> htmlStatusbarPresenter [

	^ htmlStatusbarPresenter
]

{ #category : #accessing }
MicHTMLStylerHTMLSourcePresenter >> htmlStatusbarPresenter: anObject [

	htmlStatusbarPresenter := anObject
]

{ #category : #initialization }
MicHTMLStylerHTMLSourcePresenter >> initializePresenters [

	htmlSourceCodePresenter := self newText
		beWrapWord;
		beNotEditable;
		whenTextChangedDo: [ : text | self updateSizeMessage: text size ]		
		yourself.
	htmlStatusbarPresenter := self newStatusBar.
]

{ #category : #accessing }
MicHTMLStylerHTMLSourcePresenter >> text [

	^ self htmlSourceCodePresenter text
]

{ #category : #accessing }
MicHTMLStylerHTMLSourcePresenter >> text: aString [

	self htmlSourceCodePresenter text: aString
]

{ #category : #initialization }
MicHTMLStylerHTMLSourcePresenter >> updateSizeMessage: anInteger [

	self htmlStatusbarPresenter 
		pushMessage: 
			(String streamContents: [ : stream |
				stream
					<< 'File size: ';
					<< anInteger asFileSizeString ])
]
