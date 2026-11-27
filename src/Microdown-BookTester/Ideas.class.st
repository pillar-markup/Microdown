"
## Reference based 
	.... the figure is blue ...
	We should not wrtie the section 6.1 
	
```
We should not write the section/the table/the figure/ *@secbla@*
```	
	We should not write section 6.1 but Section 6.1
	
	
	
	
	Table, Figure, Section 
	In microdown on ecrit
	
		Section *@sec:name@* and the system will generate Section 6.1
		Implementation idea:
			the checker visitor should look for all the text before an reference anchor. 
	
	
	Write ""Section 6.1"", not ""section 6.1"".
	Write ""Figure 6-2"", not ""figure 6-2"".
	
	
	
## Should not use
The text should not use a given vocabulary

	categories -> should not be used
	


## Method reference

- Always use For method `SpPresenter>>methodName` and not `SpPresenter>>#methodName`

- Always use For method `SpPresenter>>#methodName` and not `SpPresenter>>methodName`


## Use tabs to indent code

The beginning of the lines in code block should not start or contain spaces before a letter ou un 1

```
foo 
  self 
```

=> 
```
foo 
	self 
```

the following code is correct and should not be flagged.

```
foo 
	self nextPut: ' '
```




## Code rule

* Methods without comment have an empty line after the method selector.

```
goodWordFor: aString 
	| pair |
	pair := pairs detect: [ :each | each key = aString ].
	^ pair value.
```

=> 

```
goodWordFor: aString 
	
	| pair |
	pair := pairs detect: [ :each | each key = aString ].
	^ pair value.
```

```
goodWordFor: aString 
	""there is a comment""
	| pair |
	pair := pairs detect: [ :each | each key = aString ].
	^ pair value.
```


## Case for headers

Rule states that level: x should be sentence case. 

Rule states that level: x should be Uppercase case. 


- Rule 1. Use sentence case only for first words of headers, e.g. ""Editable tables"", not ""Editable Tables"".

- Rule 2. Use upper case for all the words of headers, e.g.  ""Editable Tables"", not ""Editable tables"".

### Stop words should not be Uppercased

'of' 'on' 'for' 'in' should not be uppercase in title

``` 
## Explanation of Rules in Pharo
```

and not 

``` 
## Explanation Of Rules In Pharo
```


## French Typography 

- Always write a space before a colon. semi colon exclamation interogation mark , e.g. ""the following code :"", not ""the following code:"". In 
- Do not write a space before comma eg ""the following code ,"" -> ""the following code,""
- Always have a space after a comma after ,.:;?!






- Always put a space befor a ?!:;


## use note in microdown

 Stef should check Start a note with ""**Note.**"".


## Period for labelled paragraphs

Depending on the convention we should check that there is a period or not after Color in the example before.
This can be true for hevel 4, 5, 6. 

```
### This is title


#### Color. 
lkjlkjlkjlkj
```



# Rules already implemented

## Methods should not have a period on the last line.

```
goodWordFor: aString 
	
	| pair |
	pair := pairs detect: [ :each | each key = aString ].
	^ pair value.
```

=>

```
goodWordFor: aString 
	
	| pair |
	pair := pairs detect: [ :each | each key = aString ].
	^ pair value
```

## Pair based rules. 

* Use American English, e.g. ""colors"", not ""colours"". Pharo's class names and method selectors are written in American English too.

- pair enumeration 
	colour -> color
	behaviour -> behavior
	centre -> center
	visualise -> visualize
   allow to -> allow one to
	allowed to -> allowed one to
	allows to -> allows one to


## English Typography 

- Do not write a space before a colon, e.g. ""the following code:"", not ""the following code :"". In 
- Do not write a space before comma eg ""the following code ,"" -> ""the following code,""
- Always have a space after a comma
- Never put a space before a ?!:;


"
Class {
	#name : 'Ideas',
	#superclass : 'Object',
	#category : 'Microdown-BookTester-Core',
	#package : 'Microdown-BookTester',
	#tag : 'Core'
}
