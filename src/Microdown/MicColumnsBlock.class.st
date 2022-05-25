"
To support multiple columns in document.

```
<!columns

<!column

- col 1 item1 a first list
- col 1 item2 a first list
!>

<!column

- col 2 item1 a first list
- col 2 item2 a first list
!>
!>
```

Note that a column can have also a width.


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
	#name : #MicColumnsBlock,
	#superclass : #MicEnvironmentBlock,
	#category : #'Microdown-Extensions'
}

{ #category : #accessing }
MicColumnsBlock class >> tag [
	^ #columns
]

{ #category : #visiting }
MicColumnsBlock >> accept: aVisitor [
	^ aVisitor visitColumns: self
]
