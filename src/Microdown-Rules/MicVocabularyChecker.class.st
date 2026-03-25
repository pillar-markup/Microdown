"
I check that certain vocabulary is not used. I'm configured with a list of pairs showing the vocabulary that should not be used and the correct one. 

```
	checker := MicVocabularyChecker new.
	checker pairs: {
			('sub-presenter' -> 'subpresenter').
			('sub presenter' -> 'subpresenter').
			('meta object' -> 'metaobject').
			('back-end' -> 'backend').
			('back end' -> 'backend').
			('Pharo Image' -> 'Pharo image').
			('colour' -> 'color').
			('colours' -> 'colors').
```
"
Class {
	#name : 'MicVocabularyChecker',
	#superclass : 'MicChecker',
	#instVars : [
		'patternPairs'
	],
	#category : 'Microdown-Rules-Vocabulary',
	#package : 'Microdown-Rules',
	#tag : 'Vocabulary'
}

{ #category : 'public - name' }
MicVocabularyChecker class >> checkerName [
	^ 'Vocabulary'
]

{ #category : 'configuration help' }
MicVocabularyChecker class >> configurationPart [
	"self configurationPart"
	
	^ STON toJsonStringPretty: { self checkerName . 
		{
			{'sub-presenter' . 'subpresenter'} .
			{'sub presenter' . 'subpresenter'} .
			{'meta object' . 'metaobject'} .
			{'back-end' . 'backend'} .
			{'back end' . 'backend'} } }
]

{ #category : 'configuration help' }
MicVocabularyChecker class >> explanationForConfiguration [
	"self explanationForConfiguration"
	
	^ String streamContents: [:str | 
		str << self comment. 
		str cr.
		str << 'In the pillar.conf file you add the following key values:'. 
		str cr.
		str << self configurationPart ]
]

{ #category : 'visiting - inline elements' }
MicVocabularyChecker >> checkText: aMicText [

	patternPairs do: [ :patternPair |
			"note that match: ignore upper/lower case differences."
			(patternPair key match: aMicText bodyString ) ifTrue: [
					results add: (MicUseofWrongVocabularyResult new
							 micElement: aMicText;
							 inFile: aMicText fromFile;
							 patternPair: patternPair) ] ]
]

{ #category : 'configuration' }
MicVocabularyChecker >> configureFrom: aCollectionOfArrays [
	"aCollectionOfArrays is #( #(str1 str2) ... )"

	aCollectionOfArrays isCollection 
		ifTrue: [ self pairs: (aCollectionOfArrays collect: [:each | each first -> each second]) ]
]

{ #category : 'visiting' }
MicVocabularyChecker >> initialize [ 
	super initialize.
	patternPairs := OrderedCollection new
]

{ #category : 'visiting - inline elements' }
MicVocabularyChecker >> pairs [ 
	^ patternPairs 
]

{ #category : 'visiting - inline elements' }
MicVocabularyChecker >> pairs: aCollectionOfPairs [

	patternPairs := aCollectionOfPairs collect: [ :each | ('*' , each key , '*') -> each value  ] 
	
]

{ #category : 'visiting - inline elements' }
MicVocabularyChecker >> visitText: aMicText [

	self checkText: aMicText
]
