Class {
	#name : #MicrodownPresenterTest,
	#superclass : #MicTextPresenterTest,
	#category : #'Microdown-RichTextComposer-Tests-Presenter'
}

{ #category : #accessing }
MicrodownPresenterTest >> classToTest [
	^ MicrodownPresenter 
]

{ #category : #tests }
MicrodownPresenterTest >> testDocumentIsRendered [
	presenter document: (Microdown parse: '# Nice header').
	self assert: presenter text asString trim equals: 'Nice header'
]

{ #category : #tests }
MicrodownPresenterTest >> testDocumentIsRenderedFromString [
	presenter documentFromString: '# Nice header'.
	self assert: presenter text asString trim equals: 'Nice header'
]

{ #category : #tests }
MicrodownPresenterTest >> testwhenDocumentChangedDo [
	| wasHere |
	wasHere := false.
	presenter whenDocumentChangedDo: [ wasHere := true ].
	presenter document: (Microdown parse: '# Nice header').
	self assert: wasHere
]

{ #category : #tests }
MicrodownPresenterTest >> testwhenTextStylerChangedDo [
	| wasHere |
	wasHere := false.
	presenter document: (Microdown parse: '# Nice header').
	presenter whenTextStylerChangedDo: [ wasHere := true ].
	presenter textStyler: nil.
	self assert: wasHere
]
