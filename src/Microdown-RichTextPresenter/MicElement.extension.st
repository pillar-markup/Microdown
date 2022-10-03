Extension { #name : #MicElement }

{ #category : #'*Microdown-RichTextPresenter' }
MicElement >> inspectionSectionRendered [

	<inspectorPresentationOrder: 950 title: 'Rendered'>
	^ MicrodownPresenter new document: self;yourself
]
