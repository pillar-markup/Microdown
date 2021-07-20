Class {
	#name : #MicBuildListStrategy,
	#superclass : #MicBuildStrategy,
	#instVars : [
		'files'
	],
	#category : #'Microdown - HTML'
}

{ #category : #'instance-creation' }
MicBuildListStrategy class >> list: aCollection [ 
	
	^ self new
		files: aCollection;
		yourself
]

{ #category : #accessing }
MicBuildListStrategy >> files: aCollection [ 
	files := aCollection asSet
]

{ #category : #accessing }
MicBuildListStrategy >> filesToBuildOn: aProject [

	^ files collect: [ :file | 
				(MicInputDocument forFile: (aProject baseDirectory resolve: file))
					project: aProject;
					yourself ]
]
