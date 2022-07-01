Class {
	#name : #MicCSSStylerCommand,
	#superclass : #CmCommand,
	#category : #'Microdown-HTMLExporter-Spec-Commands'
}

{ #category : #initialization }
MicCSSStylerCommand class >> defaultIconName [
	^self subclassResponsibility 
]

{ #category : #'instance creation' }
MicCSSStylerCommand class >> forSpecContext: anObject [

	self flag: 'This helper is needed so icons can be displayed through #defaultIconName in class side subclasses (oposed to sending #iconNamed: to the command manually)'.
	^ (self forSpecWithIconNamed: self defaultIconName)
		context: anObject;
		yourself
]
