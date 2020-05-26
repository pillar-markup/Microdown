"
I characterize one liners. 
They do not know consumeLine: beacuse they are composed of only one line. 
"
Class {
	#name : #GHMSingleLineBlock,
	#superclass : #GHMAbstractBlock,
	#category : #'Microdown-Model'
}

{ #category : #testing }
GHMSingleLineBlock >> canConsumeLine: line [
	"return if this block can consume line"
	
	^ false 
]
