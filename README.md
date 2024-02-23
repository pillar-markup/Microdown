# Microdown Parser and Elements

I'm a parser for microdown implemented by S. Ducasse, L. Dargaud and G. Polito. The implementation is based on the work on markdown of K. Osterbye. Microdown is a smaller markdown but it is more extensible. I contain a nice builder and some visitors. 


## Why should you use Microdown

Microdown is a smaller markdown but it is more extensible.
It is used to produce books, slides, websites, doc.
It can be read on github but also on pharo itself using the documentationBrowser

It supports
- Header
- Lists
- Paragraph
- Code with arguments: key=val&key2=val2
...

But also 
- Environment with arguments
- Table
- Anchor
- Annotated paragraph
- Math with arguments
- and more intra block elements such as extensible markups, raw, math, and references.


![Microdown within the Pharo IDE.](screen.png)


## Core Syntax in 2 seconds

```
   	# Header
        @anchor
	% This is line comment

	```language=Pharo&caption=Beautiful&label=Fig1
   	code
	```
   
   	![Pharo is cool](http://pharo.org width=80&label=fig:pharo)
	
   	- list
   	1. ordered list 

  	`in text` and for Pharo hyperlinks to class, method and package: 
  	`Point`, `Point class`, `Point>>#setX:setY:`, `#’Microdown-Tests’ (for packages)

  	References: *@ref@*
	
```

## Full Syntax

### Headers
Similar to markdown headers are composed of `#` space text on one line.
The headers can be from 1 to 6

```
### Header Level3
```
There is not support for other forms of declaration. 

### Anchors
In microdown we can define anchors and reference to them (see References).
There are three ways to create anchors

- `@anchorlabel` will create an anchor to the preceeding element. 
- Figures, mathematical environments, environment can specify label as arguments (`label`)
- Code block can specify label as argument (argument named `label`)

### Various

- % comments
- *** horizontal line
- File meta data is plain JSON

```
{
"date" : "12 december 2025"
}
```

### Math support

- `$$` mathematical environment

```
$$%key=cite&label=refToTheGreatEquation
V_i = C_0 - C_3 
$$
```
- Math in text

```
'abc$	V_i = C_0 - C_3	$def'.
```
will generate LaTeX equivalent.

### Codeblock

Microdown offer the same code block that markdown but arguments can be specified and the annotation should be named. The first line after the \`\`\` can be `language=pharo&label=code1&caption=this is my great piece of code`

The following code is not able to display it because markdown quote block are strange and interpret nested block. So we cannot use quoteblock for quoting!

``` 
   ```language=pharo&label=code1&caption=this is my great piece of code
    codeBlockMarkupString
    ^ '```'
    ```
```
````
```language=pharo&label=code1&caption=this is my great piece of code
codeBlockMarkupString
   ^ '\`\`\`'
```
````


### Extensions

- `{! aTag | parameters!}` is the way to use an extension with parameters
- Environments are defined using `<!tag | parameters !>`

```
<!agenda|title=International Workshop on Smalltalk Technologies

<!day|start=2023 August 29th&title=Monday

<!segment|start=10:30

<!talk|subject=Pharo DataFrame: Past, Present, and Future&length=30&author=Safina, Zaitsev, Ferlicot-Delbecque and Sow&room=Room B!>
<!talk|subject=Improving Performance Through Object Lifetime Profiling: the DataFrame Case&length=30&author=Jordan-Montaño, Palumbo, Polito, Ducasse and Tesone&room=Room B!> <!talk|subject=Garbage Collector Tuning in Pathological Allocation Pattern Applications&length=30&author=Palumbo, Jordan-Montaño, Polito, Tesone and Ducasse&room=Room B!>
!>
!>
!>
```  
- Citations `{!citation|ref=Blac09a!}` -- note that the bib file should be defined in the pillar.conf file


## Known limits

#### Math should be tested

#### Quote block
When a line starts with '> ' it delimits a quoteblock.
The markup is not interpreted. 

#### Codeblock 
Codeblock do not support more than four backticks.


## Development is in Pharo 11 and not in Pharo12!

Pay attention the development of Microdown __must not__ be in P12 else we cannot continue to develop Pillar and Microdown. 
So for now we just ignore Pharo12 and Pharo12 can just load a tag version for example v2.4.2 (that we will produce with the removal of 
buildMicroDownUsing moved to BeautifulComments).

### Loading specific version

To load the latest stable version load the master. If you have trouble loading in latest Pharo just execute the preloading.st script in the .github folder.
This script will remove exiting Microdown package and clear the system.

```Smalltalk
Metacello new
  baseline: 'Microdown';
  repository: 'github://pillar-markup/Microdown:master/src';
  load.
```

The process is the following:
- Development in dev
- When stable dev -> in master
- When we can build books master is tagged.
- Then there is the Pharo integration but this is not the concerns of the Microdown team.


### Loading latest development version

```Smalltalk
Metacello new
	baseline: 'Microdown';
	repository: 'github://pillar-markup/Microdown:dev/src';
	onConflict: [ :ex | ex useIncoming ];
	onUpgrade: [ :ex | ex useIncoming ];
	load.
 ```

## Implementation
I follow the design mentioned in [https://github.github.com/gfm](https://github.github.com/gfm), in particular the parsing strategy in appendix A.

In short, the strategy is that at any point in time, we might have a number of children of the root which are ""open"". The deepest in open in the tree is called ""current"". All the parents of current are open. 

When a new line is read we do the following:

1. Check if the new line can be consumed by current.
	- as part of this a child of current can be made which can consume the new line
2. If current cannot consume the new line, we close current, move current to its parent, and repeat 1.
3. The root node can consume anything, for instance by making new nodes for storing the new line.
4. The root node is not closed until input is exhausted

The other packages in this repository are the extensions made to produce Pillar model. 
Such packages should be moved in the future to other location (probably pillar itself).


