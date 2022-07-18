Class {
	#name : #MicHTMLConfiguration,
	#superclass : #Object,
	#instVars : [
		'scriptLanguage',
		'targetAttribute'
	],
	#category : #'Microdown-HTMLExporter-Visitor'
}

{ #category : #accessing }
MicHTMLConfiguration >> beTargetAttributeBlank [
	"Opens the linked document in a new window or tab (Microdown default)"
	
	self targetAttribute: '_blank'
]

{ #category : #accessing }
MicHTMLConfiguration >> beTargetAttributeParent [
	"Opens the linked document in the parent frame"
	
	self targetAttribute: '_parent'
]

{ #category : #accessing }
MicHTMLConfiguration >> beTargetAttributeSelf [
	"Opens the linked document in the same frame as it was clicked (W3C default)"
	
	self targetAttribute: '_self'
]

{ #category : #accessing }
MicHTMLConfiguration >> beTargetAttributeTop [
	"Opens the linked document in the full body of the window"
	
	self targetAttribute: '_top'
]

{ #category : #defaults }
MicHTMLConfiguration >> defaultScriptLanguage [
	"Answer a <PRAbstractScriptLanguage>"

	^ PRRealScriptLanguage for: 'pharo'
]

{ #category : #defaults }
MicHTMLConfiguration >> defaultTargetAttribute [
	"By default, opens the linked document in a new window or tab"

	^ '_blank'
]

{ #category : #accessing }
MicHTMLConfiguration >> targetAttribute [
	"Answer a <String>. The target attribute specifies where to open the linked document."

	^ targetAttribute
		ifNil: [ targetAttribute := self defaultTargetAttribute ]
]

{ #category : #accessing }
MicHTMLConfiguration >> targetAttribute: aString [
	"Set the receiver's target to be aString"
	
	targetAttribute := aString
]
