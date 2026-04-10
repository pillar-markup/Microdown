"
I represent an unordered list of items.

#### Example

Typing
```language=text
- first
- second
  on multiple line 
- third
Not in third
- first item of a new list
```

Produces:
- first
- second
  on multiple line 
- third
Not in third
- first item of a new list

Notice how the second line of the second item is indented like the first line.

### Nested lists
A nested item starts aligned with its parent. In the following example, the item on the second level is aligned with its parent (`item1`).

```language=text
- item1
  - second level
    on two lines
- item2
```

Produces:

- item1
  - second level
    on two lines
- item2


"
Class {
	#name : 'MicUnorderedListBlock',
	#superclass : 'MicListBlock',
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'visiting' }
MicUnorderedListBlock >> accept: aVisitor [
 	^ aVisitor visitUnorderedList: self
]

{ #category : 'testing' }
MicUnorderedListBlock >> canConsumeLine: line [
	"to consume this line there must be a UnorderdListItem start at the right indentation"

	line ifEmpty: [ ^ true ].
	^ (super canConsumeLine: line) and: [line trim matchesRegex: '^(\*|^-|^\+) .*']
]
