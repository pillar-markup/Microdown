Class {
	#name : #MicBuildRootMainStrategy,
	#superclass : #MicBuildStrategy,
	#category : #'Microdown - HTML'
}

{ #category : #accessing }
MicBuildRootMainStrategy >> filesToBuildOn: aProject [ 
	"select the only file with microdown extension in current directory ; if there is no OR several microdown files, relative error is raised"
	
	| microdownFiles|
	microdownFiles := aProject baseDirectory children select: [ :each | each isFile and: [ self isSupportedExtension: each  extension ] ].
	microdownFiles ifEmpty: [ self error: 'There is no pillar file in the repository root.' ].
	microdownFiles size = 1 ifTrue: [ ^ { (MicInputDocument forFile: microdownFiles first) 
			project: aProject;
			yourself } ].
	self error: 'There is more than one pillar file in the repository root.'
]
