"
Inspect the following code to see a MicTree in the inspector

```
| text micTree|
text := '# Section 1
blabla
## Section 2
blabla
# Section 3
blabla
'.
micTree := MicroDownParser parse: text.
GTMicTreeInspector new: micTree
```
"
Class {
	#name : #GTMicTreeInspector,
	#superclass : #Object,
	#instVars : [
		'micTree'
	],
	#category : #'Microdown-InspectorExtensions'
}

{ #category : #'instance creation' }
GTMicTreeInspector class >> new: aTree [
	^ self new micTree: aTree
]

{ #category : #'as yet unclassified' }
GTMicTreeInspector >> inspectionMicTree [
	<inspectorPresentationOrder: 35 title: 'MicTree'>

	^ SpTreePresenter new 
		roots: { micTree };
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

{ #category : #accessing }
GTMicTreeInspector >> micTree: aTree [
	micTree := aTree
]
