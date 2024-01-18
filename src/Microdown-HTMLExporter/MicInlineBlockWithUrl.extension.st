Extension { #name : 'MicInlineBlockWithUrl' }

{ #category : '*Microdown-HTMLExporter' }
MicInlineBlockWithUrl >> argumentAt: aKey ifPresent: aBlock [
	"Lookup the given key in the receiver. If it is present, answer the value of evaluating the given block with the value associated with the key. Otherwise, answer self."

	self arguments 
		at: aKey
		ifPresent: aBlock
]

{ #category : '*Microdown-HTMLExporter' }
MicInlineBlockWithUrl >> argumentAt: aKey put: value [
	"Lookup the given key in the receiver. If it is present, answer the value of evaluating the given block with the value associated with the key. Otherwise, answer self."

	self arguments 
		at: aKey
		put: value
]

{ #category : '*Microdown-HTMLExporter' }
MicInlineBlockWithUrl >> hasChildren [
	^ self children notEmpty
]
