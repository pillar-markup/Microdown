Class {
	#name : #MicMathChecker,
	#superclass : #MicRichTextComposer,
	#instVars : [
		'errors'
	],
	#category : #'Microdown-Checker'
}

{ #category : #visiting }
MicMathChecker class >> visitMath:  aMicMathEnvironment
	aMicMathEnvironment isClosed ifFalse: [^ canvas <<  '$$ - SYNTAXE LATEX ERROR - $$' asText].
	super visitMath: aMicMathEnvironment.
]

{ #category : #visiting }
MicMathChecker class >> visit: aDocument
	super visit: aDocument.
]

{ #category : #accessing }
MicMathChecker class >> errors
	^ errors
]

{ #category : #initialization }
MicMathChecker class >> initialize 
	errors := OrderedCollection new.
]