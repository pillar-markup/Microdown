Class {
	#name : #GTMicroDownAST,
	#superclass : #Object,
	#instVars : [
		'micTree'
	],
	#category : #'Microdown-InspectorExtensions'
}

{ #category : #'instance creation' }
GTMicroDownAST class >> new: aTree [
	^ self new micTree: aTree
]

{ #category : #'as yet unclassified' }
GTMicroDownAST >> inspectionMicTree [
	<inspectorPresentationOrder: 35 title: 'AST'>

	^ SpTreePresenter new 
		roots: { micTree };
		children: [ :aNode | aNode children ];
		display: [ :each | 
			String
				streamContents: [ :stream | 
					stream
						nextPutAll: each class name
						"nextPut: $(;
						nextPutAll: ((each formattedCode truncateTo: 50) copyReplaceAll: String cr with: String space);
						nextPut: $)"
			 ] ];
		yourself
]

{ #category : #accessing }
GTMicroDownAST >> micTree: aTree [
	micTree := aTree
]
