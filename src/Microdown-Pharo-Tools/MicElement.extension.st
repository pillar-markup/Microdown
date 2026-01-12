Extension { #name : 'MicElement' }

{ #category : '*Microdown-Pharo-Tools' }
MicElement >> inspectionMicTree: aBuilder [
	"
	(MicrodownParser parse: '# hello 
Yes microdown is cool') inspect
	"
	<inspectorPresentationOrder: 930 title: 'MicTree'>
	^ aBuilder newTree
		  roots: { self };
		  children: [ :aNode | aNode children ];
		  display: [ :each | 
			  String streamContents: [ :stream | each displayStringOn: stream ] ];
		  yourself
]
