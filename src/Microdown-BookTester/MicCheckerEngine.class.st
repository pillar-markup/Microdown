"
I am a generic engine that reads a configuration dictionary and instantiates, configures and runs the appropriate checkers.
I discover all available checkers by looking at all subclasses of MicChecker that respond to #checkerName.

Usage example:
	| engine config reslts |
	config := OrderedDictionary new.
	config at: 'Vocabulary' put: { ('colour' -> 'color') }.
	config at: 'HeaderCapitalization' put: 'uppercase'.
	config at: 'EnglishTypographic' put:nil.
	engine := MicCheckerEngine new.
	results := engine runOn: 'myFile.md' asFileReference withConfiguration: config.
	results do: [ :r | Transcript showCr: r explanation ].
"
Class {
	#name : 'MicCheckerEngine',
	#superclass : 'Object',
	#category : 'Microdown-BookTester-Core',
	#package : 'Microdown-BookTester',
	#tag : 'Core'
}

{ #category : 'as yet unclassified' }
MicCheckerEngine >> checkersFromConfiguration: aConfiguration [
	| availableCheckers activeCheckers |
	availableCheckers := Dictionary new.
	MicChecker allSubclasses do: [ :aClass |
		availableCheckers at: aClass checkerName put: aClass ].
		activeCheckers := OrderedCollection new.
		aConfiguration keysAndValuesDo: [ :key :value |
			| checkerClass checker |
			checkerClass := availableCheckers at: key ifAbsent: [ nil ].
			checkerClass ifNotNil: [ 
				checker := checkerClass new.
				checker configureFrom: value.
				activeCheckers add: checker
			 ]
		 ].
	^ activeCheckers 
]

{ #category : 'as yet unclassified' }
MicCheckerEngine >> runOn: aFileReference withConfiguration: aConfiguration [
	| activeCheckers results |
	activeCheckers := self checkersFromConfiguration: aConfiguration.
	results := OrderedCollection new.
	activeCheckers do: [ :checker |
		checker checkProject: aFileReference.
		results addAll: checker results
		 ].
	^ results 
]
