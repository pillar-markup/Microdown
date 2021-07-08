Class {
	#name : #MicArchetype,
	#superclass : #Object,
	#instVars : [
		'name',
		'project',
		'directory'
	],
	#category : #'Microdown - HTML'
}

{ #category : #accessing }
MicArchetype >> directory [

	^ directory ifNil: [ ^ FileLocator imageDirectory / 'archetypes' / name ] 
]

{ #category : #accessing }
MicArchetype >> directory: aDirectory [
	directory := aDirectory
]

{ #category : #actions }
MicArchetype >> installIn: baseDirectory [

	(self directory / 'sample')
		children do: [ :child | child copyAllTo: baseDirectory / child basename ].
		
	self installTemplateIn: baseDirectory.
]

{ #category : #actions }
MicArchetype >> installTemplateIn: baseDirectory [ 

	| destination |
	destination := baseDirectory / '_support'.
	destination ensureDeleteAll.

	"Because we move the support folder into a folder called _support"
	(self directory / 'support')
		copyAllTo: destination
]

{ #category : #accessing }
MicArchetype >> name: aString [ 
	name := aString
]

{ #category : #accessing }
MicArchetype >> project: aPRProject [ 
	project := aPRProject
]

{ #category : #validating }
MicArchetype >> validateExists [

	self directory exists ifFalse: [
		self error: 'Archetype ', name, ' does not exist'
	].
]
