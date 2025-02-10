## About extension mechanisms

Microdown  is inspired by GitHub markdown. Unlike GitHub markdown which is only intended to generate html, microdown is used also for in-image rendering, latex generation (books and slides for example), but also html as GitHub. While the core of Microdown and Markdown is the same, Microdown has 3 extension mechanisms for paragraph level blocks, and one inline extension mechanism.

### Inline extension

The inline extension mechanism is  `MicAnnotationBlock`. As its name indicates, its intended purpose is to provide new node. Its syntax is `{!annotationName|arg1=value1&arg2=value2&...!}`. 

#### Mechanism
To make an annotation type, a number of steps must be done. Here we will go through the steps of implementing an annotation for providing giving a footnote in the form: `{!footnote|note=It is cool to be cool!}`.  The class is implemented in the package `Microdown` under tag `Extensions` as `MicFootnoteBlock`.

- Subclass of `MicAnnotationBlock`. For footnote to be recognised as an annotation, it must be a subclass of `MicAnnotationBlock`.
- class side method `tag`.  To find the class implementing 'footnote', `MicAnnotationBlock` will look through its subclasses for the class whoes tag method returns 'footnote'.
- class side method `key` should return the default key of the extension. This way the writer can omit it.  
- instance side method `accept:` - this is part of the visitor framework. As in this case, it introduces an extension specific visit method (`visitFootnote:`). 
- footnote specific functionality. The footnote can be given a 'note' argument. Its implementation of a `note` accessor is good practice.

Note that recent versions of Microdown support optional key, therefore `{!footnote|note=This is cool!}` is equivalent to `{!footnote|This is cool!}`.

### Connecting the appropriate visitor
To actually give the extension meaning, it must be implemented in one or more visitors. One implementation of foodnotes can be seen in `MicRichTextComposer>>#visitFootnote:`. It pulls the note from the footnote block, and makes clickable {!footnote|note=Keep morphic balloons alive :-)!}


### Block extensions

Microdown has three paragraph extension points
- MicCodeBlock `\`\`\`` which one can extend with custom **stylers**. That is, the intended usage is that the body of the code block is styled (typically colored), and the body is not treated as Microdown (is not parsed).
- MicEnvironmentBlock `<!...!>` is intended for making custom markdown by subclassing MicEnvironmentBlock, tagging and MicArgumentList to concert the instantiation of the extension. The body of this block is treated as Microdown and is parsed.
- MicMathBlock (was recently changed from `&...&` to `$$...$$` to stay compatible with github markdown). Math block has been designed to do latex math, hence its name. However, is an extension point as latex is merely the default. The body of math block is not intended to be parsed by microdown but latex. The output is not intended to be just coloured, but completely transformed (for Latex into an image of the formula).

### Mechanism
The mechanism for extending an Environment or the MathBlock (to do something else than Math) is pretty much the same as for annotations. 
- Make a subclass of `MicEnvironmentBlock` or `MicMathBlock`.
- Implement the tag on the class side
- Implememnt necessary accessors to help implement the visitors
- Implement `accept:` to interface to the visitor (calling a `visitMyNewExtension:`)
- Implement `visitMyNewExtension:`.

### Example: support for source code extraction

`MicSourceMethodBlock` allows source code to be inserted into Microdown using an extension of the form:
```text
<!source|class=MicSourceMethodBlock&method=tag&side=class!>
```
Yielding:
<!source|class=MicSourceMethodBlock&method=tag&side=class!>

The key implementation overrides a few methods. `MicSourceMethodBloc>>#closeMe` is called by the parser to provide a hook to set up instance variables and other fields after the block has been parsed.
<!source|class=MicSourceMethodBlock&method=closeMe!>

The super `closeMe` sets up the arguments, so it should always go first. Next we simply build the codeblock, parses it, and make the codeblock be the children of this MicSourceMethodBlock. There is actually only one child, the codeblock.

The `accept:` method specifies that visiting should be done by visiting the children (the code block).

<!source|class=MicSourceMethodBlock&method=accept:!>

### Example: support for PlantUml diagrams

[PlantUmlMicrodownExtension](https://github.com/kasperosterbye/PlantUmlMicrodownExtension) is a simple example of extending MicMathBlock to render [plantuml](https://plantuml.com) diagrams inlined in Microdown.

It uses the tag plantUml:
```Method
tag 
	^#plantuml
```

and the accept: just tells to `visitPlantUML:`.

In addition it defines `visitPlantUML:` as an extension method on `MicRichTextComposer`

```Method
visitPlantUML:  plantUMLNode 

	| aString diagramRef anchoredImage |
	aString := plantUMLNode body.
	aString ifEmpty: [ ^self ].
	diagramRef := (PlantUMLBridge pngFromSource: aString) asMicResourceReference.
	anchoredImage := diagramRef loadImage.
	canvas << ((String value: 1) asText
		addAttribute: (TextAnchor new anchoredMorph: anchoredImage))
```

The `body` of an extension of `MicMathBlock` is all the text between the two `$$`, which in this case is assumed to be a plantUML script. The visit method is rather similar to the standard implementation of Math/Latex support.

