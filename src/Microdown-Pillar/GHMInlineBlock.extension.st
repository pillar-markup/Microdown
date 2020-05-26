Extension { #name : #GHMInlineBlock }

{ #category : #'*Microdown-Pillar' }
GHMInlineBlock >> asPillar [
	self kind = #plain
		ifTrue: [ ^ PRText new text: self literal ].
	(#(#bold #italics #block #strike) includes: self kind)
		ifTrue: [ ^ (self class pillarNodeFromKind: self kind) new
				setChildren: {(PRText new text: self literal)};
				yourself ]
]

{ #category : #'*Microdown-Pillar' }
GHMInlineBlock class >> pillarNodeFromKind: kind [
	kind = #plain
		ifTrue: [ ^ PRText ].
	kind = #bold
		ifTrue: [ ^ PRBoldFormat ].
	kind = #italics
		ifTrue: [ ^ PRItalicFormat ].
	kind = #block
		ifTrue: [ ^ PRMonospaceFormat ].
	kind = #strike
		ifTrue: [ ^ PRStrikethroughFormat ].
	
	kind = #image ifTrue: [ ^PRFigure  ].
	kind = #link ifTrue: [ ^PRExternalLink   ].
]
