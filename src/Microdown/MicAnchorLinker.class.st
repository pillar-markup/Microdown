"
I'm a vistor who connects anchors to their target.
For example, in the following situation, I will make sure that the `sec` label has the header as its target.

```text
# header
@sec
```

I'm usually invoked in a post parsing phase, so it's transparent to the user.
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
