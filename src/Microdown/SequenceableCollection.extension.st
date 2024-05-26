Extension { #name : 'SequenceableCollection' }

{ #category : '*Microdown' }
SequenceableCollection >> splitOnFirst: anObject [
	"Split the receiver on the first element that match anObject"
	
	"#(1 2 3 0 4 5 6 0 7) splitOnFirst: 0 >> #(#(1 2 3) #(4 5 6 0 7)) "
	"#(1 2 3 0 4 5 6 0 7) splitOnFirst: 99 >> #(#(1 2 3 04 5 6 0 7) #() "
	
	| element |
	element := self indexOf: anObject.
	element = 0 ifTrue: [ ^ { self. #() } ].
	^ { self copyFrom: 1 to: element -1 . self copyFrom: element + 1 to: self size }  
	
]

{ #category : '*Microdown' }
SequenceableCollection >> splitOnFirst: anObject noneValue: aValue [
	"Split the receiver on the first element that match anObject"
	
	"#(1 2 3 0 4 5 6 0 7) splitOnFirst: 0 noneValue: 33>> #(#(1 2 3) #(4 5 6 0 7)) "
	"#(1 2 3 0 4 5 6 0 7) splitOnFirst: 99 noneValue: #()>> #(#(1 2 3 04 5 6 0 7) #() "
	
	| element |
	element := self indexOf: anObject.
	element = 0 ifTrue: [ ^ { self. aValue } ].
	^ { self copyFrom: 1 to: element -1 . self copyFrom: element + 1 to: self size }  
	
]
