Extension { #name : #Text }

{ #category : #'*Microdown-RichTextPresenter' }
Text >> inspectionRichText [
	<inspectorPresentationOrder: -1 title: 'RichText'>

	^ MicTextPresenter new text: self
]
