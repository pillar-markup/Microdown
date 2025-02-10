## Microdown

Microdown is the Pharo version of markdown. In general, it is very close to the GitHub markdown, with two major differences and a number of smaller ones.
Now pay really attention that Microdown is used by the Pillar compilation chain to produce books in PDF, HTML,..., presentations, websites, class comments in Phar. Microdown is not limited to Github rendering. 
Now it tries its best to achieve a good compromise between rendering on Github, and expressiveness in the other cases. 

### Principal differences
Microdown supports metadata for figures, equations, ... It allows one to have anchors.
It supports by default cross-referencing. 

Microdown has a number of extension points to allow new functionality to be added without introducing new markdown syntax. These extensions can be the level of main block such as environments or as inline element (such as footnote or citation). 

In particular, Microdown has support for LaTeX, Pharo-defined color highlighting of embedded code, inclusion of one document into another.

### Syntax
*@[The Syntax Chapter](syntax.md)@* defines the syntax of Microdown.
*@[This Extension Chapter](extension.md)@* defines the extension mechanisms of Microdown.


### Available checkers
Based on this Microdown offers document checkers as shown in Chapter *@[Validation](validation.md)@*. 
By default a checker will report:
- Duplicated anchors,
- References to unknown anchors,
- Unreferenced figures,
- Figures referencing unknown files,
- References to unknown included file,
- Invalid code snippets (acting as tests for code samples),
- Copied method diverging from their source.

## API
An important aspect of Microdown is its API, which allows you to work with Microdown from within Pharo.
*@[The Chapter API](api.md)@* explains the overall architecture of Microdown and the key methods.