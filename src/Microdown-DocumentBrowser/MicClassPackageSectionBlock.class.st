"
I represent a section which is **not** sectioned as I am expected to be small. My subsections are left empty, and all is stored in the preample
"
Class {
	#name : #MicClassPackageSectionBlock,
	#superclass : #MicSectionBlock,
	#instVars : [
		'myClass'
	],
	#category : #'Microdown-DocumentBrowser-Model'
}

{ #category : #'instance creation' }
MicClassPackageSectionBlock >> classOfDoc [
	 ^myClass  
]

{ #category : #'instance creation' }
MicClassPackageSectionBlock >> classOfDoc: aClassOrManifest [
	myClass := aClassOrManifest 
]

{ #category : #'instance creation' }
MicClassPackageSectionBlock >> from: nodeStream [
	"I store the entire document in the preamble as class comments are not big"
	[ nodeStream atEnd ] whileFalse: [ 
		nodeStream next parent: self preamble ].
	^ self
]

{ #category : #accessing }
MicClassPackageSectionBlock >> icon [
	^ self iconNamed: #page
]
