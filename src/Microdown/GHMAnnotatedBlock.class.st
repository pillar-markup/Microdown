Class {
	#name : #GHMAnnotatedBlock,
	#superclass : #GHMAbstractBlock,
	#instVars : [
		'label',
		'isClosed',
		'body',
		'firstLine'
	],
	#category : #'Microdown-Model'
}

{ #category : #testing }
GHMAnnotatedBlock >> addLineAndReturnNextNode: line [
	"line is assumed to be of the form '@@label some text
	
	'
	"

	isClosed
		ifTrue: [ ^ self ].
	label 
		ifNil: [ 
			| indexOfFirstSpace |
			indexOfFirstSpace := line indexOf: Character space.
			label := line copyFrom: self lineMarkup size + 1 to: indexOfFirstSpace - 1.
			body := (line copyFrom: indexOfFirstSpace + 1 to: line size) trim ]
		ifNotNil: [ body := body , String cr , line ]
]

{ #category : #accessing }
GHMAnnotatedBlock >> body [
	^ body
]

{ #category : #testing }
GHMAnnotatedBlock >> canConsumeLine: line [
	"return if this block can consume line"

	"it can be dangerous but let us try"
	^ line isNotEmpty 
]

{ #category : #initialization }
GHMAnnotatedBlock >> initialize [

	super initialize.
	isClosed := false.
]

{ #category : #accessing }
GHMAnnotatedBlock >> label [
	^ label
]

{ #category : #testing }
GHMAnnotatedBlock >> lineMarkup [

	^ self subclassResponsibility
]
