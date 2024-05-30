"
I make sure that microdown file are parsed with a microdown parser. 
This way I can integrate within the pillar pipeline in a modular way.
"
Class {
	#name : 'MicMicrodownInputDocument',
	#superclass : 'MicInputDocument',
	#category : 'Microdown-Transformer',
	#package : 'Microdown-Transformer'
}

{ #category : 'registration' }
MicMicrodownInputDocument class >> doesHandleExtension: anExtension [

	^ #('md' 'mic' 'MD' 'MIC') includes: anExtension
]

{ #category : 'accessing' }
MicMicrodownInputDocument >> parsedDocument [

	^ self parserClass new parse: file contents
]

{ #category : 'accessing' }
MicMicrodownInputDocument >> parserClass [
	
	^ MicAbstractBlock new parserClass
]
