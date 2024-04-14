"
I'm a vistor connecting anchors to their target.
For example in the following situation I will make sure that sec has the header as target.

```
# header
@sec
```

I'm usually invoked in a post parsing phase, so transparent to the user.

"
Class {
	#name : 'MicAnchorLinker',
	#superclass : 'MicrodownVisitor',
	#category : 'Microdown-Visitor',
	#package : 'Microdown',
	#tag : 'Visitor'
}

{ #category : 'visiting' }
MicAnchorLinker >> visitHeader: aHeader [

	| siblings position potentialAnchor | 
	siblings := aHeader parent children.
	position := siblings identityIndexOf: aHeader.
	"header is not the last one"
	siblings size > position
		ifTrue: [ potentialAnchor := siblings at: position + 1.
					potentialAnchor class = MicAnchorBlock 
							ifTrue: [ potentialAnchor target: aHeader ] ]
]
