"
I'm an experiment to see if we can have an automatic closing of elements handling correctly
nesting 

for example we want to express

```
_day|title=Day one

__segment|starting=9:00

___talk|title=Foo

___talk|title=Foo

__break

__segment|starting=9:00

___talk|title=Foo

___talk|title=Foo

_day|title=Day two

__segment|starting=9:00

___talk|title=Foo

___talk|title=Foo

```

and we should get following tree structure

```
Day one
	segment
		talk
		talk
	break
	segment
		talk
		talk
Day two 
	segment
		talk
		talk
```


"
Class {
	#name : 'MicFullNester2',
	#superclass : 'Object',
	#instVars : [
		'currentRoots'
	],
	#category : 'Microdown-BeamerExporter-Experience',
	#package : 'Microdown-BeamerExporter',
	#tag : 'Experience'
}

{ #category : 'initialization' }
MicFullNester2 >> initialize [

	super initialize.
	currentRoots := Array new: 10. 
	
]

{ #category : 'as yet unclassified' }
MicFullNester2 >> newDocument [ 

	^ currentRoots first
]

{ #category : 'as yet unclassified' }
MicFullNester2 >> treatChildrenOf: aRoot [
	
	| root |
	root := MicRootBlock new.
	root properties: aRoot properties.
	currentRoots at: 1 put: root. 
	aRoot children do: [ :each | self treatElement: each ].
	
]

{ #category : 'as yet unclassified' }
MicFullNester2 >> treatElement: each [
	"for now we only consider that all element do have a level"

	(currentRoots at: each level) addChild: each. 
	currentRoots at: each level + 1 put: each.
]
