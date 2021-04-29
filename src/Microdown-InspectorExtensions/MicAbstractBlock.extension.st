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
					stream
						nextPutAll: each class name.
						each class = MicHeaderBlock ifTrue: 
							[ stream nextPutAll: '( level ';
							nextPutAll: each level asString;
							nextPutAll: ' )' ].
			 ] ];
		yourself
]
