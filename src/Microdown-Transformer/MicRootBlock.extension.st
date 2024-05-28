Extension { #name : 'MicRootBlock' }

{ #category : '*Microdown-Transformer' }
MicRootBlock >> includeFor: aFile [

	| inclusionVisitor |
	inclusionVisitor := MicFileIncluder new.
	inclusionVisitor topFile: aFile file.
	inclusionVisitor visit: self.
	^ self
]
