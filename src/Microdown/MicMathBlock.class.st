"
I'm a math environment. I'm a block, which means that I start on a new line with the `$$` markup, take optional parameters, and end on a new line with the same markup. 
My body can be on multiple lines and can contain LaTeX expressions.
In particular, this means that my body does not contain nested elements.

Here is an example 

```text
$$
V_i = C_0 - C_3
$$
```

Produces: 

$$
V_i = C_0 - C_3
$$
 
If you want to have a label and references to an equation as in LaTeX, you should prefix the parameter with `%` (otherwise it breaks on GitHub).



```text
$$ % label=theEq
V_i = C_0 - C_3
$$

See *@theEq@*
```
"
Class {
	#name : 'MicMathBlock',
	#superclass : 'MicSameStartStopMarkupBlock',
	#category : 'Microdown-Model',
	#package : 'Microdown',
	#tag : 'Model'
}

{ #category : 'visiting' }
MicMathBlock >> accept: aVisitor [ 
 	^ aVisitor visitMath: self
]

{ #category : 'handle' }
MicMathBlock >> anchor [
	| anchor |
	anchor := self arguments 
		at: #anchor 
		ifAbsent: [ nil ].
	"for backward compatibility"
	anchor ifNil: [ anchor := self arguments at: #label ifAbsent: [ nil ] ].
	^ anchor 
]

{ #category : 'handle' }
MicMathBlock >> anchor: aString [

	arguments at: #anchor put: aString.
	arguments removeKey: #label ifAbsent: [].
]

{ #category : 'handle' }
MicMathBlock >> anchorLabel [
	"This should only be invoked when checking references"
	^ self anchor
]

{ #category : 'handle' }
MicMathBlock >> extractFirstLineFrom: aLine [

	| lineWithoutMarkup |
	lineWithoutMarkup := super extractFirstLineFrom: aLine.
	lineWithoutMarkup := lineWithoutMarkup withoutPrefix: '%'.
	arguments := MicArgumentList 
		split: lineWithoutMarkup.
	^ lineWithoutMarkup
]

{ #category : 'testing' }
MicMathBlock >> hasAnchor [
	^ self anchor isNotNil
]

{ #category : 'markups' }
MicMathBlock >> lineStartMarkup [
	
	^ MathOpeningBlockMarkup
]
