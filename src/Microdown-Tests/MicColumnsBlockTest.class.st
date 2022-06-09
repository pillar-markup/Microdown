Class {
	#name : #MicColumnsBlockTest,
	#superclass : #TestCase,
	#category : #'Microdown-Tests-Extensions'
}

{ #category : #tests }
MicColumnsBlockTest >> testSimpleColumn [
	
	| doc |
	doc := Microdown parse:  
'
<!columns

<!column

- col 1 item1 a first list
- col 1 item2 a first list
!>

<!column

- col 2 item1 a first list
- col 2 item2 a first list
!>
!>'.
	self assert: doc children size equals: 1.
	self assert: doc children first class equals: MicColumnsBlock. 
	self assert: doc children first children first class equals: MicColumnBlock.
	self assert: doc children first children first children first class equals: MicUnorderedListBlock.
	self assert: doc children first children second class equals: MicColumnBlock.
	self assert: doc children first children second children first class equals: MicUnorderedListBlock.
]

{ #category : #tests }
MicColumnsBlockTest >> testSimpleColumnWithWidth [
	
	| doc |
	doc := Microdown parse:  
'
<!columns

<!column|width=80

- col 1 item1 a first list
- col 1 item2 a first list
!>

<!column|width=20

- col 2 item1 a first list
- col 2 item2 a first list
!>
!>'.
	self assert: doc children size equals: 1.
	self assert: doc children first class equals: MicColumnsBlock. 
	self assert: doc children first children first class equals: MicColumnBlock.
	self assert: doc children first children first width equals: '80'.
	self assert: doc children first children second class equals: MicColumnBlock.
	self assert: doc children first children second width equals: '20'.
	
]
