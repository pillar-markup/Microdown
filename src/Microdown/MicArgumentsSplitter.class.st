Class {
	#name : #MicArgumentsSplitter,
	#superclass : #Object,
	#category : #'Microdown-Parser'
}

{ #category : #process }
MicArgumentsSplitter class >> findNameAndArguments: aStream [
	| foundName foundArguments | 
	foundName := aStream upTo: self parserClass argumentListStartDelimiter first.
	foundArguments := ZnResourceMetaUtils parseQueryFrom: aStream.
	^ { foundName . foundArguments } asArray
]

{ #category : #accessing }
MicArgumentsSplitter class >> parserClass [
	^ MicroDownParser 
]
