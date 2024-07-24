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
	#name : 'MicNestingPreparer2',
	#superclass : 'Object',
	#instVars : [
		'currentRoots'
	],
	#category : 'Microdown-BeamerExporter',
	#package : 'Microdown-BeamerExporter'
}

{ #category : 'initialization' }
MicNestingPreparer2 >> initialize [

	super initialize.
	currentRoots := Array new: 10. 
	
]

{ #category : 'initialization' }
MicNestingPreparer2 >> newDocument [ 

	^ currentRoots first
]

{ #category : 'visiting' }
MicNestingPreparer2 >> treatChildrenOf: aRoot [
	
	| root |
	root := MicRootBlock new.
	root properties: aRoot properties.
	currentRoots at: 1 put: root. 
	aRoot children do: [ :each | self treatElement: each ].
	
]

{ #category : 'visiting' }
MicNestingPreparer2 >> treatElement: each [
	"for now we only consider that all element do have a level"

	(currentRoots at: each level) addChild: each. 
	currentRoots at: each level + 1 put: each.
]
