"
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
	
## Reference based 
	.... the figure is blue ...
	We should not wrtie the section 6.1 
	We should not write section 6.1 but Section 6.1
	
	Table, Figure, Section 
	In microdown on ecrit
	
		Section *@sec:name@* and the system will generate Section 6.1
		Implementation idea:
			the checker visitor should look for all the text before an reference anchor. 
	
	
	Write ""Section 6.1"", not ""section 6.1"".
	Write ""Figure 6-2"", not ""figure 6-2"".
	
	
	
	
## Should not use

	protocol -> should not be used
	

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

* Methods do not have a period on the last line.

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


## Case for header

Rule states that level: x should be sentence case. 
Rule states that level: x should be Uppercase case. 


- Rule 1. Use sentence case for headers, e.g. ""Editable tables"", not ""Editable Tables"".
- Rule 2. Use upper case for headers, e.g.  ""Editable Tables"", not ""Editable tables"".

## Stop word should not be Uppercased

of on for in should not be uppercase in title

``` 
## Explanation of Rules in Pharo
```

and not 

``` 
## Explanation Of Rules In Pharo
```


## English Typography 

- Do not write a space before a colon, e.g. ""the following code:"", not ""the following code :"". In 
- Do not write a space before comma eg ""the following code ,"" -> ""the following code,""
- Always have a space after a comma
- Never put a space before a ?!:;

- Always put a space befor a ?!:;


## use note in microdown

 Stef should check Start a note with ""**Note.**"".


"
Class {
	#name : 'Ideas',
	#superclass : 'Object',
	#category : 'Microdown-Rules-BogusImplementation',
	#package : 'Microdown-Rules',
	#tag : 'BogusImplementation'
}
