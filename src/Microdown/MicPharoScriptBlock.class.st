"
I am a block containing a Pharo expression.

A script showing my visitors:
```pharoscript|show=both
(Microdown builder  in:  [ :aBuilder |
	aBuilder unorderedListDuring: [
		(MicrodownVisitor allSubclasses 
		select: [ :class |  class includesSelector: #visitScript: ])
		do:  [:class |  aBuilder  item:  [ aBuilder monospace:  (class name, '>>#visitScript:') 
]]]]) contents
```
 
Or generating a morph:
```pharoscript|width=100&show=both
Morph new
```
 
"
Class {
	#name : 'MicPharoScriptBlock',
	#superclass : 'MicScriptBlock',
	#category : 'Microdown-Extensions',
	#package : 'Microdown',
	#tag : 'Extensions'
}

{ #category : 'accessing' }
MicPharoScriptBlock class >> tag [

	^ #pharoscript
]

{ #category : 'visiting' }
MicPharoScriptBlock >> accept: aVisitor [
	^ aVisitor visitPharoScript: self
]

{ #category : 'accessing' }
MicPharoScriptBlock >> title [
	^ arguments at: 'title' ifAbsent: [ '' ]
]
