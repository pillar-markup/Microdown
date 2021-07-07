Class {
	#name : #MicTitlePrinter,
	#superclass : #Object,
	#instVars : [
		'levels'
	],
	#classVars : [
		'StrategyMapping'
	],
	#category : #'Microdown - HeadReunbering'
}

{ #category : #accessing }
MicTitlePrinter class >> defaultStrategyMapping [

	^ Dictionary
		  with: 'number' -> MicLevelNumberPrinter
		  with: 'roman' -> MicLevelRomanPrinter
		  with: 'letter' -> MicLevelLetterPrinter
		  with: 'upperLetter' -> MicLevelUpperLetterPrinter
]

{ #category : #accessing }
MicTitlePrinter class >> printerSpecFor: aStyle [ 

	^ (self strategyClassMapping at: aStyle) new
	
	
]

{ #category : #accessing }
MicTitlePrinter class >> strategyClassMapping [
	^ StrategyMapping ifNil: [ StrategyMapping := self defaultStrategyMapping ]
]

{ #category : #initialization }
MicTitlePrinter >> initialize [

	super initialize.
	levels := Array new: self maxLevels.
	1 to: self maxLevels do: [ :l | 
		levels at: l put: (MicLevelNumberPrinter new
				 headerSize: l;
				 level: l;
				 printer: self;
				 yourself) ]
]

{ #category : #accessing }
MicTitlePrinter >> level1 [

	^ levels at: (self levelIndex: 1)
]

{ #category : #accessing }
MicTitlePrinter >> level1: aLevelSpec [

	self level: aLevelSpec n: 1
]

{ #category : #accessing }
MicTitlePrinter >> level2 [

	^ levels at: (self levelIndex: 2)
]

{ #category : #accessing }
MicTitlePrinter >> level2: aLevelSpec [

	self level: aLevelSpec n: 2
]

{ #category : #accessing }
MicTitlePrinter >> level3 [

	^ levels at: (self levelIndex: 3)
]

{ #category : #accessing }
MicTitlePrinter >> level3: aLevelSpec [

	self level: aLevelSpec n: 3
]

{ #category : #accessing }
MicTitlePrinter >> level4 [

	^levels at: (self levelIndex: 4)
]

{ #category : #accessing }
MicTitlePrinter >> level4: aLevelSpec [

	self level: aLevelSpec n: 4
]

{ #category : #accessing }
MicTitlePrinter >> level5 [

	^ levels at: (self levelIndex: 5)
]

{ #category : #accessing }
MicTitlePrinter >> level5: aLevelSpec [

	self level: aLevelSpec n: 5
]

{ #category : #accessing }
MicTitlePrinter >> level6 [

	^ levels at: (self levelIndex: 6)
]

{ #category : #accessing }
MicTitlePrinter >> level6: aLevelSpec [

	self level: aLevelSpec n: 6
]

{ #category : #accessing }
MicTitlePrinter >> level7 [

	^ levels at: (self levelIndex: 7)
]

{ #category : #accessing }
MicTitlePrinter >> level7: aLevelSpec [

	self level: aLevelSpec n: 7
]

{ #category : #accessing }
MicTitlePrinter >> level: aLevelSpec n: n [

	levels at: (self levelIndex: n) put: aLevelSpec.
	aLevelSpec level: n.
	aLevelSpec printer: self.
]

{ #category : #accessing }
MicTitlePrinter >> levelConfigurationFor: aHeader [
	"to get the associated level spec"
	
	^ self perform: ('level' , aHeader level asString) asSymbol
]

{ #category : #accessing }
MicTitlePrinter >> levelIndex: wishedLevel [
	
	^ wishedLevel
]

{ #category : #accessing }
MicTitlePrinter >> leveln: anInteger [

	^ self perform: ('level', anInteger asString) asSymbol 
]

{ #category : #initialization }
MicTitlePrinter >> maxLevels [
	^ 7
]

{ #category : #builder }
MicTitlePrinter >> printerSpecFor: aStyle [

	^ self class printerSpecFor: aStyle
]

{ #category : #accessing }
MicTitlePrinter >> strategyClassFor: aStyle [
	
	^ self class strategyClassMapping at: aStyle ifAbsent: [ 'roman' ]
]
