Class {
	#name : #MicBuildAllStrategy,
	#superclass : #MicBuildStrategy,
	#category : #'Microdown - HTML'
}

{ #category : #'instance-creation' }
MicBuildAllStrategy class >> on: aPRProject [ 
	
	^ self new
		project: aPRProject;
		yourself
]

{ #category : #accessing }
MicBuildAllStrategy >> filesToBuildOn: aProject [
	
	| children |
	children := aProject baseDirectory children reject: [ :maybeExcludedDirectory |
		self shouldExcludeDirectory: maybeExcludedDirectory ].

	^ children flatCollect: [ :each |
		each allChildren
			select: [ :file | file isFile and: [ self isSupportedExtension: file extension ] ]
			thenCollect: [ :file | 
				(MicInputDocument forFile: file)
					project: aProject;
					yourself ] ]
]

{ #category : #'private - testing' }
MicBuildAllStrategy >> shouldExcludeDirectory: aFileReference [ 
	
	^ aFileReference basename beginsWithAnyOf: #( '.' '_' )
]
