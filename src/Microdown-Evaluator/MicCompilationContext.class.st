Class {
	#name : #MicCompilationContext,
	#superclass : #MicElement,
	#instVars : [
		'configuration',
		'input'
	],
	#category : #'Microdown-Evaluator'
}

{ #category : #'instance creation' }
MicCompilationContext class >> configuration: aConfiguration [
	^ self new configuration: aConfiguration
]

{ #category : #'instance creation' }
MicCompilationContext class >> isAbstract [
	^ false
]

{ #category : #'instance creation' }
MicCompilationContext class >> withDocument: aDocument [
	^ self new
		input: aDocument;
		yourself
]

{ #category : #'instance creation' }
MicCompilationContext class >> withDocument: aDocument withConfiguration: aConfiguration [
	^ self new
		input: aDocument;
		configuration: aConfiguration;
		yourself
]

{ #category : #accessing }
MicCompilationContext >> configuration [
	^ configuration
]

{ #category : #accessing }
MicCompilationContext >> configuration: aConfiguration [
	configuration := aConfiguration
]

{ #category : #accessing }
MicCompilationContext >> input [
	^ input
]

{ #category : #accessing }
MicCompilationContext >> input: anObject [
	input := anObject
]
