Class {
	#name : 'MicLastPeriodInHeaderChecker',
	#superclass : 'MicChecker',
	#instVars : [
		'headerLevelThreshold'
	],
	#category : 'Microdown-Rules',
	#package : 'Microdown-Rules'
}

{ #category : 'accessing' }
MicLastPeriodInHeaderChecker >> configureWith: aDictionary [
	headerLevelThreshold := (aDictionary at: 'headerLevelThreshold' ifAbsent: [ 4 ]) asInteger
]

{ #category : 'accessing' }
MicLastPeriodInHeaderChecker >> headerLevelThreshold [
	^ headerLevelThreshold
]

{ #category : 'visiting' }
MicLastPeriodInHeaderChecker >> initialize [
	super initialize.
	headerLevelThreshold := 4.
	results := OrderedCollection new.
]

{ #category : 'accessing' }
MicLastPeriodInHeaderChecker >> requiresPeriodFor: aHeader [
	^ aHeader level >= headerLevelThreshold
]

{ #category : 'visiting' }
MicLastPeriodInHeaderChecker >> results [
    ^ results
]

{ #category : 'visiting' }
MicLastPeriodInHeaderChecker >> visit: aNode [
	aNode accept: self
]

{ #category : 'visiting' }
MicLastPeriodInHeaderChecker >> visitHeader: aHeader [
	(self requiresPeriodFor: aHeader) ifTrue: [ 
		results add: aHeader
	]
]

{ #category : 'visiting' }
MicLastPeriodInHeaderChecker >> visitRoot: aRoot [
	aRoot children do: [ :each | each accept: self ]
]
