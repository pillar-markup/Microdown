"
I'm a bloc element that represents a column. I have one optional argument that is the width of the column. I should be nested in a ColumnsBlock element.

```
<?columns
<?column|width=80

- col 1 item1 a first list
- col 1 item2 a first list
?>
?>
```
"
Class {
	#name : #MicColumnBlock,
	#superclass : #MicEnvironmentBlock,
	#category : #'Microdown-Extensions'
}

{ #category : #accessing }
MicColumnBlock class >> tag [
	^ #column
]

{ #category : #accessing }
MicColumnBlock >> accept: aVisitor [
	^ aVisitor visitColumn: self
]

{ #category : #accessing }
MicColumnBlock >> width [
	^ arguments at: #width
]

{ #category : #accessing }
MicColumnBlock >> width: anObject [
	arguments at: #width put: anObject
]
