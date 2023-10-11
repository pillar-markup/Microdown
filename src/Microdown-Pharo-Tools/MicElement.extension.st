Extension { #name : 'MicElement' }

{ #category : '*Microdown-Pharo-Tools' }
MicElement >> inspectionMicTree [
	"
	(MicroDownParser parse: '# hello 
Yes microdown is cool') inspect
	"
	<inspectorPresentationOrder: 930 title: 'MicTree'>
	^ SpTreePresenter new
		  roots: { self };
		  children: [ :aNode | aNode children ];
		  display: [ :each | 
			  String streamContents: [ :stream | each displayStringOn: stream ] ];
		  yourself
]
