Extension { #name : #MicAbstractBlock }

{ #category : #'*Microdown-Pharo-Tools' }
MicAbstractBlock >> inspectionMicTree [
	"
	(MicroDownParser parse: '# hello 
Yes microdown is cool') inspect
	"
	<inspectorPresentationOrder: 35 title: 'MicTree'>
	^ SpTreePresenter new
		  roots: { self };
		  children: [ :aNode | aNode children ];
		  display: [ :each | 
			  String streamContents: [ :stream | each displayStringOn: stream ] ];
		  yourself
]
