"
# Microdown Parser and Elements

I'm a parser for Microdown, implemented by S. Ducasse, L. Dargaud and G. Polito (2020). 
It is based on K. Osterbye's work on GitHubMarkdown. 

Microdown covers Markdown basis syntax, with great Pillar's features. It's more extensible too.

## MicroDown Syntax in a Nutshell!

**Headers** (up to 6 levels) >>>> `# Header level 1`

**Unordered list**
```
- item a
  on another line
- item b
   - item b1
   - item b2
- item c
```

produces

- item a
  on another line
- item b
   - item b1
   - item b2
- item c

**Ordered list**
```
1. item one
   1. subitem
2. item two
```
produces 

1. item one
   1. subitem
2. item two


**Codeblock with arguments**
```
 ```language=Pharo&caption=Beautiful&label=Fig1
 some piece of code
 ```
```

produces 

```language=Pharo&caption=Beautiful&label=Fig1
some piece of code
```

**Anchor and its reference** >>>> `\@anchor` and its reference in text with `\*@anchor@*`

**Math environment** (rendered with LaTex in Pharo)
- inline: $\cos(\theta_i+C_3)$ >>>> `\$\cos(\theta_i+C_3)$`
- block: 
```
 $
 \cos(\theta_i+C_3)
 $
```
**Annotated paragraph**
``` 
 !!note Then you can write your note
 on several lines, like a normal paragraph
```
**Quote** to indent some lines
```
> This is
> A nice quote
```
**Environment** (called Annotation for inline)
- inline: `\<?keyword|key1=value1&key2=value2?>`
- block: 
```
 <?keyword|key1=value1&key2=value2
 type your content
 ?>
```
**Metadata** as a block
```
 { 
 type your metadata
 }
```

**Table** **@tocomment**

**Horizontal line** >>> `***` alone on a line will define a separator in your text **@todo**

**Comments** don't appear after parsing >>> `% A commented line`

**Inline formats**
- **bold** >>>> `**bold**`
- _italic_ >>>> `\_italic_`
- `monospace` aka inline code >>>> `\`monospace\``

_Note: inline escape character is back slash: \\ ._
_Note: text in monospace is analyzed for you to generate hypertext Pharo code objects! Isn't it so cool to write a great doc? It is! Click on them!_
- `Point` for classes
- `Point class` for class side
- `Point>>#setX:setY:` for methods
- `#'Microdown-Tests'` for packages

**Raw** for your other code (inline) >>>> `\{{ some code }}`

**Link** >>>> `\[link's name](url|key1=value1&key2=value2)`

**Figure** >>>> `\!\[figure's name](url|key1=value1&key2=value2)`

`![Pharo logo](https://files.pharo.org/media/logo/logo.png)`
produces

![Pharo logo](https://files.pharo.org/media/logo/logo.png)


## Implementation

I follow the design mentioned in [https://github.github.com/gfm](https://github.github.com/gfm), in particular the parsing strategy in appendix A.

In short, the strategy is that at any point in time, we might have a number of children of the root which are ""open"". The deepest in open in the tree is called ""current"". All the parents of current are open. 

When a new line is read we do the following:

1. Check if the new line can be consumed by current.
   - as part of this, a child of current can be made which can consume the new line. for example when consuming \`\`\` the root block node will create, a new code block that will become current and consume the body of the \`\`\` element then close. 
2. If current cannot consume the new line, we close current, move current to its parent, and repeat 1.
3. The root node can consume anything, for instance by making new nodes for storing the new line.
4. The root node is not closed until input is exhausted.

I do not accept lazy definition. I do not accept three different ways to do the same. Except for bulleted list where `*` and `-` are accepted. 

The spec says:
```
-> document
  -> block_quote
       paragraph
         ""Lorem ipsum dolor\nsit amet.""
    -> list (type=bullet tight=true bullet_char=-)
         list_item
           paragraph
             ""Qui *quodsi iracundia*""
      -> list_item
        -> paragraph
             ""aliquando id""
```
Now the implementation for now does not create a paragraph in the list_item element. 

"
Class {
	#name : #MicrodownParser2,
	#superclass : #Object,
	#instVars : [
		'current',
		'root',
		'dispatchTable'
	],
	#category : #'Microdown-Parser'
}
