Extension { #name : #MicAbstractBlock }

{ #category : #'*Microdown-InspectorExtensions' }
MicAbstractBlock >> inspectionMicTree [
	<inspectorPresentationOrder: 35 title: 'MicTree'>

	^ SpTreePresenter new 
		roots: { self };
		children: [ :aNode | aNode children ];
		display: [ :each | 
			String
				streamContents: [ :stream | 
					each displayStringOn: stream						
			 ] ];
		yourself
]
