Class {
	#name : #MicSBALaTeXWriter,
	#superclass : #MicLaTeXWriter,
	#category : #'Microdown-LaTeXExporter'
}

{ #category : #protected }
MicSBALaTeXWriter >> monospaceMacro [
	^ 'textcode'
]

{ #category : #protected }
MicSBALaTeXWriter >> optionalParametersForFloatingScript: aCodeBlock [

	| parameters |
	self flag: #toRename.
	parameters := OrderedCollection new.
	parameters add: 'float'.
	aCodeBlock hasLabel ifTrue: [ parameters add: 'label=', aCodeBlock label ].
	aCodeBlock hasShortCaption ifTrue: [ parameters add: 'list text={', aCodeBlock shortCaption, '}' ].
	^ parameters asCommaString
]

{ #category : #protected }
MicSBALaTeXWriter >> tabularEnvironment [
	^ 'fullwidthtabular'
]

{ #category : #protected }
MicSBALaTeXWriter >> visitCodeblock: aCodeBlock [
	aCodeBlock hasCaption | aCodeBlock hasLabel
		ifTrue: [ self visitFloatingScript: aCodeBlock ]
		ifFalse: [ self visitInFlowScript: aCodeBlock ]
]

{ #category : #protected }
MicSBALaTeXWriter >> visitFloatingScript: aScript [ 
	canvas environment
		name: 'listing';
		optParameter: (self optionalParametersForFloatingScript: aScript);
		parameter: (self languageForScript: aScript) sbaString;
		parameter: [ self visitAll: aScript caption children ];
		with: [
			self writeRawDuring: [ self visitText: aScript ].
			canvas newLine ]
]

{ #category : #protected }
MicSBALaTeXWriter >> visitInFlowScript: aScript [ 
	canvas environment
		name: 'displaycode';
		"parameter: (self languageForScript: aScript) sbaString;"
		"should come back here"
		parameter: 'smalltalk';
		with: [
			self writeRawDuring: [ self visitText: aScript ].
			canvas newLine ]
]
