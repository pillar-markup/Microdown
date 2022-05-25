"
I'm version producing LaTeX for the SBA template.
In the future (once the templatedWriter is working) I should get removed.
"
Class {
	#name : #MicSBALaTeXWriter,
	#superclass : #MicLaTeXWriter,
	#category : #'Microdown-LaTeXExporter'
}

{ #category : #accessing }
MicSBALaTeXWriter class >> writerName [
	^ #miclatex:sbabook
]

{ #category : #accessing }
MicSBALaTeXWriter >> folderName [
	^ #latex
]

{ #category : #protected }
MicSBALaTeXWriter >> monospaceMacro [
	^ 'textcode'
]

{ #category : #protected }
MicSBALaTeXWriter >> optionalParametersForFloatingScript: aCodeBlock [

	| parameters |
	parameters := OrderedCollection new.
	parameters add: 'float'.
	aCodeBlock hasLabel ifTrue: [ parameters add: 'label=', aCodeBlock label ].
	^ parameters asCommaString
]

{ #category : #protected }
MicSBALaTeXWriter >> tabularEnvironment [
	^ 'fullwidthtabular'
]

{ #category : #accessing }
MicSBALaTeXWriter >> templateForConfiguration: aConfiguration [
	^ 'main.mustache'
]

{ #category : #protected }
MicSBALaTeXWriter >> visitCode: aCodeBlock [
	
	aCodeBlock hasCaption | aCodeBlock hasLabel
		ifTrue: [ self writeFloatingCodeSnippet: aCodeBlock ]
		ifFalse: [ self writeInFlowCodeSnippet: aCodeBlock ]
]

{ #category : #protected }
MicSBALaTeXWriter >> writeFloatingCodeSnippet: aCodeBlock [ 
	canvas environment
		name: 'listing';
		optParameter: (self optionalParametersForFloatingScript: aCodeBlock);
		"parameter: (self languageForScript: aScript) sbaString;"
		flag: #todo;"should come back here"
		parameter: 'smalltalk';
		parameter: [ aCodeBlock captionElements collect: [ :each | each accept: self ] ];
		with: [
			self writeRawDuring: [ canvas nextPutAllLines: aCodeBlock body ].
			canvas newLine ]
]

{ #category : #protected }
MicSBALaTeXWriter >> writeInFlowCodeSnippet: aCodeBlock [
	canvas environment
		name: 'displaycode';
		"parameter: (self languageForScript: aScript) sbaString;"
		flag: #todo;"should come back here"
		parameter: 'smalltalk';
		with: [
			self writeRawDuring: [ "there is no need of the writeRaw if I do not call high level " 
				canvas nextPutAllLines: aCodeBlock body ].
			canvas newLine ]
]
