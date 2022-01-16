Class {
	#name : #MicColumnsBlockTest,
	#superclass : #MicAnnotationSubclassTest,
	#category : #'Microdown-Tests-Extensions'
}

{ #category : #tests }
MicColumnsBlockTest >> testSimpleColumn [
	
	| doc |
	doc := Microdown parse:  
'
<?columns

<?column

- col 1 item1 a first list
- col 1 item2 a first list
?>

<?column

- col 2 item1 a first list
- col 2 item2 a first list
?>
?>'.
	self assert: doc children size equals: 1.
	self assert: doc children first class equals: MicColumnsBlock. 
	self assert: doc children first children first class equals: MicColumnBlock.
	self assert: doc children first children first children first class equals: MicUnorderedListBlock.
	self assert: doc children first children second class equals: MicColumnBlock.
]
