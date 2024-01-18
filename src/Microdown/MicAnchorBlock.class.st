"
I'm block that represents an anchor to a section. This way text can refer to the anchor to refer to the section. 

```
# A section
@mylovelySection
``` 
"
Class {
	#name : 'MicAnchorBlock',
	#superclass : 'MicSingleLineBlock',
	#instVars : [
		'label',
		'target'
	],
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'visiting' }
MicAnchorBlock >> accept: aVisitor [
 	^ aVisitor visitAnchor: self
]

{ #category : 'public' }
MicAnchorBlock >> addLineAndReturnNextNode: line [
	"# bla
	@myanchor
	"
	label := (line copyFrom: AnchorMarkup size + 1 to: line size) trim.
	^ self
]

{ #category : 'testing' }
MicAnchorBlock >> hasLabel [ 
	label ifNil: [ ^ false ].
	^ true
]

{ #category : 'accessing' }
MicAnchorBlock >> label [
	^ label
]

{ #category : 'accessing' }
MicAnchorBlock >> label: anObject [
	label := anObject
]

{ #category : 'accessing' }
MicAnchorBlock >> target [
	^ target
]

{ #category : 'accessing' }
MicAnchorBlock >> target: aMicHeaderBlock [ 
	target := aMicHeaderBlock
]
