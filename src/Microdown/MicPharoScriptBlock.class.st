"
I am a block containing a Pharo expression.

I am given semantics by these visitors:
$$script
(Microdown builder  in:  [ :aBuilder |
	aBuilder unorderedListDuring: [
		(MicrodownVisitor allSubclasses 
		select: [ :class |  class includesSelector: #visitScript: ])
		do:  [:class |  aBuilder  item:  [ aBuilder monospace:  (class name, '>>#visitScript:') 
]]]]) contents
$$

or

$$script|width=100
Morph new
$$
"
Class {
	#name : #MicPharoScriptBlock,
	#superclass : #MicMathBlock,
	#category : #'Microdown-Extensions'
}

{ #category : #accessing }
MicPharoScriptBlock class >> tag [

	^ #script
]

{ #category : #visiting }
MicPharoScriptBlock >> accept: aVisitor [
	^ aVisitor visitScript: self
]

{ #category : #accessing }
MicPharoScriptBlock >> title [
	^ arguments at: 'title' ifAbsent: [ '' ]
]
