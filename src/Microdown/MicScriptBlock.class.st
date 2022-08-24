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
"
Class {
	#name : #MicScriptBlock,
	#superclass : #MicMathBlock,
	#category : #'Microdown-Extensions'
}

{ #category : #accessing }
MicScriptBlock class >> tag [

	^ #script
]

{ #category : #visiting }
MicScriptBlock >> accept: aVisitor [
	^ aVisitor visitScript: self
]

{ #category : #accessing }
MicScriptBlock >> title [
	^ arguments at: 'title' ifAbsent: [ '' ]
]
